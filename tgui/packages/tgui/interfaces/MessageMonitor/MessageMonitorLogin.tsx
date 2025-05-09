import { useBackend } from 'tgui/backend';
import { Box, Button, Icon, Input } from 'tgui-core/components';

import { FullscreenNotice } from '../common/FullscreenNotice';
import type { Data } from './types';

export const MessageMonitorLogin = (props) => {
  const { act, data } = useBackend<Data>();

  const { isMalfAI } = data;

  return (
    <FullscreenNotice title="Welcome">
      <Box fontSize="1.5rem" bold>
        <Icon
          name="exclamation-triangle"
          verticalAlign="middle"
          size={3}
          mr="1rem"
        />
        Unauthorized
      </Box>
      <Box color="label" my="1rem">
        Decryption Key:
        <Input
          placeholder="Decryption Key"
          ml="0.5rem"
<<<<<<< HEAD
          onChange={(e, val) => act('auth', { key: val })}
=======
          onBlur={(val) => act('auth', { key: val })}
>>>>>>> f5ac9b2555 ([MIRROR] soulcatcher patches and tgui core update (#10853))
        />
      </Box>
      {!!isMalfAI && (
        <Button icon="terminal" onClick={() => act('hack')}>
          Hack
        </Button>
      )}
      <Box color="label">
        Please authenticate with the server in order to show additional options.
      </Box>
    </FullscreenNotice>
  );
};
