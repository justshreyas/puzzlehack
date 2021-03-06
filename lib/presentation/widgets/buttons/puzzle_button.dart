import 'package:flutter/material.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/display_size.dart';
import 'package:puzzlehack/presentation/utils/layout_constants.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';

class PuzzleButton extends StatefulWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final DisplaySize displaySize;

  const PuzzleButton({
    Key? key,
    this.text = "PLAY",
    this.iconData = Icons.arrow_forward_rounded,
    this.onPressed,
    required this.displaySize,
  }) : super(key: key);

  @override
  State<PuzzleButton> createState() => _PuzzleButtonState();
}

class _PuzzleButtonState extends State<PuzzleButton> {
  bool isHovering = false;

  static const animationCurve = Curves.easeIn;

  void onEnter(PointerEvent details) {
    setState(() {
      isHovering = true;
    });
  }

  void onExit(PointerEvent details) {
    setState(() {
      isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AnimationConstants.shortDuration,
      height: LayoutConstants.buttonSize(widget.displaySize).height,
      width: LayoutConstants.buttonSize(widget.displaySize).width,
      child: AnimatedPadding(
        duration: AnimationConstants.shortDuration,
        curve: animationCurve,
        padding: isHovering
            ? const EdgeInsets.all(0)
            : LayoutConstants.componentOnHoverPadding(widget.displaySize),
        child: MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: isHovering ? Colors.orange[600] : Colors.orange,
              ),
              padding: isHovering
                  ? const EdgeInsets.all(0)
                  : LayoutConstants.componentOnHoverPadding(widget.displaySize),
              alignment: Alignment.center,
              child: AnimatedDefaultTextStyle(
                duration: AnimationConstants.shortestDuration,
                style: context.sizeAwareTextTheme.button!,
                child: Text(
                  widget.text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
