import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sign_in/controllers/verification_controller.dart';
import 'package:sign_in/resources/app_color.dart';
import 'package:sign_in/shared/widgets/text_display.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key, required this.userId}) : super(key: key);
  int userId;

  late GlobalKey<FormState> otpFormState = GlobalKey<FormState>();
  final verificationController = Get.find<VerificationController>();

  String? verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const AppTextDisplay(
              text: 'Please check your email', color: AppColors.facebookColor),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: otpFormState,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: PinPut(
                  fieldsCount: 4,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                    color: AppColors.lightBlue,
                  ),
                  eachFieldWidth: 48,
                  eachFieldHeight: 48,
                  onSaved: (String? otp) {},
                  onChanged: (String? otp) {
                    verificationCode = otp;
                  },
                  separator: const SizedBox(width: 15),
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {},
                  selectedFieldDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.lightBlue),
                  ),
                  submittedFieldDecoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightBlue),
                  ),
                  disabledDecoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightBlue),
                  ),
                  followingFieldDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff4c505b),
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                verificationController.verifyUser(
                    userId: userId, verificationCode: verificationCode!);
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
