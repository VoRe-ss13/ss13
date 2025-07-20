/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
/**
 * Returns a range of numbers from start to end, exclusively.
 * For example, range(0, 5) will return [0, 1, 2, 3, 4].
 */
export const range = (start: number, end: number): number[] =>
  new Array(end - start).fill(null).map((_, index) => index + start);

type ReduceFunction = {
  <T, U>(
    array: T[],
    reducerFn: (
      accumulator: U,
      currentValue: T,
      currentIndex: number,
      array: T[],
    ) => U,
    initialValue: U,
  ): U;
  <T>(
    array: T[],
    reducerFn: (
      accumulator: T,
      currentValue: T,
      currentIndex: number,
      array: T[],
    ) => T,
  ): T;
};

/**
 * Creates a duplicate-free version of an array, using SameValueZero for
 * equality comparisons, in which only the first occurrence of each element
 * is kept. The order of result values is determined by the order they occur
 * in the array.
 *
 * It accepts iteratee which is invoked for each element in array to generate
 * the criterion by which uniqueness is computed. The order of result values
 * is determined by the order they occur in the array. The iteratee is
 * invoked with one argument: value.
 */
export const uniqBy = <T extends unknown>(
  array: T[],
  iterateeFn?: (value: T) => unknown,
): T[] => {
  const { length } = array;
  const result: T[] = [];
  const seen: unknown[] = iterateeFn ? [] : result;
  let index = -1;
  // prettier-ignore
  outer:
    while (++index < length) {
      const value: T | 0 = array[index];
      const computed = iterateeFn ? iterateeFn(value) : value;
      if (computed === computed) {
        let seenIndex = seen.length;
        while (seenIndex--) {
          if (seen[seenIndex] === computed) {
            continue outer;
          }
        }
        if (iterateeFn) {
          seen.push(computed);
        }
        result.push(value);
      } else if (!seen.includes(computed)) {
        if (seen !== result) {
          seen.push(computed);
        }
        result.push(value);
      }
    }
  return result;
};

export const uniq = <T>(array: T[]): T[] => uniqBy(array);

type Zip<T extends unknown[][]> = {
  [I in keyof T]: T[I] extends (infer U)[] ? U : never;
}[];

/**
 * Creates an array of grouped elements, the first of which contains
 * the first elements of the given arrays, the second of which contains
 * the second elements of the given arrays, and so on.
 */
export const zip = <T extends unknown[][]>(...arrays: T): Zip<T> => {
  if (arrays.length === 0) {
    return [];
  }
  const numArrays = arrays.length;
  const numValues = arrays[0].length;
  const result: Zip<T> = [];
  for (let valueIndex = 0; valueIndex < numValues; valueIndex++) {
    const entry: unknown[] = [];
    for (let arrayIndex = 0; arrayIndex < numArrays; arrayIndex++) {
      entry.push(arrays[arrayIndex][valueIndex]);
    }

    // I tried everything to remove this any, and have no idea how to do it.
    result.push(entry as any);
  }
  return result;
};

=======
>>>>>>> 66b765887f ([MIRROR] another update and es-toolkit (#11212))
const binarySearch = <T, U = unknown>(
  getKey: (value: T) => U,
  collection: readonly T[],
  inserting: T,
): number => {
  if (collection.length === 0) {
    return 0;
  }

  const insertingKey = getKey(inserting);

  let [low, high] = [0, collection.length];

  // Because we have checked if the collection is empty, it's impossible
  // for this to be used before assignment.
  let compare: U = undefined as unknown as U;
  let middle = 0;

  while (low < high) {
    middle = (low + high) >> 1;

    compare = getKey(collection[middle]);

    if (compare < insertingKey) {
      low = middle + 1;
    } else if (compare === insertingKey) {
      return middle;
    } else {
      high = middle;
    }
  }

  return compare > insertingKey ? middle : middle + 1;
};

export const binaryInsertWith = <T, U = unknown>(
  collection: readonly T[],
  value: T,
  getKey: (value: T) => U,
): T[] => {
  const copy = [...collection];
  copy.splice(binarySearch(getKey, collection, value), 0, value);
  return copy;
};
