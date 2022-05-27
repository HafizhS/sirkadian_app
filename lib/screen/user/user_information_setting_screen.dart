import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/model/user_model/user_health_history_request_model.dart';

import '../../controller/hexcolor_controller.dart';
import '../../controller/text_controller.dart';

class UserInformationSettingScreen extends StatefulWidget {
  UserInformationSettingScreen({Key? key}) : super(key: key);

  @override
  _UserInformationSettingScreenState createState() =>
      _UserInformationSettingScreenState();
}

final data = GetStorage('myData');

class _UserInformationSettingScreenState
    extends State<UserInformationSettingScreen> {
  final userController = Get.find<UserController>();
  final textC = Get.find<InitialSetupTextC>();
  final color = Get.find<ColorConstantController>();

  @override
  void initState() {
    textC.heightC.text = userController
        .userHealthHistoryLatestResponse.value.height!
        .toStringAsFixed(0);
    textC.weightC.text = userController
        .userHealthHistoryLatestResponse.value.weight!
        .toStringAsFixed(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: NeumorphicButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.primaryColor,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          size: 16,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ),
                    Text(
                      'Setelan BMI',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 40),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Dibawah ini adalah setelan berat badan dan tinggi badan, Anda dapat mengubah satu atau lebih pilihan dibawah ini sesuai dengan data kesehatan Anda',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tinggi Badan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(
                                  depth: -5, color: color.backgroundColor),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.only(bottom: 30),
                              child: TextFormField(
                                controller: textC.heightC,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    suffixText: 'cm',
                                    border: InputBorder.none,
                                    hintText: '170 cm',
                                    hintStyle: TextStyle(
                                        color: color.hintTextColor,
                                        fontSize: size.width * 0.04)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Berat Badan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(
                                  depth: -5, color: color.backgroundColor),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.only(bottom: 30),
                              child: TextFormField(
                                controller: textC.weightC,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    suffixText: 'kg',
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: '65 kg',
                                    hintStyle: TextStyle(
                                        color: color.hintTextColor,
                                        fontSize: size.width * 0.04)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //

                NeumorphicButton(
                    margin: EdgeInsets.only(top: 12),
                    onPressed: () {
                      final userHealthHistoryRequest = UserHealthHistoryRequest(
                          height: int.parse(textC.heightC.text),
                          weight: int.parse(textC.weightC.text));

                      userController
                          .postUserHealthHistory(
                              userHealthHistoryRequest:
                                  userHealthHistoryRequest)
                          .then((_) =>
                              userController.getUserHealthHistoryLatest());
                    },
                    style: NeumorphicStyle(
                        color: color.secondaryColor,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        )
                        //border: NeumorphicBorder()
                        ),
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: size.width * 0.3),
                    child: Text(
                      "Update",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
