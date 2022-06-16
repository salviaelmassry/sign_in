import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in/controllers/registeration_controller.dart';
import 'package:sign_in/controllers/ui_controllers/avatar_controller.dart';
import 'package:sign_in/models/user_model.dart';
import 'package:sign_in/screens/login_screen.dart';
import 'package:sign_in/shared/enum/request_status.dart';
import 'package:sign_in/shared/widgets/snack_bar.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final registrationController = Get.find<RegistrationController>();
  final avatarController = Get.find<AvatarController>();

  User? user = User();
  File? selectedFile;

  late ImagePicker picker = ImagePicker();

  Future<void> showImagePickerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('choose'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () => getImage(context, true),
                  child: const Text('camera'),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => getImage(context, false),
                  child: const Text('gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getImage(BuildContext context, bool fromCamera) async {
    try {
      final XFile? pickedFile = await picker.pickImage(
          source: fromCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 100);
      // ANCHOR select
      if (pickedFile != null) {
        popScreen(context, 1);
        selectedFile = File(pickedFile.path);
        avatarController.updateAvatarName(selectedFile!.path);
        user!.avatar = selectedFile!;
      } else {
        selectedFile = null;
      }
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied') {
        showSnackBar(context: context, message: 'enable gallery access');
      } else if (e.code == 'camera_access_denied') {
        showSnackBar(context: context, message: 'enable camera access');
      }
    }
  }

  void popScreen(BuildContext context, int size) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 35, left: 35),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(top: 80),
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => showImagePickerDialog(context),
                child: Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Obx(() {
                    if (avatarController.avatar.value == 'null') {
                      return Image.asset(
                        'assets/images/placeholder-user-image.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }
                    File tempFile = File(
                      avatarController.avatar.value,
                    );
                    return Image.file(
                      tempFile,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    );
                  }),
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Name',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                onChanged: (name) => user?.name = name,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                onChanged: (email) => user?.email = email,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                onChanged: (password) => user?.password = password,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                  onChanged: (confirmPassword) {
                    user?.confirmPassword = confirmPassword;
                  }),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(() {
                  if (registrationController.requestStatus.value ==
                      RequestStatus.LOADING) {
                    return CircularProgressIndicator();
                  }
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff4c505b),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        print(user!.name);
                        registrationController.registerUser(user: user!);
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  );
                }),
              ]),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
