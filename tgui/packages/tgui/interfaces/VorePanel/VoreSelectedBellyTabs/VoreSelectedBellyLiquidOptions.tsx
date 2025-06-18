import { useBackend } from 'tgui/backend';
<<<<<<< HEAD
import { Button, LabeledList, Section } from 'tgui-core/components';

import { reagentToColor } from '../constants';
import { LiquidColorInput } from '../LiquidColorInput';
import type { selectedData } from '../types';
=======
import { Box, Button, LabeledList, Section, Stack } from 'tgui-core/components';

import { liquidToTooltip, reagentToColor } from '../constants';
import type { bellyLiquidData } from '../types';
import { VorePanelEditCheckboxes } from '../VorePanelElements/VorePanelEditCheckboxes';
import { VorePanelEditSwitch } from '../VorePanelElements/VorePanelEditSwitch';
import { LiquidOptionsLeft } from './LiquidTab/LiquidOptionsLeft';
import { LiquidOptionsRight } from './LiquidTab/LiquidOptionsRight';
>>>>>>> 87f031d72b ([MIRROR] tgui core 4.3.1 (#11083))

export const VoreSelectedBellyLiquidOptions = (props: {
  belly: selectedData;
}) => {
  const { act } = useBackend();

  const { belly } = props;
  const { show_liq, liq_interacts } = belly;

  const generationTime = (liq_interacts.liq_reagent_nutri_rate + 1) * 10;
  const generationMinutes = generationTime % 60;
  const generationHours = Math.floor(generationTime / 60);

  return (
<<<<<<< HEAD
    <Section
      title="Liquid Options"
      buttons={
        <Button
          onClick={() =>
            act('liq_set_attribute', { liq_attribute: 'b_show_liq' })
          }
          icon={show_liq ? 'toggle-on' : 'toggle-off'}
          selected={show_liq}
          tooltipPosition="left"
          tooltip={
            'These are the settings for liquid bellies, every belly has a liquid storage.'
          }
        >
          {show_liq ? 'Liquids On' : 'Liquids Off'}
        </Button>
      }
    >
      {show_liq ? (
        <LabeledList>
          <LabeledList.Item label="Generate Liquids">
            <Button
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_liq_reagent_gen' })
              }
              icon={liq_interacts.liq_reagent_gen ? 'toggle-on' : 'toggle-off'}
              selected={liq_interacts.liq_reagent_gen}
            >
              {liq_interacts.liq_reagent_gen ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Type">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_type',
                })
              }
              icon="pen"
              color={reagentToColor[liq_interacts.liq_reagent_type]}
            >
              {liq_interacts.liq_reagent_type}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Name">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_name',
                })
              }
            >
              {liq_interacts.liq_reagent_name}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Transfer Verb">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_transfer_verb',
                })
              }
            >
              {liq_interacts.liq_reagent_transfer_verb}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Generation Time">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_nutri_rate',
                })
              }
              icon="clock"
            >
              {(generationHours < 10
                ? '0' + generationHours
                : generationHours) +
                ':' +
                (generationMinutes < 10
                  ? '0' + generationMinutes
                  : generationMinutes) +
                ' hh:mm'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Capacity">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_capacity',
                })
              }
            >
              {liq_interacts.liq_reagent_capacity}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Slosh Sounds">
            <Button
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_liq_sloshing' })
              }
              icon={liq_interacts.liq_sloshing ? 'toggle-on' : 'toggle-off'}
              selected={liq_interacts.liq_sloshing}
            >
              {liq_interacts.liq_sloshing ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Addons">
            {(liq_interacts.liq_reagent_addons.length &&
              liq_interacts.liq_reagent_addons.join(', ')) ||
              'None'}
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_liq_reagent_addons',
                })
              }
              ml={1}
              icon="plus"
            />
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Application to Prey">
            <Button
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_reagent_touches' })
              }
              icon={liq_interacts.reagent_touches ? 'toggle-on' : 'toggle-off'}
              selected={liq_interacts.reagent_touches}
            >
              {liq_interacts.reagent_touches ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Custom Liquid Color">
            <LiquidColorInput
              action_name="b_custom_reagentcolor"
              value_of={null}
              back_color={liq_interacts.custom_reagentcolor}
              name_of="Custom Liquid Color"
            />
          </LabeledList.Item>
          <LabeledList.Item label="Liquid Overlay">
            <Button
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_liquid_overlay' })
              }
              icon={liq_interacts.liquid_overlay ? 'toggle-on' : 'toggle-off'}
              selected={liq_interacts.liquid_overlay}
            >
              {liq_interacts.liquid_overlay ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Max Liquid Level">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_max_liquid_level',
                })
              }
            >
              {liq_interacts.max_liquid_level + '%'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Custom Liquid Alpha">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_custom_reagentalpha',
                })
              }
            >
              {liq_interacts.custom_reagentalpha}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Fullness Overlay">
            <Button
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_mush_overlay' })
              }
              icon={liq_interacts.mush_overlay ? 'toggle-on' : 'toggle-off'}
              selected={liq_interacts.mush_overlay}
            >
              {liq_interacts.mush_overlay ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Mush Overlay Color">
            <LiquidColorInput
              action_name="b_mush_color"
              value_of={null}
              back_color={liq_interacts.mush_color}
              name_of="Custom Mush Color"
            />
          </LabeledList.Item>
          <LabeledList.Item label="Mush Overlay Alpha">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_mush_alpha',
                })
              }
            >
              {liq_interacts.mush_alpha}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Mush Overlay Scaling">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_max_mush',
                })
              }
            >
              {liq_interacts.max_mush}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Minimum Mush Level">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_min_mush',
                })
              }
            >
              {liq_interacts.min_mush + '%'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Item Mush Value">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_item_mush_val',
                })
              }
            >
              {liq_interacts.item_mush_val + ' fullness per item'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Metabolism Overlay">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_metabolism_overlay',
                })
              }
              icon={
                liq_interacts.metabolism_overlay ? 'toggle-on' : 'toggle-off'
              }
              selected={liq_interacts.metabolism_overlay}
            >
              {liq_interacts.metabolism_overlay ? 'On' : 'Off'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Metabolism Mush Ratio">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_metabolism_mush_ratio',
                })
              }
            >
              {liq_interacts.metabolism_mush_ratio +
                ' fullness per reagent unit'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Metabolism Overlay Scaling">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_max_ingested',
                })
              }
            >
              {liq_interacts.max_ingested}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Custom Metabolism Color">
            <LiquidColorInput
              action_name="b_custom_ingested_color"
              value_of={null}
              back_color={liq_interacts.custom_ingested_color}
              name_of="Custom Metabolism Color"
            />
          </LabeledList.Item>
          <LabeledList.Item label="Metabolism Overlay Alpha">
            <Button
              onClick={() =>
                act('liq_set_attribute', {
                  liq_attribute: 'b_custom_ingested_alpha',
                })
              }
            >
              {liq_interacts.custom_ingested_alpha}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Purge Liquids">
            <Button
              color="red"
              onClick={() =>
                act('liq_set_attribute', { liq_attribute: 'b_liq_purge' })
              }
            >
              Purge Liquids
            </Button>
          </LabeledList.Item>
        </LabeledList>
      ) : (
        'These options only display while liquid settings are turned on.'
      )}
    </Section>
