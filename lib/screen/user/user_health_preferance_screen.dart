import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../controller/hexcolor_controller.dart';

class UserHealthPreferenceScreen extends StatefulWidget {
  UserHealthPreferenceScreen({Key? key}) : super(key: key);

  @override
  _UserHealthPreferenceScreenState createState() =>
      _UserHealthPreferenceScreenState();
}

final data = GetStorage('myData');

class _UserHealthPreferenceScreenState
    extends State<UserHealthPreferenceScreen> {
  final userController = Get.find<UserController>();
  final color = Get.find<ColorConstantController>();
  var valueChoose = 'sedentary';
  List<String> tingkatAktivitas = ['sedentary', 'low', 'medium', 'high'];
  List<String> levelOlahraga = ['easy', 'medium', 'hard', 'vigorous'];
  List<String> tipeDiet = [
    'maintain',
    'mild diet',
    'moderate diet',
    'severe diet',
    'mild gain',
    'moderate gain',
    'severe gain'
  ];
  List<String> vegan = [
    'Ya',
    'Tidak',
  ];
  @override
  void initState() {
    userController.getUserHealthPreferenceLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => userController.isLoadingUserHealthPreferenceLatest.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
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
                            'Setelan Kesehatan',
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
                              height: size.height * 0.05,
                            ),
                            Text(
                              'Dibawah ini adalah setelan pilihan sehatmu, Anda dapat mengubah satu atau lebih pilihan dibawah ini sesuai dengan kebutuhan Anda',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: tingkatAktivitas,
                              label: 'Tingkat Aktivitas',
                              hint: 'pilih tingkat aktivitas',
                              onChanged: (val) {},
                              selectedItem: userController
                                  .userHealthPreferenceLatestResponse
                                  .value
                                  .activityLevel,
                              // dropdownSearchDecoration: InputDecoration(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: levelOlahraga,
                              label: 'Level Olahraga',
                              hint: 'pilih level olahraga',
                              onChanged: (val) {
                                setState(() {
                                  // levelOlahragaSelected = val!;
                                });
                              },
                              selectedItem: userController
                                  .userHealthPreferenceLatestResponse
                                  .value
                                  .sportDifficulty,
                              // dropdownSearchDecoration: InputDecoration(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: vegan,
                              label: 'Vegan',

                              onChanged: (val) {},
                              selectedItem: userController
                                          .userHealthPreferenceLatestResponse
                                          .value
                                          .vegan ==
                                      true
                                  ? 'Ya'
                                  : 'Tidak',
                              // dropdownSearchDecoration: InputDecoration(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: vegan,
                              label: 'Vegetarian',

                              onChanged: (val) {},
                              selectedItem: userController
                                          .userHealthPreferenceLatestResponse
                                          .value
                                          .vegetarian ==
                                      true
                                  ? 'Ya'
                                  : 'Tidak',
                              // dropdownSearchDecoration: InputDecoration(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: vegan,
                              label: 'Halal',

                              onChanged: (val) {},
                              selectedItem: userController
                                          .userHealthPreferenceLatestResponse
                                          .value
                                          .halal ==
                                      true
                                  ? 'Ya'
                                  : 'Tidak',
                              // dropdownSearchDecoration: InputDecoration(),
                            ),
                          ],
                        ),
                      ),

                      //

                      NeumorphicButton(
                          margin: EdgeInsets.only(top: 12),
                          onPressed: () {},
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
