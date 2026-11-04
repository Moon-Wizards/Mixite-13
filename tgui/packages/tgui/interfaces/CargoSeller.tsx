// THIS IS A MIXITE/13 UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type CargoSellerData = {
  account_balance: number;
  items: SellingItem[];
  preview_value: number;
  message: string;
  currency_full_name: string;
  currency_symbol: string;
};

type SellingItem = {
  name: string;
  value: number;
  is_manifest?: boolean;
};

export function CargoSeller() {
  const { act, data } = useBackend<CargoSellerData>();
  const {
    account_balance,
    items = [],
    preview_value,
    message,
    currency_full_name,
    currency_symbol,
  } = data;

  return (
    <Window width={500} height={600}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title="Supply Selling"
              buttons={
                <Box inline bold verticalAlign="middle">
                  {formatMoney(account_balance)} {currency_full_name}
                </Box>
              }
            >
              <LabeledList>
                <LabeledList.Item label="CentCom Message">
                  <Box style={{ whiteSpace: 'pre-wrap' }}>{message}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Preview Value">
                  <Box style={{ whiteSpace: 'pre-wrap' }}>
                    {formatMoney(preview_value)}
                    {currency_symbol}
                  </Box>
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>

          <Stack.Item grow>
            <Section fill scrollable title="Pending">
              {items.length === 0 ? (
                <NoticeBox>No cargo in the selling zone.</NoticeBox>
              ) : (
                <Table>
                  <Table.Row header color="gray">
                    <Table.Cell>Item</Table.Cell>
                    <Table.Cell collapsing textAlign="right">
                      Value
                    </Table.Cell>
                  </Table.Row>
                  {items.map((item, index) => (
                    <Table.Row
                      className="candystripe"
                      key={`${item.name}-${index}`}
                    >
                      <Table.Cell>
                        {item.name.replace(/\b\w/g, (l) => l.toUpperCase())}
                      </Table.Cell>
                      <Table.Cell
                        collapsing
                        color={item.is_manifest ? 'blue' : item.value > 0 ? 'gold' : 'red'}
                        textAlign="right"
                      >
                        {item.is_manifest ? '...' : item.value > 0 ? `${formatMoney(item.value)} ${currency_symbol}` : 'N/A'}
                      </Table.Cell>
                    </Table.Row>
                  ))}
                </Table>
              )}
            </Section>
          </Stack.Item>

          <Stack.Item>
            <Section align="right">
              <Button
                color="green"
                disabled={items.length === 0}
                onClick={() => act('sell')}
              >
                Sell
              </Button>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}