=======
    <Stack vertical fill>
      <Stack.Item>
        <Section
          title="Liquid Options"
          fill
          buttons={
            <Stack align="center">
              <Stack.Item>
                <Button.Confirm
                  color="red"
                  tooltip="Clear this belly's liquids."
                  confirmContent="Confirm Purge?"
                  onClick={() =>
                    act('liq_set_attribute', { attribute: 'b_liq_purge' })
                  }
                >
                  Purge Liquids
                </Button.Confirm>
              </Stack.Item>
              <Stack.Item>
                <VorePanelEditSwitch
                  action="liq_set_attribute"
                  subAction="b_show_liq"
                  editMode={editMode}
                  active={!!show_liq}
                  tooltip={
                    'These are the settings for liquid bellies, every belly has a liquid storage.'
                  }
                />
              </Stack.Item>
            </Stack>
          }
        >
          {!!show_liq && (
            <Stack fill vertical>
              <Stack.Item>
                <LabeledList>
                  <LabeledList.Item label="Liquid Addons">
                    <VorePanelEditCheckboxes
                      editMode={editMode}
                      options={liq_interacts.liq_reagent_addons}
                      action="liq_set_attribute"
                      subAction="b_liq_reagent_addons"
                      tooltipList={liquidToTooltip}
                      tooltip='Liquid production modes to apply as soon as "Produce Liquids" is turned on.'
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Stack.Item>
              <Stack.Item mt="5px">
                <Stack fill>
                  <Stack.Item basis="49%" grow>
                    <LiquidOptionsLeft
                      editMode={editMode}
                      liquidInteract={liq_interacts}
                    />
                  </Stack.Item>
                  <Stack.Item basis="49%" grow>
                    <LiquidOptionsRight
                      editMode={editMode}
                      liquidInteract={liq_interacts}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Current Liquids">
          <LabeledList>
            {liq_interacts.current_reagents
              .sort((a, b) => a.volume - b.volume)
              .map((reagent) => (
                <LabeledList.Item key={reagent.name} label={reagent.name}>
                  <Box color={reagentToColor[reagent.name]}>
                    {reagent.volume} u
                  </Box>
                </LabeledList.Item>
              ))}
            {!!liq_interacts.current_reagents.length && <LabeledList.Divider />}
            <LabeledList.Item label="Total volume">
              {liq_interacts.total_volume} u
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
>>>>>>> 87f031d72b ([MIRROR] tgui core 4.3.1 (#11083))
  );
};
