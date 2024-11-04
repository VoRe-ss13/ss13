#ifndef CITESTING

/*********************/
/* MAP SELECTION     */
/* FOR LIVE SERVER   */
/*********************/

// #define USE_MAP_SOUTHERN_CROSS
<<<<<<< HEAD
// #define USE_MAP_SOLUNA_NEXUS
#define USE_MAP_RELIC_BASE
=======
#define USE_MAP_SOLUNA_NEXUS
// #define USE_MAP_RELIC_BASE
>>>>>>> 33bea54f0f (Revert "Halloweenifies the station" (#9315))

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

//TORCHEdit Start - Add and select Forbearance //TODO - Decide about moving relic_base to modular_chomp or not
// Relic Base
#ifdef USE_MAP_RELIC_BASE
#include "../../../maps/relic_base/relicbase.dm"
#endif
//TORCHEdit End

#ifdef USE_MAP_MINITEST
#include "../virgo_minitest/virgo_minitest.dm"
#endif
