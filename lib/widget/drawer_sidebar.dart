import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      break;
    case 1:
      Get.toNamed(RouteScreens.userHealthPreference);
      break;
    case 4:
      authController.logout();
      Get.offNamed(RouteScreens.welcome);
      break;
  }
}

class DrawerSideBar extends StatelessWidget {
  final AuthController authController;
  final ColorConstantController color;
  final UserController userController;
  const DrawerSideBar(
      {Key? key,
      required this.authController,
      required this.color,
      required this.userController})
      : super(key: key);

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color.tersierColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30))),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'assets/images/sirkadianlogo.png',
                        height: 30,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sirkadian',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                        radius: 40,
                      ),
                    ),
                    Text(
                      authController.data.read('dataUser')['username'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      '${userController.userHealthHistoryLatestResponse.value.weight!.toStringAsFixed(0)} kg, ${userController.userHealthHistoryLatestResponse.value.height!.toStringAsFixed(0)} cm',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryColor.withOpacity(0.4),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                DrawerItem(
                  name: 'Profile',
                  icon: FontAwesomeIcons.userEdit,
                  onPressed: () => onItemPressed(context,
                      index: 0, authController: authController),
                  color: color,
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: 'Health',
                  icon: FontAwesomeIcons.heartbeat,
                  onPressed: () => onItemPressed(context,
                      index: 1, authController: authController),
                  color: color,
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: 'Aktivitas',
                  icon: FontAwesomeIcons.thList,
                  onPressed: () => onItemPressed(context,
                      index: 2, authController: authController),
                  color: color,
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: 'Settings',
                  icon: Icons.settings,
                  onPressed: () => onItemPressed(context,
                      index: 3, authController: authController),
                  color: color,
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: 'Log out',
                  icon: FontAwesomeIcons.signOutAlt,
                  onPressed: () => onItemPressed(context,
                      index: 4, authController: authController),
                  color: color,
                ),
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
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: color.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
