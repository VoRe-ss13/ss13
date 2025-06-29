/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD:tgui/packages/tgui-dev-server/webpack.js
import fs from 'node:fs';
import { createRequire } from 'node:module';
=======
import { createRequire } from 'module';
>>>>>>> 8a4f06eed4 ([MIRROR] removes tgui sonar, dev server oversights (#11129)):tgui/packages/tgui-dev-server/webpack.ts

import { loadSourceMaps } from './link/retrace';
import { broadcastMessage, setupLink } from './link/server';
import { createLogger } from './logging.js';
import { reloadByondCache } from './reloader.js';
import { resolveGlob } from './util';

const logger = createLogger('rspack');

<<<<<<< HEAD:tgui/packages/tgui-dev-server/webpack.js
/**
 * @param {any} config
 * @return {RspackCompiler}
 */
export async function createCompiler(options) {
  const compiler = new RspackCompiler();
  await compiler.setup(options);

  return compiler;
}

class RspackCompiler {
  async setup(options) {
    // Create a require context that is relative to project root
    // and retrieve all necessary dependencies.
    const requireFromRoot = createRequire(import.meta.dirname + '/../../..');
    /** @type {typeof import('@rspack/core')} */
    const rspack = await requireFromRoot('@rspack/core');

    const createConfig = await requireFromRoot('./rspack.config.cjs');
    const createDevConfig = await requireFromRoot('./rspack.config-dev.cjs');

    const config = createConfig({}, options);
    const devConfig = createDevConfig({}, options);

    const mergedConfig = { ...config, ...devConfig };
=======
export async function createCompiler(
  options: Record<string, any>,
): Promise<WebpackCompiler> {
  const compiler = new WebpackCompiler();
  await compiler.setup(options);

  return compiler;
}

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
type WebpackImport = typeof import('webpack');

class WebpackCompiler {
  public webpack: WebpackImport;
  public config: Record<string, any>;
  public bundleDir: string;

  async setup(options: Record<string, any>): Promise<void> {
    // Create a require context that is relative to project root
    // and retrieve all necessary dependencies.
    const requireFromRoot = createRequire(import.meta.dirname + '/../../..');
    const webpack: WebpackImport = await requireFromRoot('webpack');

    const createConfig = await requireFromRoot('./webpack.config.js');
    const config = createConfig({}, options);
>>>>>>> 8a4f06eed4 ([MIRROR] removes tgui sonar, dev server oversights (#11129)):tgui/packages/tgui-dev-server/webpack.ts

    // Inject the HMR plugin into the config if we're using it
    if (options.hot) {
      mergedConfig.plugins.push(new rspack.HotModuleReplacementPlugin());
    }
<<<<<<< HEAD:tgui/packages/tgui-dev-server/webpack.js
    this.rspack = rspack;
    this.config = mergedConfig;
=======

    this.webpack = webpack;
    this.config = config;
>>>>>>> 8a4f06eed4 ([MIRROR] removes tgui sonar, dev server oversights (#11129)):tgui/packages/tgui-dev-server/webpack.ts
    this.bundleDir = config.output.path;
  }

  async watch(): Promise<void> {
    logger.log('setting up');
    // Setup link
    const link = setupLink();
    // Instantiate the compiler
<<<<<<< HEAD:tgui/packages/tgui-dev-server/webpack.js
    const compiler = this.rspack.rspack(this.config);
=======
    const compiler = this.webpack.webpack(this.config);

>>>>>>> 8a4f06eed4 ([MIRROR] removes tgui sonar, dev server oversights (#11129)):tgui/packages/tgui-dev-server/webpack.ts
    // Clear garbage before compiling
    compiler.hooks.watchRun.tapPromise('tgui-dev-server', async () => {
      const files = await resolveGlob(this.bundleDir, './*.hot-update.*');
      logger.log(`clearing garbage (${files.length} files)`);
      for (const file of files) {
        await Bun.file(file).delete();
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
      broadcastMessage({
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
