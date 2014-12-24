_fs = require( 'fs' )
logger = require( './logger' )

loadConfigurationFile = ( filename ) ->
    if filename
        JSON.parse( _fs.readFileSync( filename, "utf8" ) )

LOG_CATEGORY = 'log'
LOG_EXPRESS_CATEGORY = 'express-log'
LOG_ERR_LEVEL = 'TRACE'
LOG_USER = {
    'type': 'dateFile'
    'filename': 'log'
    'pattern': '-yyyy-MM-dd-hh.log'
    'alwaysIncludePattern': true
    'category': LOG_CATEGORY
}

LOG_EXPRESS = {
    'type': 'file'
    'filename': 'core.log'
    'category': LOG_EXPRESS_CATEGORY
}

LOG_CONSOLE = {
    'type': 'console'
    'layout': {
        'type': 'pattern'
        'pattern': '[%d] [%p] %c %m'
    }
}

initialized = false

###
    初始化
    @param {string=} filename 配置文件路径
###
exports.init = ( filename ) ->
    if initialized
        return

    conf = loadConfigurationFile( filename ) or {}
    conf.appenders ?= []
    conf.appenders.push( LOG_USER )
    conf.appenders.push( LOG_EXPRESS )
    conf.appenders.push( LOG_CONSOLE )

    if conf and conf.cwd
        options = {
            cwd: conf.cwd
        }

    logger.setConfig( conf, options )

    initialized = true

###
    Logger实例
    @param {Object=|string=} options|category 如果为string 则指定为category
    @param {string=} options.category log分类 可与配置文件中“appenders.category”对应
    @param {string=} options.errorLevel 可log的error_level 可与配置文件中“levels”对应
###
exports.getLogger = ( options = {} ) ->
    if !initialized
        exports.init()

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
    if !initialized
        exports.init()

    logger.connectLogger( logger.getLogger( LOG_EXPRESS_CATEGORY ), {level: 'auto'} )
