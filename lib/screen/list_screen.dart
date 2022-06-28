import 'package:get/route_manager.dart';
import 'package:sirkadian_app/bindings/bindings.dart';
import 'package:sirkadian_app/screen/auth/greeting_screen.dart';
import 'package:sirkadian_app/screen/healthware/healthware_device_screen.dart';
import 'package:sirkadian_app/screen/settings/settings_general_screen.dart';
import 'package:sirkadian_app/screen/user/user_health_preference_screen.dart';
import 'package:sirkadian_app/screen/user/user_information_screen.dart';
import '../screen/main_screen.dart';

import '../screen/auth/initial_setup_screen.dart';
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
    // GetPage(
    //     name: RouteScreens.verification,
    //     page: () => VerificationScreen(),
    //     binding: ControllerBinding()),
    GetPage(
        name: RouteScreens.initialSetup,
        page: () => InitialSetupScreen(),
        bindings: [ControllerBinding(), InitialSetupTextB()]),
    GetPage(
        name: RouteScreens.greeting,
        page: () => GreetingScreen(),
        bindings: [ControllerBinding()]),

    //general
    GetPage(name: RouteScreens.main, page: () => MainScreen(), bindings: [
      ControllerBinding(),
    ]),

    // food
    // GetPage(
    //     name: RouteScreens.foodMeal,
    //     page: () => NutritionScreen(),
    //     bindings: []),

    //user
    GetPage(
        name: RouteScreens.userHealthPreference,
        page: () => UserHealthPreferenceScreen(),
        bindings: [ControllerBinding()]),
    GetPage(
        name: RouteScreens.userInformation,
        page: () => UserInformationScreen(),
        bindings: [ControllerBinding(), InitialSetupTextB()]),

    //settings
    GetPage(
        name: RouteScreens.settingsGeneral,
        page: () => SettingsGeneralScreen(),
        bindings: [ControllerBinding()]),

    //
    GetPage(
        name: RouteScreens.healthware,
        page: () => HealthwareDeviceScreen(),
        bindings: [ControllerBinding()]),
  ];
}

abstract class RouteScreens {
  //auth
  static const welcome = '/welcomeScreen';
  static const register = '/registerScreen';
  static const login = '/loginScreen';
  static const verification = '/verificationScreen';
  static const initialSetup = '/initialSetupScreen';
  static const greeting = '/greetingScreen';

  //general
  static const main = '/mainScreen';
  static const home = 'homeScreen';
  static const program = 'programScreen';

//food
  static const foodMeal = '/foodMealScreen';

  //user
  static const userHealthPreference = '/userHealthPreferenceScreen';
  static const userInformation = '/userInformationScreen';

  //settings
  static const settingsGeneral = '/settingsGeneralScreen';

  //healthware
  static const healthware = '/healthwareScreen';
}
