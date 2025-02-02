/* eslint react/no-danger: "off" */
import { KEY } from 'common/keys';
<<<<<<< HEAD
import { useState } from 'react';

import { useBackend } from '../../backend';
=======
import { RefObject, useEffect, useRef, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
>>>>>>> 331c65df39 (improves ticket chat (#9927))
import {
  Box,
  Button,
  Divider,
  Input,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';

const Level = {
  0: 'Adminhelp',
  1: 'Mentorhelp',
  2: 'GM Request',
};

const LevelColor = {
  0: 'red',
  1: 'green',
  2: 'pink',
};

const Tag = {
  example: 'Example',
};

const State = {
  open: 'Open',
  resolved: 'Resolved',
  closed: 'Closed',
  unknown: 'Unknown',
};

type Data = {
  id: number;
  level: number;
  handler: string;
  log: string[];
};

export const TicketChat = (props) => {
  const { act, data } = useBackend<Data>();
  const [ticketChat, setTicketChat] = useState('');
  const { id, level, handler, log } = data;

  const messagesEndRef: RefObject<HTMLDivElement> = useRef(null);

  useEffect(() => {
    const scroll = messagesEndRef.current;
    if (scroll) {
      scroll.scrollTop = scroll.scrollHeight;
    }
  }, []);

  useEffect(() => {
    const scroll = messagesEndRef.current;
    if (scroll) {
      const height = scroll.scrollHeight;
      const bottom = scroll.scrollTop + scroll.offsetHeight;
      const scrollTracking = Math.abs(height - bottom) < 24;
      if (scrollTracking) {
        scroll.scrollTop = scroll.scrollHeight;
      }
    }
  });

  return (
    <Window width={900} height={600}>
      <Window.Content>
<<<<<<< HEAD
        <Section
          title={'Ticket #' + id}
          buttons={
            <Box nowrap>
              <Button color={LevelColor[level]}>{Level[level]}</Button>
            </Box>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Assignee">{handler}</LabeledList.Item>
            <LabeledList.Item label="Log" />
          </LabeledList>
          <Divider />
          <Flex direction="column">
            <Flex.Item>
              {Object.keys(log)
                .slice(0)
                .map((L, i) => (
                  <div key={i} dangerouslySetInnerHTML={{ __html: log[L] }} />
                ))}
            </Flex.Item>
            <Divider />
            <Flex.Item>
              <Flex>
                <Flex.Item grow>
                  <Input
                    autoFocus
=======
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title={'Ticket #' + id}
              buttons={
                <Box nowrap>
                  <Button color={LevelColor[level]}>{Level[level]}</Button>
                </Box>
              }
            >
              <LabeledList>
                <LabeledList.Item label="Assignee">{handler}</LabeledList.Item>
                <LabeledList.Item label="Log" />
              </LabeledList>
            </Section>
            <Divider />
          </Stack.Item>
          <Stack.Item grow>
            <Section fill ref={messagesEndRef} scrollable>
              <Stack fill direction="column">
                <Stack.Item grow>
                  {Object.keys(log)
                    .slice(0)
                    .map((L, i) => (
                      <div
                        key={i}
                        dangerouslySetInnerHTML={{ __html: log[L] }}
                      />
                    ))}
                </Stack.Item>
              </Stack>
            </Section>
            <Section fill>
              <Stack fill>
                <Stack.Item grow>
                  <Input
                    autoFocus
                    updateOnPropsChange
>>>>>>> 331c65df39 (improves ticket chat (#9927))
                    autoSelect
                    fluid
                    placeholder="Enter a message..."
                    value={ticketChat}
                    onInput={(e, value: string) => setTicketChat(value)}
                    onKeyDown={(e) => {
                      if (KEY.Enter === e.key) {
                        act('send_msg', { msg: ticketChat });
                        setTicketChat('');
                      }
                    }}
                  />
<<<<<<< HEAD
                </Flex.Item>
                <Flex.Item>
=======
                </Stack.Item>
                <Stack.Item>
>>>>>>> 331c65df39 (improves ticket chat (#9927))
                  <Button
                    onClick={() => {
                      act('send_msg', { msg: ticketChat });
                      setTicketChat('');
                    }}
                  >
                    Send
                  </Button>
<<<<<<< HEAD
                </Flex.Item>
              </Flex>
            </Flex.Item>
          </Flex>
        </Section>
=======
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
>>>>>>> 331c65df39 (improves ticket chat (#9927))
      </Window.Content>
    </Window>
  );
};
