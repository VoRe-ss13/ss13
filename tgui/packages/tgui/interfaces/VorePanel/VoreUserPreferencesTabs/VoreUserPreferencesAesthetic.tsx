import { useBackend } from 'tgui/backend';
import { Button, Section, Stack } from 'tgui-core/components';

import type { localPrefs, selectedData } from '../types';
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
        <Stack.Item basis="49%" grow>
          <Button fluid icon="grin-tongue" onClick={() => act('setflavor')}>
            Set Taste
          </Button>
        </Stack.Item>
<<<<<<< HEAD
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
=======
        <Stack.Divider />
        <Stack.Item grow>
          <Section fill>
            {!!sanitizeCorruption.corrupted && (
              <Stack.Item>
                <NoticeBox danger>
                  Your {'>' + aestethicMessages.aest_subtab + '<'} messages are
                  corrupted, please edit and save them!
                </NoticeBox>
              </Stack.Item>
            )}
            <VorePanelEditTextTabs
              exactLength
              editMode={editMode}
              messsageOptions={aestethicMessages.possible_messages}
              activeTab={aestethicMessages.aest_subtab}
              tabAction="change_aset_message_option"
              tabsToIcons={aestehticTabsToIcons}
              tooltip={aestethicMessages.tooltip}
              maxLength={aestethicMessages.max_length}
              activeMessage={sanitizeCorruption.data}
              action={aestethicMessages.set_action}
              listAction="b_msgs"
              disableLegacyInput={!Array.isArray(sanitizeCorruption.data)}
              subAction={aestethicMessages.sub_action}
              button_action={aestethicMessages.button_action}
              button_label={aestethicMessages.button_label}
              button_data={!!aestethicMessages.button_data}
              button_tooltip={aestethicMessages.button_tooltip}
            />
          </Section>
>>>>>>> 9d12fa67bb ([MIRROR] Panel tweak (#11066))
        </Stack.Item>
      </Stack>
    </Section>
  );
};
