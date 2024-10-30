#ifndef CITESTING

/*********************/
/* MAP SELECTION     */
/* FOR LIVE SERVER   */
/*********************/

// #define USE_MAP_SOUTHERN_CROSS
// #define USE_MAP_SOLUNA_NEXUS
<<<<<<< HEAD
#define USE_MAP_RELIC_BASE
=======
// #define USE_MAP_RELIC_BASE
>>>>>>> a2d798a978 (Map fixes relic1.0 (#9370))

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

<<<<<<< HEAD
//TORCHEdit Start - Add and select Forbearance //TODO - Decide about moving relic_base to modular_chomp or not
// Relic Base
#ifdef USE_MAP_RELIC_BASE
#include "../../../maps/relic_base/relicbase.dm"
#endif
//TORCHEdit End
=======
// Relic Base
#ifdef USE_MAP_RELIC_BASE
#include "../relic_base/relicbase.dm"
#endif
>>>>>>> a2d798a978 (Map fixes relic1.0 (#9370))

#ifdef USE_MAP_MINITEST
#include "../virgo_minitest/virgo_minitest.dm"
#endif
