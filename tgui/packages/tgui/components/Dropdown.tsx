import { classes } from 'common/react';
<<<<<<< HEAD
import { Component, findDOMfromVNode, InfernoNode, render } from 'inferno';
import { Box, BoxProps } from './Box';
=======
import { ReactNode, useCallback, useEffect, useRef, useState } from 'react';

import { BoxProps, unit } from './Box';
>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
import { Button } from './Button';
import { Icon } from './Icon';
import { Popper } from './Popper';

<<<<<<< HEAD
export interface DropdownEntry {
  displayText: string | number | InfernoNode;
  value: string | number | Enumerator;
}

type DropdownUniqueProps = {
  options: string[] | DropdownEntry[];
  icon?: string;
  iconRotation?: number;
  clipSelectedText?: boolean;
  width?: string;
  menuWidth?: string;
  over?: boolean;
  color?: string;
  nochevron?: boolean;
  displayText?: string | number | InfernoNode;
  onClick?: (event) => void;
  // you freaks really are just doing anything with this shit
  selected?: any;
  onSelected?: (selected: any) => void;
  buttons?: boolean;
};
=======
type DropdownEntry = {
  displayText: ReactNode;
  value: string | number;
};

type DropdownOption = string | DropdownEntry;

type Props = {
  /** An array of strings which will be displayed in the
  dropdown when open. See Dropdown.tsx for more advanced usage with DropdownEntry */
  options: DropdownOption[];
  /** Called when a value is picked from the list, `value` is the value that was picked */
  onSelected: (value: any) => void;
} & Partial<{
  /** Whether to display previous / next buttons */
  buttons: boolean;
  /** Whether to clip the selected text */
  clipSelectedText: boolean;
  /** Color of dropdown button */
  color: string;
  /** Disables the dropdown */
  disabled: boolean;
  /** Text to always display in place of the selected text */
  displayText: ReactNode;
  /** Icon to display in dropdown button */
  icon: string;
  /** Angle of the icon */
  iconRotation: number;
  /** Whether or not the icon should spin */
  iconSpin: boolean;
  /** Width of the dropdown menu. Default: 15rem */
  menuWidth: string;
  /** Whether or not the arrow on the right hand side of the dropdown button is visible */
  noChevron: boolean;
  /** Called when dropdown button is clicked */
  onClick: (event) => void;
  /** Dropdown renders over instead of below */
  over: boolean;
  /** Currently selected entry */
  selected: string | number;
}> &
  BoxProps;

function getOptionValue(option: DropdownOption) {
  return typeof option === 'string' ? option : option.value;
}

export function Dropdown(props: Props) {
  const {
    buttons,
    className,
    clipSelectedText = true,
    color = 'default',
    disabled,
    displayText,
    icon,
    iconRotation,
    iconSpin,
    menuWidth = '15rem',
    noChevron,
    onClick,
    onSelected,
    options = [],
    over,
    selected,
    width,
  } = props;
>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))

  const [open, setOpen] = useState(false);
  const adjustedOpen = over ? !open : open;
  const innerRef = useRef<HTMLDivElement>(null);

<<<<<<< HEAD
const DEFAULT_OPTIONS = {
  placement: 'left-start',
  modifiers: [
    {
      name: 'eventListeners',
      enabled: false,
    },
  ],
};
const NULL_RECT: DOMRect = {
  width: 0,
  height: 0,
  top: 0,
  right: 0,
  bottom: 0,
  left: 0,
  x: 0,
  y: 0,
  toJSON: () => null,
} as const;

type DropdownState = {
  selected?: string;
  open: boolean;
};

const DROPDOWN_DEFAULT_CLASSNAMES = 'Layout Dropdown__menu';
const DROPDOWN_SCROLL_CLASSNAMES = 'Layout Dropdown__menu-scroll';

export class Dropdown extends Component<DropdownProps, DropdownState> {
  static renderedMenu: HTMLDivElement | undefined;
  static singletonPopper: ReturnType<typeof createPopper> | undefined;
  static currentOpenMenu: Element | undefined;
  static virtualElement: VirtualElement = {
    getBoundingClientRect: () =>
      Dropdown.currentOpenMenu?.getBoundingClientRect() ?? NULL_RECT,
  };
  menuContents: any;
  state: DropdownState = {
    open: false,
    selected: this.props.selected,
  };

  handleClick = () => {
    if (this.state.open) {
      this.setOpen(false);
    }
  };

  getDOMNode() {
    return findDOMfromVNode(this.$LI, true);
  }

  componentDidMount() {
    const domNode = this.getDOMNode();

    if (!domNode) {
      return;
    }
  }

