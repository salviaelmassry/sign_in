import 'package:get/get.dart';
import 'package:sign_in/controllers/registeration_controller.dart';
import 'package:sign_in/controllers/sign_in_controller.dart';
import 'package:sign_in/controllers/ui_controllers/avatar_controller.dart';
import 'package:sign_in/controllers/verification_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => AvatarController());
    Get.lazyPut(() => VerificationController());
  }
}
