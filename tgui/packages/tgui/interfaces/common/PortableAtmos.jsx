import { useBackend } from '../../backend';
<<<<<<< HEAD
import { Fragment } from 'inferno';
import { Box, Section, LabeledList, Button, AnimatedNumber, ProgressBar } from '../../components';
=======
import { Fragment } from 'react';
import {
  Box,
  Section,
  LabeledList,
  Button,
  AnimatedNumber,
  ProgressBar,
} from '../../components';
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))

export const PortableBasicInfo = (props) => {
  const { act, data } = useBackend();

  const {
    connected,
    holding,
    on,
    pressure,
    powerDraw,
    cellCharge,
    cellMaxCharge,
  } = data;

  return (
    <Fragment>
      <Section
        title="Status"
        buttons={
          <Button
            icon={on ? 'power-off' : 'times'}
            content={on ? 'On' : 'Off'}
            selected={on}
            onClick={() => act('power')}
          />
        }
      >
        <LabeledList>
          <LabeledList.Item label="Pressure">
            <AnimatedNumber value={pressure} />
            {' kPa'}
          </LabeledList.Item>
          <LabeledList.Item label="Port" color={connected ? 'good' : 'average'}>
            {connected ? 'Connected' : 'Not Connected'}
          </LabeledList.Item>
          <LabeledList.Item label="Load">{powerDraw} W</LabeledList.Item>
          <LabeledList.Item label="Cell Charge">
            <ProgressBar
              value={cellCharge}
              minValue={0}
              maxValue={cellMaxCharge}
              ranges={{
                good: [cellMaxCharge * 0.5, Infinity],
                average: [cellMaxCharge * 0.25, cellMaxCharge * 0.5],
                bad: [-Infinity, cellMaxCharge * 0.25],
              }}
            >
              {cellCharge} W
            </ProgressBar>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Holding Tank"
        minHeight="82px"
        buttons={
          <Button
            icon="eject"
            content="Eject"
            disabled={!holding}
            onClick={() => act('eject')}
          />
        }
      >
        {holding ? (
          <LabeledList>
            <LabeledList.Item label="Label">{holding.name}</LabeledList.Item>
            <LabeledList.Item label="Pressure">
              <AnimatedNumber value={holding.pressure} />
              {' kPa'}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box color="average">No holding tank</Box>
        )}
      </Section>
    </Fragment>
  );
};
