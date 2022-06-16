import 'package:flutter/material.dart';
import 'package:sign_in/shared/widgets/text_display.dart';

void showSnackBar({required BuildContext context, required String message, String? subMessage}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 20,
    content: subMessage != null ? Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppTextDisplay(
          text: message,
        ),
        AppTextDisplay(
          text: subMessage,
          fontSize: 12,
        ),
      ],
    ) : AppTextDisplay(
      text: message,
      maxLines: 7,
    ),
  ));
}
