import 'dart:math' as math;

import 'package:atomic_x/base_component/base_component.dart';
import 'package:atomic_x_core/atomicxcore.dart';
import 'package:flutter/material.dart';

class MessageMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const MessageMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}

abstract class MessageMenuCallbacks {
  void onCopyMessage(MessageInfo message);

  void onDeleteMessage(MessageInfo message);

  void onRecallMessage(MessageInfo message);

  void onForwardMessage(MessageInfo message);

  void onQuoteMessage(MessageInfo message);

  void onMultiSelectMessage(MessageInfo message);

  void onResendMessage(MessageInfo message);
}

class MessageTooltip extends StatefulWidget {
  final List<MessageMenuItem> menuItems;
  final MessageInfo message;
  final VoidCallback onCloseTooltip;
  final bool isSelf;

  const MessageTooltip({
    super.key,
    required this.menuItems,
    required this.message,
    required this.onCloseTooltip,
    required this.isSelf,
  });

  @override
  State<StatefulWidget> createState() => MessageTooltipState();
}

class MessageTooltipState extends State<MessageTooltip> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = BaseThemeProvider.colorsOf(context);

    return Container(
      decoration: BoxDecoration(
        color: colorTheme.bgColorOperate,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: math.min(MediaQuery.of(context).size.width * 0.75, 350),
        ),
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: widget.menuItems.map((item) => _buildMenuItem(item, colorTheme)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MessageMenuItem item, SemanticColorScheme colorTheme) {
    return Material(
      color: colorTheme.bgColorOperate,
      child: InkWell(
        onTap: () {
          widget.onCloseTooltip();
          item.onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(
            minWidth: 44,
            maxWidth: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                size: 20,
                color: item.isDestructive ? colorTheme.textColorError : colorTheme.textColorPrimary,
              ),
              const SizedBox(height: 4),
              Text(
                item.title,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: item.isDestructive ? colorTheme.textColorError : colorTheme.textColorPrimary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
