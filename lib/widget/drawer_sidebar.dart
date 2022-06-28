import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/screen/list_screen.dart';

import '../controller/user_controller.dart';

void onItemPressed(BuildContext context,
    {required int index, required AuthController authController}) {
  Navigator.pop(context);

  switch (index) {
    case 0:
      Get.toNamed(RouteScreens.userInformation);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => UserInformationScreen()));

      break;
    case 1:
      Get.toNamed(RouteScreens.userHealthPreference);
      break;
    case 2:
      Get.toNamed(RouteScreens.healthware);
      break;
    case 3:
      Get.toNamed(RouteScreens.settingsGeneral);
      break;
    case 4:
      authController.logout();
      Get.offNamed(RouteScreens.welcome);
      break;
  }
}

class DrawerSideBar extends StatefulWidget {
  final AuthController authController;
  final ColorConstantController color;
  final UserController userController;
  // final PackageInfo packageInfo;
  const DrawerSideBar({
    Key? key,
    required this.authController,
    required this.color,
    required this.userController,
    // required this.packageInfo
  }) : super(key: key);

  @override
  State<DrawerSideBar> createState() => _DrawerSideBarState();
}

class _DrawerSideBarState extends State<DrawerSideBar> {
  final color = Get.find<ColorConstantController>();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              color: widget.color.tersierColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30))),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/sirkadianlogo.png',
                            height: 30.h,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Sirkadian',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: widget.color.primaryColor,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/user_male.jpg'),
                        radius: 40.sp,
                      ),
                    ),
                    Text(
                      widget.userController.userInformationResponse.value
                              .displayName ??
                          widget.authController.data
                              .read('dataUser')['username'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: widget.color.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      '${(widget.userController.userHealthHistoryLatestResponse.value.weight ?? 0.0).toStringAsFixed(0)} kg, ${(widget.userController.userHealthHistoryLatestResponse.value.height ?? 0.0).toStringAsFixed(0)} cm',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: widget.color.primaryColor.withOpacity(0.4),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    DrawerItem(
                      name: 'Profile',
                      icon: FontAwesomeIcons.userEdit,
                      onPressed: () => onItemPressed(context,
                          index: 0, authController: widget.authController),
                      color: widget.color,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DrawerItem(
                      name: 'Health',
                      icon: FontAwesomeIcons.heartbeat,
                      onPressed: () => onItemPressed(context,
                          index: 1, authController: widget.authController),
                      color: widget.color,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DrawerItem(
                      name: 'Devices',
                      icon: FontAwesomeIcons.microchip,
                      onPressed: () => onItemPressed(context,
                          index: 2, authController: widget.authController),
                      color: widget.color,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DrawerItem(
                      name: 'Notifikasi',
                      icon: Icons.notifications,
                      onPressed: () => onItemPressed(context,
                          index: 3, authController: widget.authController),
                      color: widget.color,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DrawerItem(
                      name: 'Log out',
                      icon: FontAwesomeIcons.signOutAlt,
                      onPressed: () => onItemPressed(context,
                          index: 4, authController: widget.authController),
                      color: widget.color,
                    ),
                  ],
                ),
                // Column(
                //   children: [
                Text(
                  'Copyright by Sirkadian 2022',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // Text(
                //   '${widget.packageInfo.version}',
                //   style: GoogleFonts.poppins(
                //     textStyle: TextStyle(
                //         color: color.primaryColor,
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.normal),
                //   ),
                // )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;
  final ColorConstantController color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: color.primaryColor,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
