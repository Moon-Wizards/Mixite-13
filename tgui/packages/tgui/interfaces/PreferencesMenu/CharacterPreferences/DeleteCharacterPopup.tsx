import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, Modal, Stack } from 'tgui-core/components';

import type { PreferencesMenuData } from '../types';

type Props = {
  close: () => void;
};

export function DeleteCharacterPopup(props: Props) {
  const { data, act } = useBackend<PreferencesMenuData>();
  const [secondsLeft, setSecondsLeft] = useState(3);
  const [required, setRequired] = useState(false);

  const { close } = props;

  useEffect(() => {
    if (!required || secondsLeft <= 0) return;
    const interval = setInterval(() => {
      setSecondsLeft((current) => Math.max(0, current - 1));
    }, 1000);

    return () => clearInterval(interval);
  }, [required, secondsLeft]);

  const toggleRequired = () => {
    setRequired((current) => {
      const next = !current;

      if (!next) {
        setSecondsLeft(3);
      }

      return next;
    });
  };

  return (
    <Modal>
      <Stack vertical textAlign="center" align="center">
        <Stack.Item>
          <Box fontSize="3em">Wait!</Box>
        </Stack.Item>

        <Stack.Item maxWidth="300px">
          <Box>
            {`You're about to delete ${data.character_preferences.names[data.name_to_use]} forever. Are you sure you want to do this?`}
          </Box>
        </Stack.Item>

        <Stack.Item>
          <Button.Checkbox checked={required} onClick={toggleRequired}>
            Yes, do exactly as I say!
          </Button.Checkbox>
        </Stack.Item>

        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              {/* Explicit width so that the layout doesn't shift */}
              <Button
                color="danger"
                disabled={!required || secondsLeft > 0}
                width="80px"
                onClick={() => {
                  act('remove_current_slot');
                  close();
                }}
              >
                {secondsLeft <= 0 ? 'Delete' : `Delete (${secondsLeft})`}
              </Button>
            </Stack.Item>

            <Stack.Item>
              <Button onClick={close}>{"No, don't delete"}</Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Modal>
  );
}
