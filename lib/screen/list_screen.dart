import 'package:get/route_manager.dart';
import 'package:sirkadian_app/bindings/bindings.dart';
import 'package:sirkadian_app/screen/user/user_health_preferance_screen.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/nutrition_screen.dart';
import 'package:sirkadian_app/screen/user/user_information_screen.dart';
import '../screen/main_screen.dart';

import '../screen/auth/initial_setup_screen.dart';
import '../screen/auth/verification_screen.dart';

import '../screen/auth/login_screen.dart';
import '../screen/auth/register_screen.dart';
import '../screen/auth/welcome_screen.dart';

class ListScreen {
  static final screens = [
    //auth
    GetPage(name: RouteScreens.welcome, page: () => WelcomeScreen()),
    GetPage(
        name: RouteScreens.login,
        page: () => LoginScreen(),
        bindings: [LoginTextB(), ControllerBinding()]),
    GetPage(
        name: RouteScreens.register,
        page: () => RegisterScreen(),
        bindings: [RegisterTextB(), ControllerBinding()]),
    GetPage(
        name: RouteScreens.verification,
        page: () => VerificationScreen(),
        binding: ControllerBinding()),
    GetPage(
        name: RouteScreens.initialSetup,
        page: () => InitialSetupScreen(),
        bindings: [ControllerBinding(), InitialSetupTextB()]),

    //general
    GetPage(name: RouteScreens.main, page: () => MainScreen(), bindings: [
      ControllerBinding(),
    ]),

    //food
    GetPage(
        name: RouteScreens.foodMeal,
        page: () => NutritionScreen(),
        bindings: []),

    //user
    GetPage(
        name: RouteScreens.userHealthPreference,
        page: () => UserHealthPreferenceScreen(),
        bindings: [ControllerBinding()]),
    GetPage(
        name: RouteScreens.userInformation,
        page: () => UserInformationScreen(),
        bindings: [ControllerBinding(), InitialSetupTextB()]),
  ];
}

abstract class RouteScreens {
  //auth
  static const welcome = '/welcomeScreen';
  static const register = '/registerScreen';
  static const login = '/loginScreen';
  static const verification = '/verificationScreen';
  static const initialSetup = '/initialSetupScreen';

  //general
  static const main = '/mainScreen';
  static const home = 'homeScreen';
  static const program = 'programScreen';

//food
  static const foodMeal = '/foodMealScreen';

  //user
  static const userHealthPreference = '/userHealthPreferenceScreen';
  static const userInformation = '/userInformationScreen';
}
