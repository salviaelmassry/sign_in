import 'package:flutter/material.dart';
import 'package:sign_in/resources/app_color.dart';
import 'package:sign_in/shared/widgets/text_display.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.name}) : super(key: key);

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppTextDisplay(text: 'welcome $name to home', color: AppColors.facebookColor),
      ),
    );
  }
}
