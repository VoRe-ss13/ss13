import { useBackend } from 'tgui/backend';
import { Button, Section, Stack } from 'tgui-core/components';

<<<<<<< HEAD:tgui/packages/tgui/interfaces/VorePanel/VoreUserPreferencesTabs/VoreUserPreferencesAesthetic .tsx
import { localPrefs } from '../types';
=======
import type { localPrefs, selectedData } from '../types';
>>>>>>> 2f698760c7 ([MIRROR] Panel port test [IDB IGNORE] (#10447)):tgui/packages/tgui/interfaces/VorePanel/VoreUserPreferencesTabs/VoreUserPreferencesAesthetic.tsx
import { VoreUserPreferenceItem } from '../VoreUserPreferenceItem';

export const VoreUserPreferencesAesthetic = (props: {
  belly_rub_target: string | null;
  selected: selectedData | null;
  preferences: localPrefs;
}) => {
  const { act } = useBackend();
  const { belly_rub_target, selected, preferences } = props;

  return (
    <Section title="Aesthetic Preferences">
      <Stack wrap="wrap" justify="center">
        <Stack.Item
          basis="49%"
          grow
          style={{
            marginLeft: '0.5em', // Remove if tgui core implements gap
          }}
        >
          <Button fluid icon="grin-tongue" onClick={() => act('setflavor')}>
            Set Taste
          </Button>
        </Stack.Item>
        <Stack.Item basis="49%">
          <Button fluid icon="wind" onClick={() => act('setsmell')}>
            Set Smell
          </Button>
        </Stack.Item>
        <Stack.Item basis="49%" grow>
          <Button
            onClick={() =>
              act('set_attribute', { attribute: 'b_msgs', msgtype: 'en' })
            }
            icon="flask"
            fluid
          >
            Set Nutrition Examine Message
          </Button>
        </Stack.Item>
        <Stack.Item basis="49%">
          <Button
            onClick={() =>
              act('set_attribute', { attribute: 'b_msgs', msgtype: 'ew' })
            }
            icon="weight-hanging"
            fluid
          >
            Set Weight Examine Message
          </Button>
        </Stack.Item>
        <Stack.Item basis="49%" grow>
          <VoreUserPreferenceItem spec={preferences.examine_nutrition} />
        </Stack.Item>
        <Stack.Item basis="49%">
          <VoreUserPreferenceItem spec={preferences.examine_weight} />
        </Stack.Item>
        <Stack.Item basis="49%" grow>
          <Button fluid onClick={() => act('set_vs_color')} icon="palette">
            Vore Sprite Color
          </Button>
        </Stack.Item>
        <Stack.Item basis="49%">
          <Button fluid onClick={() => act('set_belly_rub')} icon="crosshairs">
            {'Belly Rub Target: ' +
              (belly_rub_target
                ? belly_rub_target
                : 'Current Active (' + (selected && selected.belly_name) + ')')}
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
