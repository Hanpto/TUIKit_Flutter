import 'package:flutter/material.dart';
import 'package:atomic_x/base_component/base_component.dart';
import 'package:atomic_x/message_list/utils/message_utils.dart';
import 'package:atomic_x_core/atomicxcore.dart';

class SystemMessageWidget extends StatelessWidget {
  final MessageInfo message;

  const SystemMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorsTheme = BaseThemeProvider.colorsOf(context);
    final systemContent = MessageUtil.getSystemInfoDisplayString(
      message.messageBody?.systemMessage ?? [], 
      context
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colorsTheme.strokeColorPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            systemContent,
            style: TextStyle(
              fontSize: 12,
              color: colorsTheme.textColorTertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}