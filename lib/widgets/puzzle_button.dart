import 'package:flutter/material.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

class PuzzleButton extends StatefulWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;

  const PuzzleButton({
    Key? key,
    this.text = "PLAY",
    this.iconData = Icons.arrow_forward_rounded,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PuzzleButton> createState() => _PuzzleButtonState();
}

class _PuzzleButtonState extends State<PuzzleButton> {
  bool isHovering = false;

  static const animationDuration = Duration(milliseconds: 100);
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
    return AnimatedPadding(
      duration: animationDuration,
      curve: animationCurve,
      padding: isHovering
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0)
          : const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
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
            child: AnimatedPadding(
              duration: animationDuration,
              curve: animationCurve,
              padding: isHovering
                  ? const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 50),
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
