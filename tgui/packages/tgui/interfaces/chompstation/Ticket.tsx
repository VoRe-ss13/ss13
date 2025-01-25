/* eslint react/no-danger: "off" */
import { KEY } from 'common/keys';
<<<<<<< HEAD
import { round, toFixed } from 'common/math';
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
  Flex,
  Input,
  LabeledList,
  Section,
} from '../../components';
import { Window } from '../../layouts';

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
  title: string;
  name: string;
  ticket_ref: string;
  state: string;
  level: number;
  handler: string;
  opened_at: number;
  closed_at: number;
  opened_at_date: string;
  closed_at_date: string;
  actions: string;
  log: string[];
};

window.addEventListener('keydown', (event) => {
  console.log(event);
});

export const Ticket = (props) => {
  const { act, data } = useBackend<Data>();
  const [ticketChat, setTicketChat] = useState('');

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

  const {
    id,
    name,
    ticket_ref,
    state,
    level,
    handler,
    opened_at,
    closed_at,
    opened_at_date,
    closed_at_date,
    actions,
    log,
  } = data;
  return (
    <Window width={900} height={600}>
      <Window.Content scrollable>
        <Section
          title={'Ticket #' + id}
          buttons={
            <Box nowrap>
              <Button icon="pen" onClick={() => act('retitle')}>
                Rename Ticket
              </Button>
              <Button onClick={() => act('legacy')}>Legacy UI</Button>
              <Button color={LevelColor[level]}>{Level[level]}</Button>
            </Box>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Ticket ID">
              #{id}: <div dangerouslySetInnerHTML={{ __html: name }} />
            </LabeledList.Item>
            <LabeledList.Item label="Type">{Level[level]}</LabeledList.Item>
            <LabeledList.Item label="State">{State[state]}</LabeledList.Item>
            <LabeledList.Item label="Assignee">{handler}</LabeledList.Item>
            {State[state] === State.open ? (
              <LabeledList.Item label="Opened At">
                {opened_at_date +
                  ' (' +
                  toFixed(round((opened_at / 600) * 10, 0) / 10, 1) +
                  ' minutes ago.)'}
              </LabeledList.Item>
            ) : (
              <LabeledList.Item label="Closed At">
                {closed_at_date +
                  ' (' +
                  toFixed(round((closed_at / 600) * 10, 0) / 10, 1) +
                  ' minutes ago.)'}
                <Button onClick={() => act('reopen')}>Reopen</Button>
              </LabeledList.Item>
            )}
            <LabeledList.Item label="Actions">
              <div dangerouslySetInnerHTML={{ __html: actions }} />
            </LabeledList.Item>
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
<<<<<<< HEAD
            <Flex.Item>
              <Flex>
                <Flex.Item grow>
                  <Input
                    autoFocus
=======
          </Stack.Item>
          <Stack.Item grow>
            <Section scrollable ref={messagesEndRef} fill>
              <Stack direction="column">
                <Stack.Item>
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
          </Stack.Item>
          <Stack.Item>
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
                        act('send_msg', {
                          msg: ticketChat,
                          ticket_ref: ticket_ref,
                        });
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
                      act('send_msg', {
                        msg: ticketChat,
                        ticket_ref: ticket_ref,
                      });
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
