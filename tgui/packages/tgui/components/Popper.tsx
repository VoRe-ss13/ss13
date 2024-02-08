<<<<<<< HEAD
import { createPopper } from '@popperjs/core';
import { ArgumentsOf } from 'common/types';
import { Component, findDOMfromVNode, InfernoNode, render } from 'inferno';
=======
import { Placement } from '@popperjs/core';
import {
  PropsWithChildren,
  ReactNode,
  useEffect,
  useRef,
  useState,
} from 'react';
import { usePopper } from 'react-popper';
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))

type PopperProps = {
  popperContent: InfernoNode;
  options?: ArgumentsOf<typeof createPopper>[2];
  additionalStyles?: CSSProperties;
};

export class Popper extends Component<PopperProps> {
  static id: number = 0;

  renderedContent: HTMLDivElement;
  popperInstance: ReturnType<typeof createPopper>;

  constructor() {
    super();

<<<<<<< HEAD
    Popper.id += 1;
=======
  const [referenceElement, setReferenceElement] =
    useState<HTMLDivElement | null>(null);
  const [popperElement, setPopperElement] = useState<HTMLDivElement | null>(
    null,
  );

  // One would imagine we could just use useref here, but it's against react-popper documentation and causes a positioning bug
  // We still need them to call focus and clickoutside events :(
  const popperRef = useRef<HTMLDivElement | null>(null);
  const parentRef = useRef<HTMLDivElement | null>(null);

  const { styles, attributes } = usePopper(referenceElement, popperElement, {
    placement,
  });

  /** Close the popper when the user clicks outside */
  function handleClickOutside(event: MouseEvent) {
    if (
      !popperRef.current?.contains(event.target as Node) &&
      !parentRef.current?.contains(event.target as Node)
    ) {
      onClickOutside?.();
    }
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))
  }

  componentDidMount() {
    const { additionalStyles, options } = this.props;

    this.renderedContent = document.createElement('div');

    if (additionalStyles) {
      for (const [attribute, value] of Object.entries(additionalStyles)) {
        this.renderedContent.style[attribute] = value;
      }
    }

    this.renderPopperContent(() => {
      document.body.appendChild(this.renderedContent);

<<<<<<< HEAD
      // HACK: We don't want to create a wrapper, as it could break the layout
      // of consumers, so we do the inferno equivalent of `findDOMNode(this)`.
      // This is usually bad as refs are usually better, but refs did
      // not work in this case, as they weren't propagating correctly.
      // A previous attempt was made as a render prop that passed an ID,
      // but this made consuming use too unwieldly.
      // This code is copied from `findDOMNode` in inferno-extras.
      // Because this component is written in TypeScript, we will know
      // immediately if this internal variable is removed.
      const domNode = findDOMfromVNode(this.$LI, true);
      if (!domNode) {
        return;
      }

      this.popperInstance = createPopper(
        domNode,
        this.renderedContent,
        options
      );
    });
  }

  componentDidUpdate() {
    this.renderPopperContent(() => this.popperInstance?.update());
  }

  componentWillUnmount() {
    this.popperInstance?.destroy();
    render(null, this.renderedContent, () => {
      this.renderedContent.remove();
    });
  }

  renderPopperContent(callback: () => void) {
    // `render` errors when given false, so we convert it to `null`,
    // which is supported.
    render(this.props.popperContent || null, this.renderedContent, callback);
  }

  render() {
    return this.props.children;
  }
=======
  return (
    <>
      <div
        ref={(node) => {
          setReferenceElement(node);
          parentRef.current = node;
        }}
      >
        {children}
      </div>
      {isOpen && (
        <div
          ref={(node) => {
            setPopperElement(node);
            popperRef.current = node;
          }}
          style={{ ...styles.popper, zIndex: 5 }}
          {...attributes.popper}
        >
          {content}
        </div>
      )}
    </>
  );
>>>>>>> 84c6c7213e ([MIRROR] TGUI 5.0 Patch 2 ✨ (#7702))
}
