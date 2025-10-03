export type Data = {
  activemode: number;
  matrixcolors: MatrixColors;
  buildhue: number;
  buildsat: number;
  buildval: number;
  temp: string | null;
  item: { name: string; sprite: string; preview: string } | null;
};

export type MatrixColors = {
  rr: number;
  rg: number;
  rb: number;
  gr: number;
  gg: number;
  gb: number;
  br: number;
  bg: number;
  bb: number;
  cr: number;
  cg: number;
  cb: number;
};

export type ColorPair = { input: string; output: string };
export type SelectedId = { id: number | null; type: 'input' | 'output' | null };

export type ColorUpdate = (hex: string, mode?: string, index?: number) => void;
