import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

import 'package:sirkadian_app/widget/drawer_sidebar.dart';

import '../controller/auth_controller.dart';
import '../controller/food_controller.dart';
import '../controller/hexcolor_controller.dart';
import '../controller/subscription_controller.dart';
import '../controller/tabNavigator_controller.dart';
import '../controller/user_controller.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authController = Get.find<AuthController>();
  final foodController = Get.find<FoodController>();
  final userController = Get.find<UserController>();
  final subscriptionController = Get.find<SubscriptionController>();
  final color = Get.find<ColorConstantController>();
  GlobalKey<TabNavigatorState> tabKey = GlobalKey();
  var _currentTab = "Home";
  final screenIndex = 0.obs;
  List<String> pageKeys = [
    "Home",
    "Program",
    'Healthware',
  ];
  final _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Program": GlobalKey<NavigatorState>(),
    'Healthware': GlobalKey<NavigatorState>(),
  };
  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = pageKeys[index];
        screenIndex.value = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    authController.getUsableToken().then((value) {
      userController.getUserHealthHistoryLatest();
      subscriptionController.getSubscriptionAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async =>
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop(),
        child: Scaffold(
          backgroundColor: HexColor.fromHex('#F0F3EC'),
          body: Obx(
            () => userController.isLoadingUserHealthHistoryLatest.isTrue ||
                    subscriptionController.isLoadingSubscriptionAll.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: color.secondaryColor,
                    ),
                  )
                : Stack(children: <Widget>[
                    _buildOffstageNavigator("Home"),
                    _buildOffstageNavigator("Program"),
                    _buildOffstageNavigator('Healthware'),
                  ]),
          ),
          drawer: DrawerSideBar(
            authController: authController,
            userController: userController,
            color: color,
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: color.tersierColor,
          //   onPressed: () {
          //     screenIndex.value = 2;
          //     _selectTab(pageKeys[screenIndex.value], screenIndex.value);
          //   },
          //   child: FaIcon(
          //     FontAwesomeIcons.unity,
          //     color: color.primaryColor,
          //   ),
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 6,
            color: HexColor.fromHex('#F8F9FB'),
            shape: CircularNotchedRectangle(),
            child: Container(
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => NeumorphicButton(
                      onPressed: () {
                        screenIndex.value = 0;
                        _selectTab(
                            pageKeys[screenIndex.value], screenIndex.value);
                      },
                      style: NeumorphicStyle(
                        depth: screenIndex.value == 0 ? -4 : 4,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: HexColor.fromHex('#F8F9FB'),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.home,
                          size: 16,
                          color: screenIndex.value == 0
                              ? color.secondaryColor
                              : color.tersierTextColor,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => NeumorphicButton(
                      onPressed: () {
                        screenIndex.value = 1;
                        _selectTab(
                            pageKeys[screenIndex.value], screenIndex.value);
                      },
                      style: NeumorphicStyle(
                        depth: screenIndex.value == 1 ? -4 : 4,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: HexColor.fromHex('#F8F9FB'),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.list,
                          size: 16,
                          color: screenIndex.value == 1
                              ? color.secondaryColor
                              : color.tersierTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        key: tabKey,
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
