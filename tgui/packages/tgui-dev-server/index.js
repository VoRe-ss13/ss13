/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD:tgui/packages/tgui-dev-server/index.js
import { reloadByondCache } from './reloader.js';
import { createCompiler } from './webpack.js';
=======
import fs from 'node:fs';

import { reloadByondCache } from './reloader';
import { RspackCompiler } from './webpack';
>>>>>>> 222559a464 ([Manual Mirror] RS Pack try 2 (#11172)):tgui/packages/tgui-dev-server/index.ts

const noHot = process.argv.includes('--no-hot');
const noTmp = process.argv.includes('--no-tmp');
const reloadOnce = process.argv.includes('--reload');

async function setupServer() {
<<<<<<< HEAD:tgui/packages/tgui-dev-server/index.js
  const compiler = await createCompiler({
    hot: !noHot,
    useTmpFolder: !noTmp,
  });
=======
  fs.mkdirSync('./public/.tmp', { recursive: true });

  const compiler = new RspackCompiler();

  await compiler.setup();
>>>>>>> 222559a464 ([Manual Mirror] RS Pack try 2 (#11172)):tgui/packages/tgui-dev-server/index.ts

  // Reload cache once
  if (reloadOnce) {
    await reloadByondCache(compiler.bundleDir);
    return;
  }

  // Run a development server
  await compiler.watch();
}

setupServer();
