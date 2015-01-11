_fs = require( 'fs' )
_ = require( 'lodash' )
logger = require( './logger' )

loadConfigurationFile = ( filename ) ->
    if filename
        try
            JSON.parse( _fs.readFileSync( filename, "utf8" ) )
        catch e

LOG_CATEGORY = 'log'
LOG_EXPRESS_CATEGORY = 'express-log'
LOG_ERR_LEVEL = 'TRACE'

initialized = false

configs = {
    appenders: [
        {
            'type': 'dateFile'
            'filename': 'log'
            'pattern': '-yyyy-MM-dd-hh.log'
            'alwaysIncludePattern': true
            'category': LOG_CATEGORY
        }
        {
            'type': 'file'
            'filename': 'core.log'
            'category': LOG_EXPRESS_CATEGORY
        }
        {
            'type': 'console'
            'layout': {
                'type': 'pattern'
                'pattern': '[%d] [%p] %c %m'
            }
        }
    ],
    levels: {},
    replaceConsole: false
}

###
    初始化
    @param {string=} filename 配置文件路径
###
initConfig = () ->
    if initialized
        return

    exports.setConfig()

###
    设置配置文件
    增量添加的方式增加配置项
###
exports.setConfig = ( filename ) ->
    conf = loadConfigurationFile( filename ) or {}

    # 增量合并配置
    configs.appenders = configs.appenders.concat( conf.appenders ?= [] )

    configs.levels = _.merge( configs.levels, conf.levels ?= {} )
    configs.replaceConsole = conf.replaceConsole ?= false

    options = {}

    if conf.cwd
        configs.cwd = conf.cwd

    if configs.cwd
        options.cwd = configs.cwd


    logger.setConfig( _.cloneDeep( configs ), options )

    initialized = true

###
    Logger实例
    @param {Object=|string=} options|category 如果为string 则指定为category
    @param {string=} options.category log分类 可与配置文件中“appenders.category”对应
    @param {string=} options.errorLevel 可log的error_level 可与配置文件中“levels”对应
###
exports.getLogger = ( options = {} ) ->
    initConfig()

    if typeof options is 'string'
        options = {
            category: options
            errorLevel: LOG_ERR_LEVEL
        }
    else
        options.category ?= LOG_CATEGORY
        options.errorLevel ?= LOG_ERR_LEVEL

    logger.getLogger( options.category, options.errorLevel )

###
    Express log模块
    通过express.use()加载log模块
###
exports.expressLogger = () ->
    initConfig()

    logger.connectLogger( logger.getLogger( LOG_EXPRESS_CATEGORY ), {level: 'auto'} )
