import { Channel } from './ChannelIterator';
import { WINDOW_SIZES } from './constants';

/**
 * Once byond signals this via keystroke, it
 * ensures window size, visibility, and focus.
 */
export const windowOpen = (channel: Channel) => {
  setWindowVisibility(true);
  Byond.sendMessage('open', { channel });
};

/**
 * Resets the state of the window and hides it from user view.
 * Sending "close" logs it server side.
 */
export const windowClose = () => {
  setWindowVisibility(false);
  Byond.winset('map', {
    focus: true,
  });
  Byond.sendMessage('close');
};

/**
 * Modifies the window size.
 */
export const windowSet = (size: number = WINDOW_SIZES.small) => {
  let sizeStr = `${WINDOW_SIZES.width}x${size}`;
  console.log(sizeStr);

  Byond.winset('tgui_say.browser', {
    size: sizeStr,
  });

  Byond.winset('tgui_say', {
    size: sizeStr,
  });
};

/** Helper function to set window size and visibility */
const setWindowVisibility = (visible: boolean) => {
  Byond.winset('tgui_say', {
    'is-visible': visible,
  });
<<<<<<< HEAD
};
=======
}

const CHANNEL_REGEX = /^[:.]\w|,b\s/;

/** Tests for a channel prefix, returning it or none */
export function getPrefix(
  value: string,
): keyof typeof RADIO_PREFIXES | undefined {
  if (!value || value.length < 3 || !CHANNEL_REGEX.test(value)) {
    return;
  }

  let adjusted = value
    .slice(0, 3)
    ?.toLowerCase()
    ?.replace('.', ':') as keyof typeof RADIO_PREFIXES;

  if (!RADIO_PREFIXES[adjusted]) {
    return;
  }

  return adjusted;
}
>>>>>>> 9ffe6f5fcb ([MIRROR] cleans up some left over things (#10168))
