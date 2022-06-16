import 'package:get/get.dart';
import 'package:sign_in/models/user_model.dart';
import 'package:sign_in/models/user_model_response.dart';
import 'package:sign_in/repository/user_repo.dart';
import 'package:sign_in/screens/verification_screen.dart';
import 'package:sign_in/shared/enum/request_status.dart';

class RegistrationController extends GetxController {
  final requestStatus = RequestStatus.INITIALIZING.obs;

  void setRequestStatus(RequestStatus _value) => requestStatus.value = _value;

  void registerUser({required User user}) async {
    setRequestStatus(RequestStatus.LOADING);
    UserResponse response = await UserRepo.signUp(user: user);
    if (response.status) {
      setRequestStatus(RequestStatus.SUCCESS);
      Get.to(VerificationScreen(userId: int.parse(response.result!.id!)));
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