  openMenu() {
    let renderedMenu = Dropdown.renderedMenu;
    if (renderedMenu === undefined) {
      renderedMenu = document.createElement('div');
      renderedMenu.className = DROPDOWN_DEFAULT_CLASSNAMES;
      document.body.appendChild(renderedMenu);
      Dropdown.renderedMenu = renderedMenu;
    }

    const domNode = this.getDOMNode()!;
    Dropdown.currentOpenMenu = domNode;

    renderedMenu.scrollTop = 0;
    renderedMenu.style.width =
      this.props.menuWidth ||
      // Hack, but domNode should *always* be the parent control meaning it will have width
      // @ts-ignore
      `${domNode.offsetWidth}px`;
    renderedMenu.style.opacity = '1';
    renderedMenu.style.pointerEvents = 'auto';

    // ie hack
    // ie has this bizarre behavior where focus just silently fails if the
    // element being targeted "isn't ready"
    // 400 is probably way too high, but the lack of hotloading is testing my
    // patience on tuning it
    // I'm beyond giving a shit at this point it fucking works whatever
    setTimeout(() => {
      Dropdown.renderedMenu?.focus();
    }, 400);
    this.renderMenuContent();
  }

  closeMenu() {
    if (Dropdown.currentOpenMenu !== this.getDOMNode()) {
      return;
    }

    Dropdown.currentOpenMenu = undefined;
    Dropdown.renderedMenu!.style.opacity = '0';
    Dropdown.renderedMenu!.style.pointerEvents = 'none';
  }

  componentWillUnmount() {
    this.closeMenu();
    this.setOpen(false);
  }

  renderMenuContent() {
    const renderedMenu = Dropdown.renderedMenu;
    if (!renderedMenu) {
      return;
    }
    if (renderedMenu.offsetHeight > 200) {
      renderedMenu.className = DROPDOWN_SCROLL_CLASSNAMES;
    } else {
      renderedMenu.className = DROPDOWN_DEFAULT_CLASSNAMES;
    }

    const { options = [] } = this.props;
    const ops = options.map((option) => {
      let value, displayText;

      if (typeof option === 'string') {
        displayText = option;
        value = option;
      } else if (option !== null) {
        displayText = option.displayText;
        value = option.value;
=======
  /** Update the selected value when clicking the left/right buttons */
  const updateSelected = useCallback(
    (direction: 'previous' | 'next') => {
      if (options.length < 1 || disabled) {
        return;
>>>>>>> eebf92d66f ([MIRROR] TGUI 5.0 Patch 1 (#7701))
      }
      const startIndex = 0;
      const endIndex = options.length - 1;

      let selectedIndex = options.findIndex(
        (option) => getOptionValue(option) === selected
      );

      if (selectedIndex < 0) {
        selectedIndex = direction === 'next' ? endIndex : startIndex;
      }

      let newIndex = selectedIndex;
      if (direction === 'next') {
        newIndex = selectedIndex === endIndex ? startIndex : selectedIndex++;
      } else {
        newIndex = selectedIndex === startIndex ? endIndex : selectedIndex--;
      }

      onSelected?.(getOptionValue(options[newIndex]));
    },
    [disabled, onSelected, options, selected]
  );

  /** Allows the menu to be scrollable on open */
  useEffect(() => {
    if (!open) return;

    innerRef.current?.focus();
  }, [open]);

  return (
    <Popper
      isOpen={open}
      onClickOutside={() => setOpen(false)}
      placement={over ? 'top-start' : 'bottom-start'}
      content={
        <div
          className="Layout Dropdown__menu"
          style={{ minWidth: menuWidth }}
          ref={innerRef}>
          {options.length === 0 && (
            <div className="Dropdown__menuentry">No options</div>
          )}

          {options.map((option, index) => {
            const value = getOptionValue(option);

            return (
              <div
                className={classes([
                  'Dropdown__menuentry',
                  selected === value && 'selected',
                ])}
                key={index}
                onClick={() => {
                  setOpen(false);
                  onSelected?.(value);
                }}>
                {typeof option === 'string' ? option : option.displayText}
              </div>
            );
          })}
        </div>
      }>
      <div>
        <div className="Dropdown" style={{ width: unit(width) }}>
          <div
            className={classes([
              'Dropdown__control',
              'Button',
              'Button--dropdown',
              'Button--color--' + color,
              disabled && 'Button--disabled',
              className,
            ])}
            onClick={(event) => {
              if (disabled && !open) {
                return;
              }
              setOpen(!open);
              onClick?.(event);
            }}>
            {icon && (
              <Icon
                mr={1}
                name={icon}
                rotation={iconRotation}
                spin={iconSpin}
              />
            )}
            <span
              className="Dropdown__selected-text"
              style={{
                overflow: clipSelectedText ? 'hidden' : 'visible',
              }}>
              {displayText || selected}
            </span>
            {!noChevron && (
              <span className="Dropdown__arrow-button">
                <Icon name={adjustedOpen ? 'chevron-up' : 'chevron-down'} />
              </span>
            )}
          </div>
          {buttons && (
            <>
              <Button
                disabled={disabled}
                height={1.8}
                icon="chevron-left"
                onClick={() => {
                  updateSelected('previous');
                }}
              />

              <Button
                disabled={disabled}
                height={1.8}
                icon="chevron-right"
                onClick={() => {
                  updateSelected('next');
                }}
              />
            </>
          )}
        </div>
      </div>
    </Popper>
  );
}
