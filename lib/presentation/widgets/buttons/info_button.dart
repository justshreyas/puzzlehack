import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';

class PuzzleInfoButton extends StatefulWidget {
  final AudioManagerCubit audioManagerCubit;

  const PuzzleInfoButton({
    Key? key,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  State<PuzzleInfoButton> createState() => _PuzzleInfoButtonState();
}

class _PuzzleInfoButtonState extends State<PuzzleInfoButton> {
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
  }

  void onEnter(PointerEvent details) {
    setState(() {
      isHovering = true;
    });

    if (widget.audioManagerCubit.state.soundsEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playComponentHoveredSound();
    }
  }

  void onExit(PointerEvent details) {
    setState(() {
      isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: AnimationConstants.shortestDuration,
      padding:
          isHovering ? const EdgeInsets.all(10.0) : const EdgeInsets.all(20.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: onEnter,
        onExit: onExit,
        child: GestureDetector(
          onTap: () {
            if (widget.audioManagerCubit.state.soundsEnabled) {
              widget.audioManagerCubit.audioDataDelegate
                  .playComponentSelectedSound();
            }
            showAboutDialog(
              context: context,
            );
          },
          child: AnimatedContainer(
            duration: AnimationConstants.mediumDuration,
            decoration: BoxDecoration(
              border: Border.all(
                color: isHovering ? Colors.orange[600]! : Colors.orange,
                width: 2,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Icon(
                  Icons.more_horiz_sharp,
                  color: isHovering ? Colors.orange[600]! : Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
