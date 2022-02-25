import 'package:flutter/material.dart';

class PuzzleSelectionCard extends StatefulWidget {
  final bool highlighted;
  final String titleText, descriptionText;

  const PuzzleSelectionCard({
    Key? key,
    required this.titleText,
    required this.descriptionText,
    this.highlighted = false,
  }) : super(key: key);

  @override
  _PuzzleSelectionCardState createState() => _PuzzleSelectionCardState();
}

class _PuzzleSelectionCardState extends State<PuzzleSelectionCard> {
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    isHovering = widget.highlighted;
  }

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
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 20),
        padding: isHovering
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 20),
          color: isHovering ? Colors.orange[200] : Colors.grey[100],
          padding: isHovering
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
              : const EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.titleText,
                  style: isHovering?Theme.of(context).textTheme.headline5:Theme.of(context).textTheme.headline6,
                ),
                Text(
                  widget.titleText,
                  style: isHovering?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.subtitle2,
                ),
                AnimatedOpacity(
                  opacity: isHovering ? 1 : 0,
                  duration: const Duration(milliseconds: 20),
                  child: MaterialButton(
                    child: Text(
                      "START",
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
