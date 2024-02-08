<<<<<<< HEAD
import { StoreProvider, configureStore } from 'tgui/store';

import { DisposalBin } from 'tgui/interfaces/DisposalBin';
import { backendUpdate } from 'tgui/backend';
=======
import { backendUpdate, setGlobalStore } from 'tgui/backend';
import { DisposalBin } from 'tgui/interfaces/DisposalBin';
>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { createRenderer } from 'tgui/renderer';
import { configureStore } from 'tgui/store';

const store = configureStore({ sideEffects: false });

const renderUi = createRenderer((dataJson: string) => {
  store.dispatch(
    backendUpdate({
      data: Byond.parseJson(dataJson),
    })
  );
  return (
    <StoreProvider store={store}>
      <DisposalBin />
    </StoreProvider>
  );
});

export const data = JSON.stringify({
  flush: 0,
  full_pressure: 1,
  pressure_charging: 0,
  panel_open: 0,
  per: 1,
  isai: 0,
});

export const Default = () => renderUi(data);
