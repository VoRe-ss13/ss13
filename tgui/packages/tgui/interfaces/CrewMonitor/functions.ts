import { flow } from 'tgui-core/fp';

import { crewmember } from './types';

export function getStatText(cm: crewmember) {
  if (cm.dead) {
    return 'Deceased';
  }
  if (cm.stat === 1) {
    // Unconscious
    return 'Unconscious';
  }
  return 'Living';
}

export function getStatColor(cm: crewmember) {
  if (cm.dead) {
    return 'red';
  }
  if (cm.stat === 1) {
    // Unconscious
    return 'orange';
  }
  return 'green';
}

export function getTotalDamage(cm: crewmember) {
  return cm.brute + cm.fire + cm.oxy + cm.tox;
}

function crewStatus(
  cm: crewmember,
  deceasedStatus: boolean,
  livingStatus: boolean,
  unconsciousStatus: boolean,
) {
  if (deceasedStatus && cm.dead) {
    return true;
  }
  if (livingStatus && !cm.dead && (!cm.stat || cm.stat < 1)) {
    return true;
  }
  if (unconsciousStatus && cm.stat === 1) {
    return true;
  }
  return false;
}

export function getShownCrew(
  crew: crewmember[],
  locationSearch: object,
  deceasedStatus: boolean,
  livingStatus: boolean,
  unconsciousStatus: boolean,
  nameSearch: string,
  testSearch: (obj: crewmember) => boolean,
) {
  return flow([
    (crew: crewmember[]) => {
      if (!locationSearch) {
        return crew;
      } else {
        return crew.filter((cm) => locationSearch[cm.realZ.toString()]);
      }
    },
    (crew: crewmember[]) => {
      return crew.filter((cm) =>
        crewStatus(cm, deceasedStatus, livingStatus, unconsciousStatus),
      );
    },
    (crew: crewmember[]) => {
      if (!nameSearch) {
        return crew;
      } else {
        return crew.filter(testSearch);
      }
    },
  ])(crew);
}

export function getSortedCrew(
  shownCrew: crewmember[],
  sortType: string,
  nameSortOrder: boolean,
  damageSortOrder: boolean,
  locationSortOrder: boolean,
) {
  return flow([
    (shownCrew: crewmember[]) => {
      if (sortType === 'name') {
<<<<<<< HEAD
        const sorted = sortBy(shownCrew, (cm) => cm.name);
=======
        const sorted = shownCrew.sort(
          (a, b) =>
            a.name.localeCompare(b.name) ||
            a.realZ - b.realZ ||
            a.x - b.x ||
            a.y - b.y,
        );
>>>>>>> 56759cb95b ([MIRROR] Work on phasing out tgui collections.ts (#10059))
        if (nameSortOrder) {
          return sorted.reverse();
        }
        return sorted;
      } else {
        return shownCrew;
      }
    },
    (shownCrew: crewmember[]) => {
      if (sortType === 'damage') {
<<<<<<< HEAD
        const sorted = sortBy(shownCrew, (cm) => getTotalDamage(cm));
=======
        const sorted = shownCrew.sort(
          (a, b) =>
            getTotalDamage(a) - getTotalDamage(b) ||
            a.name.localeCompare(b.name),
        );
>>>>>>> 56759cb95b ([MIRROR] Work on phasing out tgui collections.ts (#10059))
        if (damageSortOrder) {
          return sorted.reverse();
        }
        return sorted;
      } else {
        return shownCrew;
      }
    },
    (shownCrew: crewmember[]) => {
      if (sortType === 'location') {
<<<<<<< HEAD
        const sorted = sortBy(shownCrew, (cm) => cm.x);
        if (locationSortOrder) {
          return sorted.reverse();
        }
        return sorted;
      } else {
        return shownCrew;
      }
    },
    (shownCrew: crewmember[]) => {
      if (sortType === 'location') {
        const sorted = shownCrew.sort((a, b) => a.y - b.y);
        if (locationSortOrder) {
          return sorted.reverse();
        }
        return sorted;
      } else {
        return shownCrew;
      }
    },
    (shownCrew: crewmember[]) => {
      if (sortType === 'location') {
        const sorted = sortBy(shownCrew, (cm) => cm.realZ);
=======
        const sorted = shownCrew.sort(
          (a, b) =>
            a.realZ - b.realZ ||
            a.x - b.x ||
            a.y - b.y ||
            a.name.localeCompare(b.name),
        );
>>>>>>> 56759cb95b ([MIRROR] Work on phasing out tgui collections.ts (#10059))
        if (locationSortOrder) {
          return sorted.reverse();
        }
        return sorted;
      } else {
        return shownCrew;
      }
    },
  ])(shownCrew);
}
