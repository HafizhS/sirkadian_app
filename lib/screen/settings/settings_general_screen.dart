import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/widget/notifications/settings_notifications_food_screen.dart';
import '../../controller/hexcolor_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/notifications/settings_notifications_exercise_screen.dart';
import '../../widget/notifications/settings_notifications_fluid_screen.dart';

class SettingsGeneralScreen extends StatefulWidget {
  const SettingsGeneralScreen({Key? key}) : super(key: key);

  @override
  _SettingsGeneralScreenState createState() => _SettingsGeneralScreenState();
}

class _SettingsGeneralScreenState extends State<SettingsGeneralScreen> {
  final userController = Get.find<UserController>();
  final color = Get.find<ColorConstantController>();
  final notificationController = Get.find<NotificationController>();
  // TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
  }

  // void _showTimePicker() {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: NeumorphicButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.primaryColor,
                        ),
                        padding: EdgeInsets.all(16.sp),
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          size: 16.sp,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ),
                    Text(
                      'Pengaturan Notifikasi',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(70.h)),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 30.h),
                SettingsNotificationsFoodWidget(
                  color: color,
                  notificationController: notificationController,
                ),
                SettingsNotificationsFluidWidget(color: color),
                SettingsNotificationsExerciseWidget(color: color),
              ],
            ),
          ),
        ));
  }
}
