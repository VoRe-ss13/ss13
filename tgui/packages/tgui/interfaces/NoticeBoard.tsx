import { BooleanLike } from 'common/react';
<<<<<<< HEAD
import { Fragment } from 'inferno';
=======
import { Fragment } from 'react';

>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  notices: {
    name: string;
    isphoto: BooleanLike;
    ispaper: BooleanLike;
    ref: string;
  }[];
};

export const NoticeBoard = (props) => {
  const { act, data } = useBackend<Data>();

  const { notices } = data;

  return (
    <Window width={330} height={300}>
      <Window.Content>
        <Section>
          {notices.length ? (
            <LabeledList>
              {notices.map((notice, i) => (
                <LabeledList.Item key={i} label={notice.name}>
                  {(notice.isphoto && (
                    <Button
                      icon="image"
                      content="Look"
                      onClick={() => act('look', { ref: notice.ref })}
                    />
                  )) ||
                    (notice.ispaper && (
                      <Fragment>
                        <Button
                          icon="sticky-note"
                          content="Read"
                          onClick={() => act('read', { ref: notice.ref })}
                        />
                        <Button
                          icon="pen"
                          content="Write"
                          onClick={() => act('write', { ref: notice.ref })}
                        />
                      </Fragment>
                    )) ||
                    'Unknown Entity'}
                  <Button
                    icon="minus-circle"
                    content="Remove"
                    onClick={() => act('remove', { ref: notice.ref })}
                  />
                </LabeledList.Item>
              ))}
            </LabeledList>
          ) : (
            <Box color="average">No notices posted here.</Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
