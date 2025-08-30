/**
 * Browser-agnostic abstraction of key-value web storage.
 *
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const IMPL_MEMORY = 0;
export const IMPL_HUB_STORAGE = 1;

type StorageImplementation = typeof IMPL_MEMORY | typeof IMPL_HUB_STORAGE;

const KEY_NAME = 'chomp'; // CHOMPEdit - CHOMPStation Localstore

type StorageBackend = {
  impl: StorageImplementation;
  get(key: string): Promise<any>;
  set(key: string, value: any): Promise<void>;
  remove(key: string): Promise<void>;
  clear(): Promise<void>;
};

const testGeneric = (testFn: () => boolean) => (): boolean => {
  try {
    return Boolean(testFn());
  } catch {
    return false;
  }
};

const testHubStorage = testGeneric(
  () => window.hubStorage && !!window.hubStorage.getItem,
);

class HubStorageBackend implements StorageBackend {
  public impl: StorageImplementation;

  constructor() {
    this.impl = IMPL_HUB_STORAGE;
  }

  async get(key: string): Promise<any> {
<<<<<<< HEAD
    const value = await window.hubStorage.getItem('chomp-' + key); // CHOMPEdit
=======
    const value = await window.hubStorage.getItem(`${KEY_NAME}-${key}`);
>>>>>>> 77f4b3d10f ([MIRROR] cleans up the storage  defines properly (#11537))
    if (typeof value === 'string') {
      return JSON.parse(value);
    }
    return undefined;
  }

  async set(key: string, value: any): Promise<void> {
<<<<<<< HEAD
    window.hubStorage.setItem('chomp-' + key, JSON.stringify(value)); // CHOMPEdit
  }

  async remove(key: string): Promise<void> {
    window.hubStorage.removeItem('chomp-' + key); // CHOMPEdit
=======
    window.hubStorage.setItem(`${KEY_NAME}-${key}`, JSON.stringify(value));
  }

  async remove(key: string): Promise<void> {
    window.hubStorage.removeItem(`${KEY_NAME}-${key}`);
>>>>>>> 77f4b3d10f ([MIRROR] cleans up the storage  defines properly (#11537))
  }

  async clear(): Promise<void> {
    window.hubStorage.clear();
  }
}

/**
 * Web Storage Proxy object, which selects the best backend available
 * depending on the environment.
 */
class StorageProxy implements StorageBackend {
  private backendPromise: Promise<StorageBackend>;
  public impl: StorageImplementation = IMPL_MEMORY;

  constructor() {
    this.backendPromise = (async () => {
      if (!Byond.TRIDENT) {
        if (!testHubStorage()) {
          return new Promise((resolve) => {
            const listener = () => {
              document.removeEventListener('byondstorageupdated', listener);
              resolve(new HubStorageBackend());
            };

            document.addEventListener('byondstorageupdated', listener);
          });
        }
        return new HubStorageBackend();
      }
    })() as Promise<StorageBackend>;
  }

  async get(key: string): Promise<any> {
    const backend = await this.backendPromise;
    return backend.get(key);
  }

  async set(key: string, value: any): Promise<void> {
    const backend = await this.backendPromise;
    return backend.set(key, value);
  }

  async remove(key: string): Promise<void> {
    const backend = await this.backendPromise;
    return backend.remove(key);
  }

  async clear(): Promise<void> {
    const backend = await this.backendPromise;
    return backend.clear();
  }
}

export const storage = new StorageProxy();
