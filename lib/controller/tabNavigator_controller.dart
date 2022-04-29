import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:sirkadian_app/screen/healthware/healthware_device_screen.dart';

import 'package:sirkadian_app/screen/subscription/program_screen.dart';

import '../screen/home/home_screen.dart';

// class Controller extends GetxController {
//   var count = RxInt(0);
//   change(int val) {
//     count.value = val;
//   }
// }

// final controller = Get.put(Controller());

// class TabNavigatorRoutes {
//   static const String root = '/';
//   static const String foodMeal = '/foodMealScreen';
// }

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  TabNavigator({Key? key, required this.navigatorKey, required this.tabItem});

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget child;

    if (widget.tabItem == "Home")
      child = HomeScreen();
    else if (widget.tabItem == "Program")
      child = ProgramScreen();
    else if (widget.tabItem == 'Healthware')
      child = HealthwareDeviceScreen();
    else
      child = HomeScreen();

    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

class MainController extends GetxController {}
