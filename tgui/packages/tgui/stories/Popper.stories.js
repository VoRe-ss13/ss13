import { Box, Popper } from '../components';

export const meta = {
  title: 'Popper',
  render: () => <Story />,
};

const Story = () => {
  return (
    <>
      <Popper
        popperContent={
          <Box
            style={{
              background: 'white',
              border: '2px solid blue',
            }}
          >
            Loogatme!
          </Box>
        }
<<<<<<< HEAD
        options={{
          placement: 'bottom',
        }}>
=======
        placement="bottom"
      >
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))
        <Box
          style={{
            border: '5px solid white',
            height: '300px',
            width: '200px',
          }}
        />
      </Popper>

      <Popper
        popperContent={
          <Box
            style={{
              background: 'white',
              border: '2px solid blue',
            }}
          >
            I am on the right!
          </Box>
        }
<<<<<<< HEAD
        options={{
          placement: 'right',
        }}>
=======
        placement="right"
      >
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))
        <Box
          style={{
            border: '5px solid white',
            height: '500px',
            width: '100px',
          }}
        />
      </Popper>
    </>
  );
};
