import 'package:flutter/material.dart';

class SlideTextSwitcher extends StatelessWidget {
  final String text;

  final TextStyle? style;

  final Duration duration;

  final Curve curve;

  final TextAlign? textAlign;

  final int? maxLines;

  final TextOverflow? overflow;

  const SlideTextSwitcher({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        final isEntering = child.key == ValueKey(text);
        final tween = isEntering
            ? Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
            : Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero);
        return ClipRect(
          child: SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: curve),
            ),
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: Text(
        text,
        key: ValueKey(text),
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
