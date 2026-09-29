// THIS IS A MIXITE/13 UI FILE
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const TectonicResonator = (props) => {
  const { data } = useBackend();
  const { operational } = data;
  return (
    <Window width={400} height={170}>
      <Window.Content>
        <TectonicResonatorContent />
      </Window.Content>
    </Window>
  );
};

const TectonicResonatorContent = (props) => {
  const { act, data } = useBackend();
  const { depletion, pipe_count, extract_rate, on, is_drilling } = data;
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Depletion">
          <ProgressBar
            value={depletion / 100}
            ranges={{
              good: [-Infinity, 0.7],
              average: [0.7, 0.9],
              bad: [0.9, Infinity],
            }}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Pipe Count">
          {(pipe_count <= 0 && <Box color="bad">{pipe_count}</Box>) || (
            <Box color="good">{pipe_count}</Box>
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Depth">
          <Box color="good">{pipe_count}</Box>
        </LabeledList.Item>
        <LabeledList.Item label="Extraction Rate">
          {(extract_rate === 0 && <Box color="bad">{extract_rate} u/s</Box>) ||
            (extract_rate <= 10 && (
              <Box color="average">{extract_rate} u/s</Box>
            )) || <Box color="good">{extract_rate} u/s</Box>}
        </LabeledList.Item>
        <LabeledList.Item label="Power">
          <Button
            icon={on ? 'power-off' : 'times'}
            content={on ? 'On' : 'Off'}
            selected={on}
            disabled={false}
            onClick={() => act('toggle_drilling')}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
