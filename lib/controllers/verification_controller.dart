import 'package:get/get.dart';
import 'package:sign_in/models/user_model_response.dart';
import 'package:sign_in/repository/user_repo.dart';
import 'package:sign_in/screens/home_screen.dart';
import 'package:sign_in/shared/enum/request_status.dart';

class VerificationController extends GetxController {

  final setRequestStatus = RequestStatus.INITIALIZING.obs;

  void verifyUser(
      {required String verificationCode, required int userId}) async {
    setRequestStatus(RequestStatus.LOADING);
    UserResponse response = await UserRepo.verifyUser(
        userId: userId, verificationCode: verificationCode);
    if (response.status) {
      setRequestStatus(RequestStatus.SUCCESS);
      Get.to(HomeScreen(name: response.result!.name!,));
    } else {
      setRequestStatus(RequestStatus.ERROR);
      Get.showSnackbar(GetBar(
        duration: const Duration(seconds: 5),
        borderRadius: 8,
        snackPosition: SnackPosition.TOP,
        maxWidth: Get.mediaQuery.size.width - 16,
        message: response.message,
      ));
    }
  }
}
