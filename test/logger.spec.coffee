log = require( '../index' )

log.setConfig( 'conf.json' )

# 使用指定分类的log
logger = log.getLogger('express-log')

# 使用内置的log，无需指定分类名
anotherLogger = log.getLogger()

# 指定log的category和errorLevel
fileLogger = log.getLogger( {
    category: 'file-logger'
    errorLevel: 'INFO'
} )

logger.trace( 'Entering %d cheese %d testing', 1, 2 )
logger.debug( 'Got cheese.' )
logger.info( 'Cheese is Gouda.' )
logger.warn( 'Cheese is quite smelly.' )
logger.error( 'Cheese is too ripe!' )
logger.fatal( 'Cheese was breeding ground for listeria.' )

anotherLogger.info( 'Getting a info...' )
anotherLogger.debug( 'Getting a debug...' )
anotherLogger.error( 'Cheese is too ripe!' )
anotherLogger.fatal( 'Cheese was breeding ground for listeria.' )

fileLogger.trace( 'Entering %d cheese %d testing', 1, 2 )
fileLogger.debug( 'Got cheese.' )
fileLogger.info( 'Cheese is Gouda.' )
fileLogger.warn( 'Cheese is quite smelly.' )
fileLogger.error( 'Cheese is too ripe!' )
fileLogger.fatal( 'Cheese was breeding ground for listeria.' )


log.setConfig( 'anotherconf.json' )

anotherFileLogger = log.getLogger('file-logger-2')

anotherFileLogger.trace( 'Entering %s cheese %s testing', 'A', 'for' )
anotherFileLogger.debug( 'Got cheese.' )
anotherFileLogger.info( 'Cheese is Gouda.' )
anotherFileLogger.warn( 'Cheese is quite smelly.' )
anotherFileLogger.error( 'Cheese is too ripe!' )
anotherFileLogger.fatal( 'Cheese was breeding ground for listeria.' )