import { useBackend } from 'tgui/backend';
import { Button, Section, Stack } from 'tgui-core/components';

import type { localPrefs, selectedData } from '../types';
import { VoreUserPreferenceItem } from '../VoreUserPreferenceItem';

export const VoreUserPreferencesAesthetic = (props: {
<<<<<<< HEAD
=======
  editMode: boolean;
  persist_edit_mode: BooleanLike;
  toggleEditMode: React.Dispatch<React.SetStateAction<boolean>>;
  active_belly: string | null;
  our_bellies: bellyData[];
>>>>>>> 17a58042c3 ([MIRROR] vorepanel hotfix (#10970))
  belly_rub_target: string | null;
  selected: selectedData | null;
  preferences: localPrefs;
}) => {
<<<<<<< HEAD
  const { act } = useBackend();
  const { belly_rub_target, selected, preferences } = props;

  return (
    <Section title="Aesthetic Preferences">
      <Stack wrap="wrap" justify="center">
        <Stack.Item basis="49%" grow>
          <Button fluid icon="grin-tongue" onClick={() => act('setflavor')}>
            Set Taste
          </Button>
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
    return belly.name;
  });

  const locationNames = [...getBellies, 'Current Selected'];

  const capitalizedName = active_belly && capitalize(active_belly);

  return (
    <Section
      fill
      title="Aesthetic Preferences"
      scrollable
      buttons={
        <VorePanelEditToggle
          editMode={editMode}
          persistEditMode={persist_edit_mode}
          toggleEditMode={toggleEditMode}
        />
      }
    >
      <Stack vertical fill>
        <Stack.Item>
          <Stack>
            <Stack.Item basis="49%" grow>
              <LabeledList>
                {vore_icon_options.map((entry) => (
                  <LabeledList.Item key={entry} label={capitalize(entry)}>
                    <Stack align="center">
                      <VorePanelEditColor
                        name_of="sprite color"
                        removePlaceholder
                        editMode={editMode}
                        action="set_vs_color"
                        subAction={entry}
                        back_color={vore_sprite_color[entry]}
                        tooltip={
                          "Modify the sprite color of your '" +
                          entry +
                          "' sprite."
                        }
                        value_of={undefined}
                      />
                      <Stack.Item>
                        <VorePanelEditSwitch
                          hideIcon
                          editMode={editMode}
                          action="toggle_vs_multiply"
                          subAction={entry}
                          active={!!vore_sprite_multiply[entry]}
                          tooltip={
                            "Switch between color multiply and add mode for your '" +
                            entry +
                            "' sprite."
                          }
                          color={!editMode ? 'white' : undefined}
                          content={
                            vore_sprite_multiply[entry] ? 'Multiply' : 'Add'
                          }
                        />
                      </Stack.Item>
                    </Stack>
                  </LabeledList.Item>
                ))}
              </LabeledList>
            </Stack.Item>
            <Stack.Item basis="49%" grow>
              <LabeledList>
                <LabeledList.Item label="Belly Rub Target">
                  <VorePanelEditDropdown
                    action={'set_belly_rub'}
                    icon="crosshairs"
                    editMode={editMode}
                    options={locationNames}
                    entry={
                      belly_rub_target
                        ? belly_rub_target
                        : 'Current Selected (' + capitalizedName + ')'
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Stack.Item>
          </Stack>
>>>>>>> 17a58042c3 ([MIRROR] vorepanel hotfix (#10970))
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
