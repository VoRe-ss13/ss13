import { useBackend } from 'tgui/backend';
import { NtosWindow } from 'tgui/layouts';
import { Button, ColorBox, Section, Table } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

const PROGRAM_ICONS = {
  compconfig: 'cog',
  ntndownloader: 'download',
  filemanager: 'folder',
  smmonitor: 'radiation',
  alarmmonitor: 'bell',
  cardmod: 'id-card',
  arcade: 'gamepad',
  ntnrc_client: 'comment-alt',
  nttransfer: 'exchange-alt',
  powermonitor: 'plug',
  job_manage: 'address-book',
  crewmani: 'clipboard-list',
  robocontrol: 'robot',
  atmosscan: 'thermometer-half',
  shipping: 'tags',
};

type Data = {
  device_theme: string;
  login: user;
  removable_media: string[];
  programs: {
    name: string;
    desc: string;
    icon: string;
    running: BooleanLike;
    autorun: BooleanLike;
  }[];
  has_light: BooleanLike;
  light_on: BooleanLike;
  comp_light_color: BooleanLike;
};

type user = { IDName: string | undefined; IDJob: string | undefined };

export const NtosMain = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    device_theme,
    programs = [],
    has_light,
    light_on,
    comp_light_color,
    removable_media = [],
    login = {} as user,
  } = data;
  return (
    <NtosWindow
      title={
        (device_theme === 'syndicate' && 'Syndix Main Menu') || 'NtOS Main Menu'
      }
      theme={device_theme}
      width={400}
      height={500}
    >
      <NtosWindow.Content scrollable>
        {!!has_light && (
          <Section>
            <Button
              width="144px"
              icon="lightbulb"
              selected={light_on}
              onClick={() => act('PC_toggle_light')}
            >
              Flashlight: {light_on ? 'ON' : 'OFF'}
            </Button>
            <Button ml={1} onClick={() => act('PC_light_color')}>
              Color:
              <ColorBox ml={1} color={comp_light_color} />
            </Button>
          </Section>
        )}
        <Section
          title="User Login"
          buttons={
            <Button
              icon="eject"
              disabled={!login.IDName}
              onClick={() => act('PC_Eject_Disk', { name: 'ID' })}
            >
              Eject ID
            </Button>
          }
        >
          <Table>
            <Table.Row>ID Name: {login.IDName}</Table.Row>
            <Table.Row>Assignment: {login.IDJob}</Table.Row>
          </Table>
        </Section>
        {!!removable_media.length && (
          <Section title="Media Eject">
            <Table>
              {removable_media.map((device) => (
                <Table.Row key={device}>
                  <Table.Cell>
                    <Button
                      fluid
                      color="transparent"
                      icon="eject"
                      onClick={() => act('PC_Eject_Disk', { name: device })}
                    >
                      {device}
                    </Button>
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        )}
        <Section title="Programs">
          <Table>
            {programs.map((program) => (
              <Table.Row key={program.name}>
                <Table.Cell>
                  <Button
                    fluid
                    color="transparent"
                    icon={PROGRAM_ICONS[program.name] || 'window-maximize-o'}
                    onClick={() =>
                      act('PC_runprogram', {
                        name: program.name,
                      })
                    }
                  >
                    {program.desc}
                  </Button>
                </Table.Cell>
                <Table.Cell collapsing width="18px">
                  {!!program.running && (
                    <Button
                      color="transparent"
                      icon="times"
                      tooltip="Close program"
                      tooltipPosition="left"
                      onClick={() =>
                        act('PC_killprogram', {
                          name: program.name,
                        })
                      }
                    />
                  )}
                </Table.Cell>
                <Table.Cell collapsing width="18px">
                  <Button
                    color="transparent"
                    tooltip="Set Autorun"
                    tooltipPosition="left"
                    selected={program.autorun}
                    onClick={() =>
                      act('PC_setautorun', {
                        name: program.name,
                      })
                    }
                  >
                    AR
                  </Button>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
