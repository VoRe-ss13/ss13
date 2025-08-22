import { Button, Icon, Table } from 'tgui-core/components';

export const SortButton = (props: {
  ourId: string;
  sortId: string;
  sortOrder: string;
  onSortOrder: Function;
  onSortId: Function;
  children: React.JSX.Element | string;
}) => {
  const { ourId, sortId, sortOrder, onSortOrder, onSortId, children } = props;

  // Hey, same keys mean same data~

  return (
    <Table.Cell collapsing>
      <Button
        width="100%"
        color={sortId !== ourId && 'transparent'}
        onClick={() => {
          if (sortId === ourId) {
            onSortOrder(!props.sortOrder);
          } else {
            onSortId(ourId);
            onSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === ourId && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};
