import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FadeOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  FadeOnScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0});

  @override
  _FadeOnScrollState createState() => _FadeOnScrollState();
}

class _FadeOnScrollState extends State<FadeOnScroll> {
  double _offset;
  ScrollDirection _scrollDirection;
  double _currentOpacity = 1.0;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    _scrollDirection = widget.scrollController.position.userScrollDirection;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
      _scrollDirection = widget.scrollController.position.userScrollDirection;
    });
  }

  double _calculateOpacity() {
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset)
      _currentOpacity=  1;
    else if (_scrollDirection == ScrollDirection.forward) {
      // fading in
      if (_offset <= widget.fullOpacityOffset)
        _currentOpacity = 1;
      else if (_offset > widget.zeroOpacityOffset)
        _currentOpacity = 0;
      else _currentOpacity = (_offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset);
    } else if (_scrollDirection == ScrollDirection.reverse) {
      // fading out
      if (_offset >= widget.zeroOpacityOffset)
        _currentOpacity = 0;
      else if (_offset < widget.fullOpacityOffset)
        _currentOpacity = 1;
      else {
        _currentOpacity = (1 - (_offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset)).abs();
      }
    }
    return _currentOpacity;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: widget.child,
    );
  }
}
