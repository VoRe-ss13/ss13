/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
import { useDispatch, useSelector } from 'common/redux';
import { updateSettings, toggleSettings } from './actions';
=======
import { useDispatch, useSelector } from 'tgui/backend';

import { toggleSettings, updateSettings } from './actions';
>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { selectSettings } from './selectors';

export const useSettings = (context) => {
  const settings = useSelector(context, selectSettings);
  const dispatch = useDispatch(context);
  return {
    ...settings,
    visible: settings.view.visible,
    toggle: () => dispatch(toggleSettings()),
    update: (obj) => dispatch(updateSettings(obj)),
  };
};
