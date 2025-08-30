import { useBackend } from 'tgui/backend';
import { Button, LabeledList, Stack } from 'tgui-core/components';

import { digestModeToColor } from '../constants';
import type { selectedData } from '../types';

<<<<<<< HEAD
export const VoreSelectedBellyControls = (props: { belly: selectedData }) => {
  const { act } = useBackend();

  const { belly } = props;
  const { belly_name, mode, item_mode, addons } = belly;
=======
export const VoreSelectedBellyControls = (props: {
  bellyDropdownNames: DropdownEntry[];
  editMode: boolean;
  belly_name: string;
  display_name: string;
  bellyModeData: bellyModeData;
}) => {
  const { act } = useBackend();

  const {
    bellyDropdownNames,
    belly_name,
    display_name,
    bellyModeData,
    editMode,
  } = props;
  const {
    mode,
    item_mode,
    addons,
    name_length,
    name_min,
    mode_options,
    item_mode_options,
  } = bellyModeData;

  const bellyNames = bellyDropdownNames.map((belly) => {
    return belly.displayText;
  });
>>>>>>> 8724a009b4 ([MIRROR] allow vorebelly display names (#11541))

  return (
    <LabeledList>
      <LabeledList.Item
        label="Name"
        buttons={
          <Stack>
            <Stack.Item>
              <Button
                icon="arrow-up"
                tooltipPosition="left"
                tooltip="Move this belly tab up."
                onClick={() => act('move_belly', { dir: -1 })}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="arrow-down"
                tooltipPosition="left"
                tooltip="Move this belly tab down."
                onClick={() => act('move_belly', { dir: 1 })}
              />
            </Stack.Item>
          </Stack>
        }
      >
        <Button onClick={() => act('set_attribute', { attribute: 'b_name' })}>
          {belly_name}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item label="Display Name">
        <VorePanelEditText
          editMode={editMode}
          limit={name_length}
          entry={display_name}
          action={'set_attribute'}
          subAction={'b_display_name'}
          tooltip={
            'Adjust the optional display name of your belly. This will be shown in chat if set instead of the original name [' +
            name_min +
            '-' +
            name_length +
            ' characters].'
          }
        />
      </LabeledList.Item>
      <LabeledList.Item label="Mode">
        <Button
          color={digestModeToColor[mode]}
          onClick={() => act('set_attribute', { attribute: 'b_mode' })}
        >
          {mode}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item label="Mode Addons">
        {(addons.length && addons.join(', ')) || 'None'}
        <Button
          onClick={() => act('set_attribute', { attribute: 'b_addons' })}
          ml={1}
          icon="plus"
        />
      </LabeledList.Item>
      <LabeledList.Item label="Item Mode">
        <Button
          onClick={() => act('set_attribute', { attribute: 'b_item_mode' })}
        >
          {item_mode}
        </Button>
      </LabeledList.Item>
      <LabeledList.Item>
        <Button.Confirm
          fluid
          icon="exclamation-triangle"
          confirmIcon="trash"
          color="red"
          confirmContent="This is irreversable!"
          onClick={() => act('set_attribute', { attribute: 'b_del' })}
        >
          Delete Belly
        </Button.Confirm>
      </LabeledList.Item>
    </LabeledList>
  );
};
