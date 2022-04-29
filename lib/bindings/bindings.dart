import 'package:get/get.dart';
import 'package:sirkadian_app/constant/color.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<InformationController>(() => InformationController());
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<ColorConstantController>(() => ColorConstantController());
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
  }
}

class LoginTextB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginTextC>(() => LoginTextC());
  }
}

class RegisterTextB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterTextC>(() => RegisterTextC());
  }
}
