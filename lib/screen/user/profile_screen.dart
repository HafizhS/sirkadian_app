import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/screen/subscription/program_screen.dart';

import '../../constant/hex_color.dart';
import '../../controller/user_controller.dart';
import '../list_screen.dart';
import '../settings/settings_general_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();

  String _getUserAge() {
    var dob = userController.userInformationResponse.value.dob;
    if (dob == null) {
      return "";
    }
    var now = new DateTime.now();
    var age = now.year - DateTime.parse(dob).year;
    var formatter = new DateFormat("yyyy-MM-dd");

    return "${age.toString()} Years old";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => userController.userInformationResponse.value.displayName == null ||
              userController.userHealthHistoryLatestResponse.value.height ==
                  null
          ? Scaffold(
              body: Center(
                child: const CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 80),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: HexColor.fromHex("8CD15D"),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10)
                      ]),
                  child: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profile".toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21)),
                            GestureDetector(
                              child: Icon(Icons.settings,
                                  color: Colors.white, size: 30),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsGeneralScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 20),
                          _buildProfileCard(),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.health_and_safety_outlined,
                                          size: 34.h, color: Colors.green),
                                      const SizedBox(width: 10),
                                      Text("Health",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProgramScreen()));
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.list,
                                          size: 34.h, color: Colors.green),
                                      const SizedBox(width: 10),
                                      Text("Program",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              authController.logout();
                              Get.offNamed(RouteScreens.welcome);
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout,
                                          size: 34.h, color: Colors.green),
                                      const SizedBox(width: 10),
                                      Text("Log out",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // ...List.filled(10, null)
                          //     .map((e) => Text("Test"))
                          //     .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Card _buildProfileCard() {
    String bmi = (userController.userHealthHistoryLatestResponse.value.weight! /
            ((userController.userHealthHistoryLatestResponse.value.height! /
                    100) *
                (userController.userHealthHistoryLatestResponse.value.height! /
                    100)))
        .toStringAsFixed(0);
    String tinggiBadan =
        "${userController.userHealthHistoryLatestResponse.value.height?.round()} cm";
    String beratBadan =
        "${userController.userHealthHistoryLatestResponse.value.weight?.round()} kg";

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: HexColor.fromHex("8CD15D"), width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    foregroundImage:
                        Image.asset('assets/images/user_male.jpg').image,
                    radius: 38,
                  ),
                  Positioned(
                    child: Icon(Icons.add_a_photo_rounded, color: Colors.black),
                    bottom: 1,
                    right: 1,
                  )
                ]),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${userController.userInformationResponse.value.displayName}",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 3),
                      Text("${_getUserAge()}")
                    ],
                  ),
                ),
                Icon(Icons.edit, color: Colors.green)
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, height: 1, thickness: 1),
            const SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tinggi Badan", style: TextStyle(fontSize: 16)),
                      Text(tinggiBadan, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Berat Badan", style: TextStyle(fontSize: 16)),
                      Text(beratBadan, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BMI", style: TextStyle(fontSize: 16)),
                      Text(bmi, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            const Divider(color: Colors.grey, height: 1, thickness: 1),
          ],
        ),
      ),
    );
  }
}
