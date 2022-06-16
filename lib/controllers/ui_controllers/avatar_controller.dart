import 'package:get/get.dart';

class AvatarController extends GetxController {
  final avatar = 'null'.obs;

  updateAvatarName(String name) {
    avatar(name);
  }
}
