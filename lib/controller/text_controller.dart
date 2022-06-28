import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTextC extends GetxController {
  var hidden = true.obs;
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();

    super.onClose();
  }
}

class UserPassInputTextC extends GetxController {
  var hidden = true.obs;
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();

    super.onClose();
  }
}

class RegisterTextC extends GetxController {
  var hidden = true.obs;
  late TextEditingController usernameC;
  late TextEditingController passwordC;
  late TextEditingController emailC;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    emailC = TextEditingController();
  }

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();

    // emailC.dispose();

    super.onClose();
  }
}

class InitialSetupTextC extends GetxController {
  late TextEditingController heightC;
  late TextEditingController dateC;
  late TextEditingController weightC;
  late TextEditingController displayNameC;

  @override
  void onInit() {
    super.onInit();
    dateC = TextEditingController();
    heightC = TextEditingController();
    weightC = TextEditingController();
    displayNameC = TextEditingController();
  }

  @override
  void onClose() {
    dateC.dispose();
    heightC.dispose();
    weightC.dispose();
    displayNameC.dispose();
    super.onClose();
  }
}
