import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Button, Icon, NoticeBox, Stack, Tabs } from 'tgui-core/components';

import type { Data } from './types';
import { VoreBellySelectionAndCustomization } from './VoreBellySelectionAndCustomization';
import { VoreInsidePanel } from './VoreInsidePanel';
import { VoreSoulcatcher } from './VoreSoulcatcher';
import { VoreUserPreferences } from './VoreUserPreferences';

/**
 * There are three main sections to this UI.
 *  - The Inside Panel, where all relevant data for interacting with a belly you're in is located.
 *  - The soulcatcher, which allows to capture prey after digestion to entrap them.
 *  - The Belly Selection Panel, where you can select what belly people will go into and customize the active one.
 *  - User Preferences, where you can adjust all of your vore preferences on the fly.
 */

export const VorePanel = () => {
  const { act, data } = useBackend<Data>();

  const {
    inside,
    our_bellies,
    selected,
    soulcatcher,
    abilities,
    prefs,
    show_pictures,
    icon_overflow,
    host_mobtype,
    unsaved_changes,
    vore_words,
  } = data;

  const [tabIndex, setTabIndex] = useState(0);

  const tabs: React.JSX.Element[] = [];

  tabs[0] = (
    <VoreBellySelectionAndCustomization
      our_bellies={our_bellies}
      selected={selected}
      show_pictures={show_pictures}
      host_mobtype={host_mobtype}
      icon_overflow={icon_overflow}
      vore_words={vore_words}
    />
  );
  tabs[1] = (
    <VoreSoulcatcher
      our_bellies={our_bellies}
      soulcatcher={soulcatcher}
      abilities={abilities}
    />
  );
  tabs[2] = (
    <VoreUserPreferences
      prefs={prefs}
      selected={selected}
      show_pictures={show_pictures}
      icon_overflow={icon_overflow}
    />
  );

  return (
    <Window width={1000} height={660} theme="abstract">
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            {(unsaved_changes && (
              <NoticeBox danger>
                <Stack>
                  <Stack.Item basis="90%">Warning: Unsaved Changes!</Stack.Item>
                  <Stack.Item>
                    <Button icon="save" onClick={() => act('saveprefs')}>
                      Save Prefs
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="download"
                      onClick={() => {
                        act('saveprefs');
                        act('exportpanel');
                      }}
                    >
                      Save Prefs & Export Selected Belly
                    </Button>
                  </Stack.Item>
                </Stack>
              </NoticeBox>
            )) ||
              ''}
          </Stack.Item>
          <Stack.Item basis={inside?.desc?.length || 0 > 500 ? '30%' : '20%'}>
            <VoreInsidePanel
              inside={inside}
              show_pictures={show_pictures}
              icon_overflow={icon_overflow}
            />
          </Stack.Item>
          <Stack.Item>
            <Tabs>
              <Tabs.Tab
                selected={tabIndex === 0}
                onClick={() => setTabIndex(0)}
              >
                Bellies
                <Icon name="list" ml={0.5} />
              </Tabs.Tab>
              <Tabs.Tab
                selected={tabIndex === 1}
                onClick={() => setTabIndex(1)}
              >
                Soulcatcher
                <Icon name="ghost" ml={0.5} />
              </Tabs.Tab>
              <Tabs.Tab
                selected={tabIndex === 2}
                onClick={() => setTabIndex(2)}
              >
                Preferences
                <Icon name="user-cog" ml={0.5} />
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>{tabs[tabIndex] || 'Error'}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
