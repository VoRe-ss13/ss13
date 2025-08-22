import { useDispatch, useSelector } from 'tgui/backend';
import { Box, LabeledList, NumberInput, Section } from 'tgui-core/components';

import { useGame } from '../../game';
import { updateSettings } from '../actions';
import { selectSettings } from '../selectors';

export const MessageLimits = (props) => {
  const dispatch = useDispatch();
  const game = useGame();
  const {
    visibleMessageLimit,
    persistentMessageLimit,
    combineMessageLimit,
    combineIntervalLimit,
    saveInterval,
  } = useSelector(selectSettings);
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Amount of lines to display 500-10000 (Default: 2500)">
          <NumberInput
            width="5em"
            step={100}
            stepPixelSize={2}
            minValue={500}
            maxValue={10000}
            value={visibleMessageLimit}
<<<<<<< HEAD
            format={(value) => toFixed(value)}
            onDrag={(value) =>
=======
            format={(value) => value.toFixed()}
            onChange={(value) =>
>>>>>>> c2b1e154db ([MIRROR] move to native toFixed (#11490))
              dispatch(
                updateSettings({
                  visibleMessageLimit: value,
                }),
              )
            }
          />
          &nbsp;
          {visibleMessageLimit >= 5000 && (
            <Box inline fontSize="0.9em" color="red">
              Impacts performance!
            </Box>
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Amount of visually persistent lines 0-10000 (Default: 1000)">
          <NumberInput
            width="5em"
            step={100}
            stepPixelSize={2}
            minValue={0}
            maxValue={10000}
            value={persistentMessageLimit}
<<<<<<< HEAD
            format={(value) => toFixed(value)}
            onDrag={(value) =>
=======
            format={(value) => value.toFixed()}
            onChange={(value) =>
>>>>>>> c2b1e154db ([MIRROR] move to native toFixed (#11490))
              dispatch(
                updateSettings({
                  persistentMessageLimit: value,
                }),
              )
            }
          />
          &nbsp;
          {persistentMessageLimit >= 2500 && (
            <Box inline fontSize="0.9em" color="red">
              Delays initialization!
            </Box>
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Amount of different lines in-between to combine 0-10 (Default: 5)">
          <NumberInput
            width="5em"
            step={1}
            stepPixelSize={10}
            minValue={0}
            maxValue={10}
            value={combineMessageLimit}
<<<<<<< HEAD
            format={(value) => toFixed(value)}
            onDrag={(value) =>
=======
            format={(value) => value.toFixed()}
            onChange={(value) =>
>>>>>>> c2b1e154db ([MIRROR] move to native toFixed (#11490))
              dispatch(
                updateSettings({
                  combineMessageLimit: value,
                }),
              )
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Time to combine messages 0-10 (Default: 5 Seconds)">
          <NumberInput
            width="5em"
            step={1}
            stepPixelSize={10}
            minValue={0}
            maxValue={10}
            value={combineIntervalLimit}
            unit="s"
<<<<<<< HEAD
            format={(value) => toFixed(value)}
            onDrag={(value) =>
=======
            format={(value) => value.toFixed()}
            onChange={(value) =>
>>>>>>> c2b1e154db ([MIRROR] move to native toFixed (#11490))
              dispatch(
                updateSettings({
                  combineIntervalLimit: value,
                }),
              )
            }
          />
        </LabeledList.Item>
        {!game.databaseBackendEnabled && (
          <LabeledList.Item label="Message store interval 1-10 (Default: 10 Seconds) [Requires restart]">
            <NumberInput
              width="5em"
              step={1}
              stepPixelSize={5}
              minValue={1}
              maxValue={10}
              value={saveInterval}
              unit="s"
<<<<<<< HEAD
              format={(value) => toFixed(value)}
              onDrag={(value) =>
=======
              format={(value) => value.toFixed()}
              onChange={(value) =>
>>>>>>> c2b1e154db ([MIRROR] move to native toFixed (#11490))
                dispatch(
                  updateSettings({
                    saveInterval: value,
                  }),
                )
              }
            />
            &nbsp;
            {saveInterval <= 3 && (
              <Box inline fontSize="0.9em" color="red">
                Warning, experimental! Might crash!
              </Box>
            )}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};
