/**
 * @file
 * @copyright 2021 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
import { Box, Button, Section, Tooltip } from 'tgui-core/components';
=======
import { type ComponentProps } from 'react';
import {
  Box,
  Button,
  type Floating,
  Section,
  Tooltip,
} from 'tgui-core/components';
>>>>>>> 335ff75144 ([MIRROR] tgstation/tgstation#90646 (#10681))

export const meta = {
  title: 'Tooltip',
  render: () => <Story />,
};

<<<<<<< HEAD
const Story = () => {
  const positions = [
    'top',
    'left',
    'right',
    'bottom',
    'bottom-start',
    'bottom-end',
  ];
=======
type Placement = ComponentProps<typeof Floating>['placement'];
>>>>>>> 335ff75144 ([MIRROR] tgstation/tgstation#90646 (#10681))

const positions = [
  'top',
  'left',
  'right',
  'bottom',
  'bottom-start',
  'bottom-end',
] as Placement[];

function Story() {
  return (
    <Section>
      <Box>
        <Tooltip content="Tooltip text.">
          <Box inline position="relative" mr={1}>
            Box (hover me).
          </Box>
        </Tooltip>
        <Button tooltip="Tooltip text.">Button</Button>
      </Box>
      <Box mt={1}>
        {positions.map((position) => (
          <Button
            key={position}
            color="transparent"
            tooltip="Tooltip text."
            tooltipPosition={position}
          >
            {position}
          </Button>
        ))}
      </Box>
    </Section>
  );
}
