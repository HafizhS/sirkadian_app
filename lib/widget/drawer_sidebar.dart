import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/screen/list_screen.dart';

void onItemPressed(BuildContext context,
    {required int index, required AuthController authController}) {
  Navigator.pop(context);

  switch (index) {
    case 5:
      authController.logout();
      Get.offNamed(RouteScreens.welcome);
      break;
  }
}

class DrawerSideBar extends StatelessWidget {
  final AuthController authController;
  const DrawerSideBar({Key? key, required this.authController})
      : super(key: key);

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Drawer(
        backgroundColor: HexColor.fromHex('#FFFFFF'),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                DrawerItem(
                  name: 'People',
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context,
                      index: 0, authController: authController),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    name: 'My Account',
                    icon: Icons.account_box_rounded,
                    onPressed: () => onItemPressed(context,
                        index: 1, authController: authController)),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    name: 'Chats',
                    icon: Icons.message_outlined,
                    onPressed: () => onItemPressed(context,
                        index: 2, authController: authController)),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    name: 'Favourites',
                    icon: Icons.favorite_outline,
                    onPressed: () => onItemPressed(context,
                        index: 3, authController: authController)),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    name: 'Settings',
                    icon: Icons.settings,
                    onPressed: () => onItemPressed(context,
                        index: 4, authController: authController)),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    name: 'Log out',
                    icon: Icons.logout,
                    onPressed: () => onItemPressed(context,
                        index: 5, authController: authController)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: HexColor.fromHex('#000000'),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: HexColor.fromHex('#000000'),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
