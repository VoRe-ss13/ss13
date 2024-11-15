#ifndef CITESTING

/*********************/
/* MAP SELECTION     */
/* FOR LIVE SERVER   */
/*********************/

<<<<<<< HEAD
// #define USE_MAP_SOUTHERN_CROSS
// #define USE_MAP_SOLUNA_NEXUS
#define USE_MAP_RELIC_BASE
=======
#define USE_MAP_SOUTHERN_CROSS
// #define USE_MAP_SOLUNA_NEXUS
// #define USE_MAP_RELIC_BASE
>>>>>>> 4a33d993dd (Changes the selected to Southern Cross. (#9468))

// Debug
// #define USE_MAP_MINITEST

/*********************/
/* End Map Selection */
/*********************/

#endif

// Southern Cross
#ifdef USE_MAP_SOUTHERN_CROSS
#include "../southern_cross/southern_cross.dm"
#endif

// Soluna Nexus
#ifdef USE_MAP_SOLUNA_NEXUS
#include "../soluna_nexus/soluna_nexus.dm"
#endif

// Relic Base
#ifdef USE_MAP_RELIC_BASE
#include "../../../maps/relic_base/relicbase.dm"
#endif

#ifdef USE_MAP_MINITEST
#include "../virgo_minitest/virgo_minitest.dm"
#endif
