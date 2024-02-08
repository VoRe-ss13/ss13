/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
import { useSelector, useDispatch } from 'common/redux';
=======
import { useDispatch, useSelector } from 'tgui/backend';

>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { selectAudio } from './selectors';

export const useAudio = (context) => {
  const state = useSelector(context, selectAudio);
  const dispatch = useDispatch(context);
  return {
    ...state,
    toggle: () => dispatch({ type: 'audio/toggle' }),
  };
};
