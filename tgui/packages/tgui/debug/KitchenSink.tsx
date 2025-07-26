/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { useState } from 'react';
import { Section, Stack, Tabs } from 'tgui-core/components';

import { Pane, Window } from '../layouts';

<<<<<<< HEAD
const r = require.context('../stories', false, /\.stories\.tsx$/);
=======
const r = import.meta.webpackContext('../stories', {
  recursive: false,
  regExp: /\.stories\.tsx$/,
});
>>>>>>> 053f149ebc ([MIRROR] fix stories (#11250))

/**
 * @returns {{
 *   meta: {
 *     title: string,
 *     render: () => any,
 *   },
 * }[]}
 */
function getStories() {
  return r.keys().map((path) => r(path));
}

export function KitchenSink(props) {
  const { panel } = props;
<<<<<<< HEAD

=======
  const [theme, setTheme] = useState(undefined);
>>>>>>> 053f149ebc ([MIRROR] fix stories (#11250))
  const [pageIndex, setPageIndex] = useState(0);

  const stories = getStories();
  const story = stories[pageIndex];
  const Layout = panel ? Pane : Window;

  return (
    <Layout title="Kitchen Sink" width={600} height={500} theme={theme}>
      <Layout.Content>
        <Stack fill>
          <Stack.Item>
            <Section fill fitted>
              <Tabs vertical>
                {stories.map((story, i) => (
                  <Tabs.Tab
                    key={i}
                    color="transparent"
                    selected={i === pageIndex}
                    onClick={() => setPageIndex(i)}
                  >
                    {story.meta.title}
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Section>
          </Stack.Item>
          <Stack.Item grow>{story.meta.render(theme, setTheme)}</Stack.Item>
        </Stack>
      </Layout.Content>
    </Layout>
  );
}
