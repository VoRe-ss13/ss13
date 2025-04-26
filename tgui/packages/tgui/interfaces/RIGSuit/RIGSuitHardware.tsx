import { useBackend } from 'tgui/backend';
import { Button, LabeledList, Section } from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import type { Data } from './types';

export const RIGSuitHardware = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    // Disables buttons while the suit is busy
    sealing,
    // Each piece
    helmet,
    helmetDeployed,
    gauntlets,
    gauntletsDeployed,
    boots,
    bootsDeployed,
    chest,
    chestDeployed,
  } = data;

  return (
    <Section title="Hardware">
      <LabeledList>
        <LabeledList.Item
          label="Helmet"
          buttons={
            <Button
              icon={helmetDeployed ? 'sign-out-alt' : 'sign-in-alt'}
              disabled={sealing}
              selected={helmetDeployed}
              onClick={() => act('toggle_piece', { piece: 'helmet' })}
            >
              {helmetDeployed ? 'Deployed' : 'Deploy'}
            </Button>
          }
        >
<<<<<<< HEAD
          {helmet ? capitalize(helmet) : 'ERROR'}
        </LabeledList.Item>
        <LabeledList.Item
          label="Gauntlets"
          buttons={
            <Button
              icon={gauntletsDeployed ? 'sign-out-alt' : 'sign-in-alt'}
              disabled={sealing}
              selected={gauntletsDeployed}
              onClick={() => act('toggle_piece', { piece: 'gauntlets' })}
            >
              {gauntletsDeployed ? 'Deployed' : 'Deploy'}
            </Button>
          }
        >
          {gauntlets ? capitalize(gauntlets) : 'ERROR'}
        </LabeledList.Item>
        <LabeledList.Item
          label="Boots"
          buttons={
            <Button
              icon={bootsDeployed ? 'sign-out-alt' : 'sign-in-alt'}
              disabled={sealing}
              selected={bootsDeployed}
              onClick={() => act('toggle_piece', { piece: 'boots' })}
            >
              {bootsDeployed ? 'Deployed' : 'Deploy'}
            </Button>
          }
        >
          {boots ? capitalize(boots) : 'ERROR'}
        </LabeledList.Item>
        <LabeledList.Item
          label="Chestpiece"
          buttons={
            <Button
              icon={chestDeployed ? 'sign-out-alt' : 'sign-in-alt'}
              disabled={sealing}
              selected={chestDeployed}
              onClick={() => act('toggle_piece', { piece: 'chest' })}
            >
              {chestDeployed ? 'Deployed' : 'Deploy'}
            </Button>
          }
        >
          {chest ? capitalize(chest) : 'ERROR'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
=======
          &nbsp;
        </Stack.Item>
        <Stack.Item grow>
          <Stack fill align="center" justify="center">
            <Stack.Item>
              <Box
                className="RIGSuit__FadeIn"
                style={{
                  display: 'grid',
                  gridTemplateColumns: '1fr 1fr',
                  gap: '10px',
                  width: 'fit-content',
                }}
              >
                <Tooltip
                  content={
                    'Suit Seals: ' + sealing
                      ? 'Sealing'
                      : sealed
                        ? 'Sealed'
                        : 'UNSEALED'
                  }
                >
                  <Box
                    position="relative"
                    className="RIGSuit__Icon"
                    style={{
                      filter: sealing
                        ? 'grayscale(100%) brightness(0.5)'
                        : sealed
                          ? undefined
                          : 'grayscale(80%)',
                    }}
                    onClick={() => act('toggle_seals')}
                  >
                    <DmIcon
                      height={6}
                      width={6}
                      icon="icons/hud/rig/rig_ui_slots.dmi"
                      icon_state="base"
                    />
                    <Box position="absolute" top={0.5} left={0.5}>
                      <Icon name="power-off" size={5} color="#5c9fd8" />
                    </Box>
                  </Box>
                </Tooltip>

                <Tooltip
                  content={
                    aioverride
                      ? 'Toggle AI Control Off'
                      : 'Toggle AI Control On'
                  }
                >
                  <Box
                    position="relative"
                    className="RIGSuit__Icon"
                    style={{
                      filter: aioverride ? undefined : 'grayscale(80%)',
                    }}
                    onClick={() => act('toggle_ai_control')}
                  >
                    <DmIcon
                      height={6}
                      width={6}
                      icon="icons/hud/rig/rig_ui_slots.dmi"
                      icon_state="base"
                    />
                    <Box position="absolute" top={0.7} left={0.5}>
                      <Icon name="robot" size={4} color="#5c9fd8" />
                    </Box>
                  </Box>
                </Tooltip>

                <Tooltip content={cooling ? 'Cooling: On' : 'Cooling: Off'}>
                  <Box
                    position="relative"
                    className="RIGSuit__Icon"
                    style={{
                      filter: cooling ? undefined : 'grayscale(80%)',
                    }}
                    onClick={() => act('toggle_cooling')}
                  >
                    <DmIcon
                      height={6}
                      width={6}
                      icon="icons/hud/rig/rig_ui_slots.dmi"
                      icon_state="base"
                    />
                    <Box position="absolute" top={1} left={1}>
                      <Icon name="wind" size={4} color="#5c9fd8" />
                    </Box>
                  </Box>
                </Tooltip>

                <Tooltip content="Tank Settings">
                  <Box
                    position="relative"
                    className="RIGSuit__Icon"
                    onClick={() => act('tank_settings')}
                  >
                    <DmIcon
                      height={6}
                      width={6}
                      icon="icons/hud/rig/rig_ui_slots.dmi"
                      icon_state="base"
                    />
                    <Box position="absolute" top={1} left={0.5}>
                      <Icon name="lungs" size={4} color="#5c9fd8" />
                    </Box>
                  </Box>
                </Tooltip>
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const HardwarePiece = (props: {
  name: string;
  icon: string;
  selected: BooleanLike;
  disabled: BooleanLike;
  onClick: () => void;
}) => {
  let filter;
  if (props.disabled) {
    filter = 'grayscale(100%) brightness(0.5)';
  } else if (props.selected) {
    filter = undefined;
  } else {
    filter = 'grayscale(80%)';
  }

  return (
    <Tooltip content={capitalize(props.name) || 'ERROR'}>
      <Box className="RIGSuit__Icon">
        <DmIcon
          height={6}
          width={6}
          icon="icons/hud/rig/rig_ui_slots.dmi"
          icon_state={props.icon}
          style={{
            cursor: 'pointer',
            filter,
          }}
          onClick={props.onClick}
        />
      </Box>
    </Tooltip>
  );
};
>>>>>>> 075b9a84a7 ([MIRROR] More RIG Intros (#10761))
