import { useState } from 'react';
<<<<<<< HEAD

import { useBackend } from '../backend';
import { Box, Button, Icon, NanoMap, Section, Tabs } from '../components';
import { Window } from '../layouts';
=======
import { useBackend } from 'tgui/backend';
import { NanoMap } from 'tgui/components';
import { Window } from 'tgui/layouts';
import { Box, Button, Icon, Section, Stack, Tabs } from 'tgui-core/components';
>>>>>>> ab6a02b150 ([MIRROR] rework atmos control (#10107))

type alarm = {
  name: string;
  ref: string;
  danger: number;
  x: number;
  y: number;
  z: number;
};

type Data = {
  alarms: alarm[];
  zoomScale: number;
};

export const AtmosControl = (props) => {
  return (
    <Window width={600} height={440}>
      <Window.Content>
        <AtmosControlContent />
      </Window.Content>
    </Window>
  );
};

export const AtmosControlContent = (props) => {
  const { act, data, config } = useBackend<Data>();

  const { alarms } = data;
  alarms.sort((a, b) => a.name.localeCompare(b.name));

  const [tabIndex, setTabIndex] = useState(0);
  const [zoom, setZoom] = useState(1);

<<<<<<< HEAD
  let body;
  // Alarms View
  if (tabIndex === 0) {
    body = (
      <Section title="Alarms">
        {alarms.map((alarm) => (
          <Button
            key={alarm.name}
            color={
              alarm.danger === 2 ? 'bad' : alarm.danger === 1 ? 'average' : ''
            }
            onClick={() => act('alarm', { alarm: alarm.ref })}
          >
            {alarm.name}
          </Button>
        ))}
      </Section>
    );
  } else if (tabIndex === 1) {
    // Please note, if you ever change the zoom values,
    // you MUST update styles/components/Tooltip.scss
    // and change the @for scss to match.
    body = (
      <Box height="526px" mb="0.5rem" overflow="hidden">
        <NanoMap zoomScale={data.zoomScale} onZoom={(v) => setZoom(v)}>
          {alarms
            .filter((x) => ~~x.z === ~~config.mapZLevel)
            .map((cm) => (
              <NanoMap.Marker
                key={cm.ref}
                x={cm.x}
                y={cm.y}
                zoom={zoom}
                icon="bell"
                tooltip={cm.name}
                color={cm.danger ? 'red' : 'green'}
                onClick={() => act('alarm', { alarm: cm.ref })}
              />
            ))}
        </NanoMap>
      </Box>
    );
  }
=======
  const tab: React.JSX.Element[] = [];

  tab[0] = (
    <Section title="Alarms" scrollable fill>
      {alarms.map((alarm) => (
        <Button
          key={alarm.name}
          color={
            alarm.danger === 2 ? 'bad' : alarm.danger === 1 ? 'average' : ''
          }
          onClick={() => act('alarm', { alarm: alarm.ref })}
        >
          {alarm.name}
        </Button>
      ))}
    </Section>
  );
  // Please note, if you ever change the zoom values,
  // you MUST update styles/components/Tooltip.scss
  // and change the @for scss to match.
  tab[1] = (
    <Box height="526px" mb="0.5rem" overflow="hidden">
      <NanoMap zoomScale={data.zoomScale} onZoom={(v) => setZoom(v)}>
        {alarms
          .filter((x) => ~~x.z === ~~config.mapZLevel)
          .map((cm) => (
            <NanoMap.Marker
              key={cm.ref}
              x={cm.x}
              y={cm.y}
              zoom={zoom}
              icon="bell"
              tooltip={cm.name}
              color={cm.danger ? 'red' : 'green'}
              onClick={() => act('alarm', { alarm: cm.ref })}
            />
          ))}
      </NanoMap>
    </Box>
  );
>>>>>>> ab6a02b150 ([MIRROR] rework atmos control (#10107))

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Tabs>
          <Tabs.Tab
            key="AlarmView"
            selected={0 === tabIndex}
            onClick={() => setTabIndex(0)}
          >
            <Icon name="table" /> Alarm View
          </Tabs.Tab>
          <Tabs.Tab
            key="MapView"
            selected={1 === tabIndex}
            onClick={() => setTabIndex(1)}
          >
            <Icon name="map-marked-alt" /> Map View
          </Tabs.Tab>
        </Tabs>
      </Stack.Item>
      <Stack.Item grow m={2}>
        {tab[tabIndex]}
      </Stack.Item>
    </Stack>
  );
};
