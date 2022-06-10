import 'package:get/get.dart';
import 'package:sirkadian_app/controller/notification_controller.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/healthware_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<InformationController>(() => InformationController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<ColorConstantController>(() => ColorConstantController());
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
    Get.lazyPut<ExerciseController>(() => ExerciseController());
    Get.lazyPut<FluidController>(() => FluidController());
    Get.lazyPut<HealthwareController>(() => HealthwareController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<NotificationController>(() => NotificationController());
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

class InitialSetupTextB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialSetupTextC>(() => InitialSetupTextC());
  }
}
