/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import fs from 'node:fs';
import os from 'node:os';
import { basename } from 'node:path';

import { DreamSeeker } from './dreamseeker.js';
import { createLogger } from './logging.js';
import { resolveGlob, resolvePath } from './util.js';
import { regQuery } from './winreg.js';

const logger = createLogger('reloader');

const HOME = os.homedir();
const SEARCH_LOCATIONS = [
  // Custom location
  process.env.BYOND_CACHE,
  // Windows
  `${HOME}/*/BYOND/cache`,
  // Wine
  `${HOME}/.wine/drive_c/users/*/*/BYOND/cache`,
  // Lutris
  `${HOME}/Games/byond/drive_c/users/*/*/BYOND/cache`,
  // WSL
  `/mnt/c/Users/*/*/BYOND/cache`,
];

let cacheRoot;

export async function findCacheRoot() {
  if (cacheRoot) {
    return cacheRoot;
  }
  logger.log('looking for byond cache');
  // Find BYOND cache folders
  for (const pattern of SEARCH_LOCATIONS) {
    if (!pattern) {
      continue;
    }
    const paths = await resolveGlob(pattern);
    if (paths.length > 0) {
      cacheRoot = paths[0];
      onCacheRootFound(cacheRoot);
      return cacheRoot;
    }
  }
  // Query the Windows Registry
  if (process.platform === 'win32') {
    logger.log('querying windows registry');
    const userpath = await regQuery(
      'HKCU\\Software\\Dantom\\BYOND',
      'userpath',
    );
    if (userpath) {
<<<<<<< HEAD:tgui/packages/tgui-dev-server/reloader.js
      cacheRoot = userpath.replace(/\\$/, '').replace(/\\/g, '/') + '/cache';
      onCacheRootFound(cacheRoot);
=======
      cacheRoot = `${userpath.replace(/\\$/, '').replace(/\\/g, '/')}/cache`;
      await onCacheRootFound(cacheRoot);
>>>>>>> f39fdae47c (Manualbiome (#11216)):tgui/packages/tgui-dev-server/reloader.ts
      return cacheRoot;
    }
  }
  logger.log('found no cache directories');
}

function onCacheRootFound(cacheRoot) {
  logger.log(`found cache at '${cacheRoot}'`);
  // Plant a dummy browser window file, we'll be using this to avoid world topic. For byond 514.
<<<<<<< HEAD:tgui/packages/tgui-dev-server/reloader.js
  fs.closeSync(fs.openSync(cacheRoot + '/dummy.htm', 'w'));
=======
  await Bun.write(`${cacheRoot}/dummy.htm`, '');
>>>>>>> f39fdae47c (Manualbiome (#11216)):tgui/packages/tgui-dev-server/reloader.ts
}

export async function reloadByondCache(bundleDir) {
  const cacheRoot = await findCacheRoot();
  if (!cacheRoot) {
    return;
  }
  // Find tmp folders in cache
  const cacheDirs = resolveGlob(cacheRoot, './tmp*');
  if (cacheDirs.length === 0) {
    logger.log('found no tmp folder in cache');
    return;
  }

  const pids = cacheDirs.map((cacheDir) => {
    return parseInt(cacheDir.split('\\cache\\tmp')[1], 10);
  });

  const dssPromise = DreamSeeker.getInstancesByPids(pids);
  // Copy assets
  const assets = await resolveGlob(
    bundleDir,
    './*.+(bundle|chunk|hot-update).*',
  );
  for (const cacheDir of cacheDirs) {
    // Clear garbage
    const garbage = await resolveGlob(
      cacheDir,
      './*.+(bundle|chunk|hot-update).*',
    );
    try {
      // Plant a dummy browser window file, we'll be using this to avoid world topic. For byond 515-516.
<<<<<<< HEAD:tgui/packages/tgui-dev-server/reloader.js
      fs.closeSync(fs.openSync(cacheDir + '/dummy.htm', 'w'));
=======
      await Bun.write(`${cacheDir}/dummy.htm`, '');
>>>>>>> f39fdae47c (Manualbiome (#11216)):tgui/packages/tgui-dev-server/reloader.ts

      for (const file of garbage) {
        fs.unlinkSync(file);
      }
      // Copy assets
      for (const asset of assets) {
        const destination = resolvePath(cacheDir, basename(asset));
        fs.writeFileSync(destination, fs.readFileSync(asset));
      }
      logger.log(`copied ${assets.length} files to '${cacheDir}'`);
    } catch (err) {
      logger.error(`failed copying to '${cacheDir}'`);
      logger.error(err);
    }
  }
  // Notify dreamseeker
  const dss = await dssPromise;
  if (dss.length > 0) {
    logger.log(`notifying dreamseeker`);
    for (const dreamseeker of dss) {
      dreamseeker.topic({
        tgui: 1,
        type: 'cacheReloaded',
      });
    }
  }
}
