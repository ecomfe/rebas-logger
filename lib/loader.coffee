_fs = require( 'fs' )
logger = require( './logger' )


loadConfigurationFile = ( filename ) ->
    if filename
        JSON.parse( _fs.readFileSync( filename, "utf8" ) )

LOG_CATEGORY = '_log_'
LOG_EXPRESS_CATEGORY = 'express-log'
LOG_ERR_LEVEL = 'TRACE'
LOG_USER = {
    'type': 'dateFile'
    'filename': 'log'
    'pattern': '-yyyy-MM-dd hh.log'
    'alwaysIncludePattern': true
    'category': LOG_CATEGORY
}
LOG_EXPRESS = {
    'type': 'file'
    'filename': 'express-log.log'
    'category': LOG_EXPRESS_CATEGORY
    "maxLogSize": 2048
}

exports.init = ( filename ) ->
    conf = loadConfigurationFile( filename ) or {}
    conf.appenders ?= []
    conf.appenders.push(LOG_USER)
    conf.appenders.push(LOG_EXPRESS)

    if conf and conf.cwd
        options = {
            cwd: conf.cwd
        }

    logger.setConfig( conf, options )

exports.getLogger = ( options = {} ) ->
    if typeof options is 'string'
        errorLevel = options
        options = {
            errorLevel: errorLevel
        }

    options.category ?= LOG_CATEGORY
    options.errorLevel ?= LOG_ERR_LEVEL

    logger.getLogger( options.category, options.errorLevel )

exports.expressLogger = () ->
    logger.connectLogger( logger.getLogger( LOG_EXPRESS_CATEGORY ), {level: 'auto'} )
