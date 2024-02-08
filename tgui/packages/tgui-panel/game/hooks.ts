/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
import { useSelector } from 'common/redux';
=======
import { useSelector } from 'tgui/backend';

>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { selectGame } from './selectors';

export const useGame = (context) => {
  return useSelector(context, selectGame);
};
