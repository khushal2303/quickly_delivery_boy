import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

/// Partially visible bottom sheet that can be dragged into the screen. Provides different views for expanded and collapsed states
class DraggableBottomSheet extends StatefulWidget {
  /// Alignment of the sheet
  final Alignment alignment;

  /// This widget will hide behind the sheet when expanded.
  final Widget backgroundWidget;

  /// Whether to blur the background while sheet expnasion (true: modal-sheet false: persistent-sheet)
  final bool blurBackground;

  /// Child of expended sheet
  final Widget expandedChild;

  /// Extent from the min-height to change from previewChild to expandedChild
  final double expansionExtent;

  /// Max-extent for sheet expansion
  final double maxExtent;

  /// Min-extent for the sheet, also the original height of the sheet
  final double minExtent;

  /// Scroll direction of the sheet
  final Axis scrollDirection;

  final Widget? bottomStickWidget;

  DraggableBottomSheet({
    this.alignment = Alignment.bottomLeft,
    required this.backgroundWidget,
    this.blurBackground = true,
    required this.expandedChild,
    this.expansionExtent = 10,
    this.maxExtent = double.infinity,
    this.minExtent = 10,
    this.scrollDirection = Axis.vertical,
    this.bottomStickWidget,
  });

  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  double currentHeight = 150;
  double newHeight = 150;

  @override
  void initState() {
    this.currentHeight = widget.minExtent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.backgroundWidget,
        (currentHeight - widget.minExtent < 10 || !widget.blurBackground)
            ? SizedBox()
            : Positioned.fill(
                child: GestureDetector(
                onTap: () => setState(() => currentHeight = widget.minExtent),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  ),
                ),
              )),
        Align(
          alignment: widget.alignment,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (widget.scrollDirection == Axis.horizontal) return;
              newHeight = currentHeight - details.delta.dy;
              if (newHeight > widget.minExtent &&
                  newHeight < widget.maxExtent) {
                setState(() => currentHeight = newHeight);
              }
            },
            onHorizontalDragUpdate: (details) {
              if (widget.scrollDirection == Axis.vertical) return;
              newHeight = currentHeight + details.delta.dx;
              if (newHeight > widget.minExtent &&
                  newHeight < widget.maxExtent) {
                setState(() => currentHeight = newHeight);
              }
            },
            child: SizedBox(
              width: (widget.scrollDirection == Axis.vertical)
                  ? double.infinity
                  : currentHeight,
              height: (widget.scrollDirection == Axis.horizontal)
                  ? double.infinity
                  : currentHeight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: (widget.scrollDirection == Axis.vertical)
                      ? double.infinity
                      : currentHeight,
                  maxHeight: (widget.scrollDirection == Axis.horizontal)
                      ? double.infinity
                      : currentHeight,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: widget.expandedChild,
                    ),
                    if (widget.bottomStickWidget != null)
                      widget.bottomStickWidget!
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
