import { useBackend } from 'tgui/backend';
import { Button, Section, Stack } from 'tgui-core/components';

import type { localPrefs, selectedData } from '../types';
import { VoreUserPreferenceItem } from '../VoreUserPreferenceItem';

export const VoreUserPreferencesAesthetic = (props: {
  belly_rub_target: string | null;
  selected: selectedData | null;
  preferences: localPrefs;
}) => {
<<<<<<< HEAD
  const { act } = useBackend();
  const { belly_rub_target, selected, preferences } = props;
=======
  const {
    editMode,
    persist_edit_mode,
    toggleEditMode,
    active_belly,
    belly_rub_target,
    our_bellies,
    vore_sprite_color,
    vore_sprite_multiply,
    vore_icon_options,
    aestethicMessages,
  } = props;

  const sanitizeCorruption = fixCorruptedData(aestethicMessages.active_message);

  const getBellies = our_bellies.map((belly) => {
    return belly.display_name ? belly.display_name : belly.name;
  });

  const locationNames = [...getBellies, 'Current Selected'];

  const capitalizedName = active_belly && capitalize(active_belly);

  const possibleIconOptions = vore_icon_options.filter(
    (entry) => !!vore_sprite_color[entry],
  );
>>>>>>> 8724a009b4 ([MIRROR] allow vorebelly display names (#11541))

  return (
    <Section title="Aesthetic Preferences">
      <Stack wrap="wrap" justify="center">
        <Stack.Item basis="49%" grow>
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
