log = require( '../index' )


log.init('log.json')

logger = log.getLogger( 'express')
anotherLogger = log.getLogger()

logger.trace( 'Entering %d cheese %d testing', 1, 2 )
logger.debug( 'Got cheese.' )
logger.info( 'Cheese is Gouda.' )
logger.warn( 'Cheese is quite smelly.' )
logger.error( 'Cheese is too ripe!' )
logger.fatal( 'Cheese was breeding ground for listeria.' )


anotherLogger.info( 'Getting a info...' )
anotherLogger.debug( 'Getting a debug...' )
anotherLogger.fatal( 'Cheese was breeding ground for listeria.' )
