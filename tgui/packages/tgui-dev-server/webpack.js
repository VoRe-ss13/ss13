/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import fs from 'node:fs';
import { createRequire } from 'node:module';

import { loadSourceMaps, setupLink } from './link/server.js';
import { createLogger } from './logging.js';
import { reloadByondCache } from './reloader.js';
import { resolveGlob } from './util.js';

const logger = createLogger('webpack');

/**
 * @param {any} config
 * @return {WebpackCompiler}
 */
<<<<<<< HEAD
export const createCompiler = async (options) => {
  const compiler = new WebpackCompiler();
=======
export async function createCompiler(options) {
  const compiler = new RspackCompiler();
>>>>>>> 335ff75144 ([MIRROR] tgstation/tgstation#90646 (#10681))
  await compiler.setup(options);

  return compiler;
}

class WebpackCompiler {
  async setup(options) {
    // Create a require context that is relative to project root
    // and retrieve all necessary dependencies.
<<<<<<< HEAD
    const requireFromRoot = createRequire(dirname(import.meta.url) + '/../..');
    const webpack = await requireFromRoot('webpack');
    const createConfig = await requireFromRoot('./webpack.config.js');
=======
    const requireFromRoot = createRequire(import.meta.dirname + '/../../..');
    /** @type {typeof import('@rspack/core')} */
    const rspack = await requireFromRoot('@rspack/core');
    const createConfig = await requireFromRoot('./rspack.config.cjs');
>>>>>>> 335ff75144 ([MIRROR] tgstation/tgstation#90646 (#10681))
    const config = createConfig({}, options);
    // Inject the HMR plugin into the config if we're using it
    if (options.hot) {
      config.plugins.push(new webpack.HotModuleReplacementPlugin());
    }
    this.webpack = webpack;
    this.config = config;
    this.bundleDir = config.output.path;
  }

  async watch() {
    logger.log('setting up');
    // Setup link
    const link = setupLink();
    // Instantiate the compiler
    const compiler = this.webpack.webpack(this.config);
    // Clear garbage before compiling
    compiler.hooks.watchRun.tapPromise('tgui-dev-server', async () => {
      const files = await resolveGlob(this.bundleDir, './*.hot-update.*');
      logger.log(`clearing garbage (${files.length} files)`);
      for (const file of files) {
        fs.unlinkSync(file);
      }
      logger.log('compiling');
    });
    // Start reloading when it's finished
    compiler.hooks.done.tap('tgui-dev-server', async (stats) => {
      // Load source maps
      await loadSourceMaps(this.bundleDir);
      // Reload cache
      await reloadByondCache(this.bundleDir);
      // Notify all clients that update has happened
      link.broadcastMessage({
        type: 'hotUpdate',
      });
    });
    // Start watching
    logger.log('watching for changes');
    compiler.watch({}, (err, stats) => {
      if (err) {
        logger.error('compilation error', err);
        return;
      }
      stats
        ?.toString(this.config.devServer.stats)
        .split('\n')
        .forEach((line) => logger.log(line));
    });
  }
}
