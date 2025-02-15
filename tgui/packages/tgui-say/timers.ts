import { debounce, throttle } from 'tgui-core/timer';

const SECONDS = 1000;

/** Timers: Prevents overloading the server, throttles messages */
export const byondMessages = {
  // Debounce: Prevents spamming the server
  channelIncrementMsg: debounce(
<<<<<<< HEAD
    (visible: boolean, channel: string) =>
=======
    (visible: boolean, channel: Channel) =>
>>>>>>> 9ffe6f5fcb ([MIRROR] cleans up some left over things (#10168))
      Byond.sendMessage('thinking', { visible, channel }),
    0.4 * SECONDS,
  ),
  forceSayMsg: debounce(
    (entry: string) => Byond.sendMessage('force', { entry, channel: 'Say' }),
    1 * SECONDS,
    true,
  ),
  // Throttle: Prevents spamming the server
  typingMsg: throttle(
    (channel: string) => Byond.sendMessage('typing', { channel }),
    4 * SECONDS,
  ),
} as const;
