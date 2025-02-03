<<<<<<< HEAD
import { filter } from 'common/collections';
import { flow } from 'common/fp';
import { createSearch } from 'common/string';
=======
import { flow } from 'tgui-core/fp';
import { createSearch } from 'tgui-core/string';
>>>>>>> 56759cb95b ([MIRROR] Work on phasing out tgui collections.ts (#10059))

import { spriteOption } from './types';

export function robotSpriteSearcher(
  searchText: string,
  includeDefault: boolean,
  includeWide: boolean,
  includeTall: boolean,
  sprites?: spriteOption[],
): spriteOption[] {
  const testSearch = createSearch(
    searchText,
    (sprite: spriteOption) => sprite.sprite,
  );
  if (!sprites) {
    return [];
  }
  let subtypes: string[] = [];
  if (includeDefault) {
    subtypes.push('def');
  }
  if (includeWide) {
    subtypes.push('wide');
  }
  if (includeTall) {
    subtypes.push('tall');
  }
  return flow([
    (sprites: spriteOption[]) => {
      if (!searchText) {
        return sprites;
      } else {
        return sprites.filter(testSearch);
      }
    },
    (sprites: spriteOption[]) => {
      if (!subtypes.length) {
        return sprites;
      } else {
        return sprites.filter((sprite) => subtypes.includes(sprite.type));
      }
    },
  ])(sprites);
}
