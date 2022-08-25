import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/notification_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/hexcolor_controller.dart';
import '../controller/tabNavigator_controller.dart';
import '../controller/user_controller.dart';
import '../widget/drawer_sidebar.dart';
import 'home/nutrition_screen/nutrition_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final data = GetStorage('myData');
  final authController = Get.find<AuthController>();

  final userController = Get.find<UserController>();
  final informationController = Get.find<InformationController>();
  final notificationController = Get.find<NotificationController>();
  final color = Get.find<ColorConstantController>();
  late StreamSubscription<InternetConnectionStatus> _streamSubscription;
  GlobalKey<TabNavigatorState> tabKey = GlobalKey();
  bool hasInternet = true;
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

// PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  //   buildSignature: 'Unknown',
  // );
  // Future<void> _initPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();
  //   print(info);
  //   setState(() {
  //     _packageInfo = info;
  //   });
  // }

  @override
  void initState() {
    authController.getAccessToken();
    _streamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      // _initPackageInfo();
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    notificationController.getToData();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final isBackground = state == AppLifecycleState.paused;
    final isForeground = state == AppLifecycleState.resumed;

    if (isBackground) {
      //stop service

      _streamSubscription.cancel();
    } else {
      //start service
      authController.getAccessToken();
      _streamSubscription =
          InternetConnectionChecker().onStatusChange.listen((status) {
        final hasInternet = status == InternetConnectionStatus.connected;
        // _initPackageInfo();
        setState(() {
          this.hasInternet = hasInternet;
        });
      });
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // void listenNotifications() {
  //   NotificationController().initNotification().then((value) {
  //     //notification setup
  //     notificationController.notificationFoodSarapan(
  //         1, notificationController.isSoundSarapan);
  //     notificationController.notificationFoodMakanSiang(
  //         2, notificationController.isSoundMakanSiang);
  //     notificationController.notificationFoodMakanMalam(
  //         3, notificationController.isSoundMakanMalam);
  //     notificationController.notificationFluidMinum1(
  //         4, notificationController.isSoundMinum1);
  //     notificationController.notificationFluidMinum2(
  //         5, notificationController.isSoundMinum2);
  //     notificationController.notificationFluidMinum3(
  //         6, notificationController.isSoundMinum3);
  //     notificationController.notificationFluidMinum4(
  //         7, notificationController.isSoundMinum4);
  //   });
  //   NotificationController.onNotifications.stream.listen(onClickedNotification);
  // }

  // void onClickedNotification(String? payload) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => NutritionScreen(
  //                 hasBeenInitializedFood: widget.h,
  //               )));
  //   // Navigator.push(
  //   // context, MaterialPageRoute(builder: (context) => MainScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return hasInternet == false
        ? Scaffold(
            bottomNavigationBar: bottomNavBar(),
            // drawer: Drawer(backgroundColor: color.tersierColor, width: 200.w),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Tidak ada koneksi, pastikan anda memiliki koneksi internet.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  NeumorphicButton(
                      onPressed: () async {
                        try {
                          hasInternet =
                              await InternetConnectionChecker().hasConnection;

                          if (hasInternet) {
                            setState(() {
                              this.hasInternet = hasInternet;
                            });

                            if (Get.isSnackbarOpen) {
                              Get.back();
                            } else {
                              informationController.showSuccessSnackBar(
                                  'Koneksi telah ditemukan');
                            }
                          } else {
                            if (Get.isSnackbarOpen) {
                              Get.back();
                            } else {
                              informationController.snackBarError(
                                  'tidak ada koneksi',
                                  'Pastikan Anda memiliki koneksi lalu ulangi');
                            }
                          }
                        } finally {}
                      },
                      style: NeumorphicStyle(
                          color: color.secondaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )
                          //border: NeumorphicBorder()
                          ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 80.w),
                      child: Text(
                        "Coba lagi",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ]),
          )
        : WillPopScope(
            onWillPop: () async =>
                !await _navigatorKeys[_currentTab]!.currentState!.maybePop(),
            child: Scaffold(
              backgroundColor: color.bgColor,
              body: Obx(
                () => authController.isLoadingAccessToken.isTrue
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
                // packageInfo: _packageInfo,
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
              bottomNavigationBar: bottomNavBar(),
            ));
  }

  BottomAppBar bottomNavBar() {
    return BottomAppBar(
      notchMargin: 6,
      color: HexColor.fromHex('#F8F9FB'),
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 80.h,
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.symmetric(horizontal: 60.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => NeumorphicButton(
                onPressed: () {
                  screenIndex.value = 0;
                  _selectTab(pageKeys[screenIndex.value], screenIndex.value);
                },
                style: NeumorphicStyle(
                  depth: screenIndex.value == 0 ? -4 : 4,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: HexColor.fromHex('#F8F9FB'),
                ),
                padding: EdgeInsets.all(20.0.sp),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.home,
                    size: 16.sp,
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
                  _selectTab(pageKeys[screenIndex.value], screenIndex.value);
                },
                style: NeumorphicStyle(
                  depth: screenIndex.value == 1 ? -4 : 4,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: HexColor.fromHex('#F8F9FB'),
                ),
                padding: EdgeInsets.all(20.sp),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.list,
                    size: 16.sp,
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
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        listUserLog: [],
        key: tabKey,
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
