import 'package:flutter/material.dart' hide AlertDialog;
import 'package:flutter/material.dart' as material show AlertDialog;
import '../localizations/atomic_localizations.dart';
import '../theme/theme_state.dart';

class AlertDialogConfig {
  final String title;
  final String content;
  final String? cancelText;
  final String? confirmText;
  final bool isDestructive;
  final VoidCallback? onConfirm;

  const AlertDialogConfig({
    required this.title,
    required this.content,
    this.cancelText,
    this.confirmText,
    this.isDestructive = false,
    this.onConfirm,
  });
}

class AlertDialog extends StatelessWidget {
  final AlertDialogConfig config;

  const AlertDialog({
    super.key,
    required this.config,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
    bool isDestructive = false,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          config: AlertDialogConfig(
            title: title,
            content: content,
            cancelText: cancelText,
            confirmText: confirmText,
            isDestructive: isDestructive,
            onConfirm: onConfirm,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorsTheme = BaseThemeProvider.colorsOf(context);
    final appLocale = AtomicLocalizations.of(context);

    return material.AlertDialog(
      backgroundColor: colorsTheme.bgColorDialog,
      title: config.title.isNotEmpty ? Text(
        config.title,
        style: TextStyle(
          color: colorsTheme.textColorPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ) : null,
      content: config.content.isNotEmpty ? Text(
        config.content,
        style: TextStyle(
          color: colorsTheme.textColorPrimary,
          fontSize: 16,
        ),
      ) : null,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            config.cancelText ?? appLocale.cancel,
            style: TextStyle(
              color: colorsTheme.textColorPrimary,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            config.onConfirm?.call();
          },
          child: Text(
            config.confirmText ?? appLocale.confirm,
            style: TextStyle(
              color: config.isDestructive 
                  ? colorsTheme.textColorError 
                  : colorsTheme.buttonColorPrimaryDefault,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
} 