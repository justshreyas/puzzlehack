import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';

class PuzzleSettingsToggleButton extends StatefulWidget {
  final AudioManagerCubit audioManagerCubit;
  final IconData enabledIcon, disabledIcon;
  final VoidCallback onTap;
  final bool enabled;

  const PuzzleSettingsToggleButton({
    Key? key,
    required this.audioManagerCubit,
    required this.enabledIcon,
    required this.disabledIcon,
    required this.onTap,
    required this.enabled,
  }) : super(key: key);

  @override
  State<PuzzleSettingsToggleButton> createState() =>
      _PuzzleSettingsToggleButtonState();
}

class _PuzzleSettingsToggleButtonState
    extends State<PuzzleSettingsToggleButton> {
  bool isHovering = false;
  bool didChangeOnHover = false;

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
      didChangeOnHover = false;
    });
  }

  Color get color {
    if (isHovering && widget.enabled) {
      return Colors.orange[600]!;
    } else if (widget.enabled) {
      return Colors.orange;
    } else if ((isHovering && !widget.enabled && !didChangeOnHover)) {
      return Colors.orange[400]!;
    } else {
      return Colors.grey[400]!;
    }
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
            setState(() {
              didChangeOnHover = true;
            });
            widget.onTap();
          },
          child: AnimatedContainer(
            duration: AnimationConstants.mediumDuration,
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Icon(
                  widget.enabled ? widget.enabledIcon : widget.disabledIcon,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
