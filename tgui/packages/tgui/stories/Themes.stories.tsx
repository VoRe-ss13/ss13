/**
 * @file
 * @copyright 2021 Aleksej Komarov
 * @license MIT
 */

import { useState } from 'react';
import { Input, LabeledList, Section } from 'tgui-core/components';

export const meta = {
  title: 'Themes',
  render: () => <Story />,
};

function Story() {
  const [theme, setTheme] = useState('');

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Use theme">
          <Input
            placeholder="theme_name"
<<<<<<< HEAD
            value={props.theme}
            onInput={(e, value) => props.setTheme(value)}
=======
            value={theme}
            onChange={(value) => setTheme(value)}
>>>>>>> 335ff75144 ([MIRROR] tgstation/tgstation#90646 (#10681))
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
}
