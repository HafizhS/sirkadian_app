import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/model/user_model/user_health_preference_request_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  RxString selectedValueTingkatAktivitas = 'sedentary'.obs;

  RxString selectedValuePreferensiOlahraga = 'light'.obs;
  RxString selectedValueVegetarian = 'ya'.obs;
  RxString selectedValueVegan = 'ya'.obs;
  RxString selectedValueHalal = 'ya'.obs;

  @override
  void initState() {
    userController.getUserHealthPreferenceLatest().then((_) {
      selectedValueTingkatAktivitas.value = userController
          .userHealthPreferenceLatestResponse.value.activityLevel!;
      selectedValuePreferensiOlahraga.value = userController
          .userHealthPreferenceLatestResponse.value.sportDifficulty!;
      if (userController.userHealthPreferenceLatestResponse.value.vegan! ==
          true) {
        selectedValueVegan.value = 'ya';
      } else {
        selectedValueVegan.value = 'tidak';
      }
      if (userController.userHealthPreferenceLatestResponse.value.vegetarian! ==
          true) {
        selectedValueVegetarian.value = 'ya';
      } else {
        selectedValueVegetarian.value = 'tidak';
      }
      if (userController.userHealthPreferenceLatestResponse.value.halal! ==
          true) {
        selectedValueHalal.value = 'ya';
      } else {
        selectedValueHalal.value = 'tidak';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    print(selectedValueTingkatAktivitas);
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
                    'Setelan Kesehatan',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 40.w),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(70.h)),
      body: Obx(
        () => userController.isLoadingUserHealthPreferenceLatest.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            'Dibawah ini adalah setelan pilihan sehatmu, Anda dapat mengubah satu atau lebih pilihan dibawah ini sesuai dengan kebutuhan Anda',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tingkat Aktivitas',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    tingkatAktivitasBottomSheet(currentFocus);
                                  },
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        color: color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(30)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedValueTingkatAktivitas.value,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              tingkatAktivitasBottomSheet(
                                                  currentFocus);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.chevronDown,
                                            ),
                                            alignment: Alignment.center,
                                            iconSize: 12.sp,
                                            padding: EdgeInsets.all(0),
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            splashRadius: 16.sp,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level Olahraga',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    prereferensiOlahragaBottomSheet(
                                        currentFocus);
                                  },
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        color: color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(30)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedValuePreferensiOlahraga
                                                .value,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              prereferensiOlahragaBottomSheet(
                                                  currentFocus);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.chevronDown,
                                            ),
                                            alignment: Alignment.center,
                                            iconSize: 12.sp,
                                            padding: EdgeInsets.all(0),
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            splashRadius: 16.sp,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vegan',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    veganBottomSheet(currentFocus);
                                  },
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        color: color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(30)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedValueVegan.value,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              veganBottomSheet(currentFocus);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.chevronDown,
                                            ),
                                            alignment: Alignment.center,
                                            iconSize: 12.sp,
                                            padding: EdgeInsets.all(0),
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            splashRadius: 16.sp,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vegetarian',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    vegetarianBottomSheet(currentFocus);
                                  },
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        color: color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(30)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedValueVegetarian.value,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              vegetarianBottomSheet(
                                                  currentFocus);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.chevronDown,
                                            ),
                                            alignment: Alignment.center,
                                            iconSize: 12.sp,
                                            padding: EdgeInsets.all(0),
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            splashRadius: 16.sp,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Halal',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    halalBottomSheet(currentFocus);
                                  },
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        color: color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(30)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      margin: EdgeInsets.only(
                                          bottom: 10.h, top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedValueHalal.value,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              halalBottomSheet(currentFocus);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.chevronDown,
                                            ),
                                            alignment: Alignment.center,
                                            iconSize: 12.sp,
                                            padding: EdgeInsets.all(0),
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            splashRadius: 16.sp,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //

                    NeumorphicButton(
                        margin: EdgeInsets.only(top: 12.h),
                        onPressed: () {
                          final postUserHealthPreferenceRequest =
                              UserHealthPreferenceRequest(
                                  activityLevel:
                                      selectedValueTingkatAktivitas.value,
                                  sportDifficulty:
                                      selectedValuePreferensiOlahraga.value,
                                  vegan: selectedValueVegan.value == 'ya'
                                      ? true
                                      : false,
                                  vegetarian:
                                      selectedValueVegetarian.value == 'ya'
                                          ? true
                                          : false,
                                  halal: selectedValueHalal.value == 'ya'
                                      ? true
                                      : false);
                          print(postUserHealthPreferenceRequest);
                          userController.postUserHealthPreference(
                              postUserHealthPreferenceRequest:
                                  postUserHealthPreferenceRequest);
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
                            vertical: 12, horizontal: 120.w),
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
                      height: 28.h,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<dynamic> halalBottomSheet(FocusScopeNode currentFocus) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: 360.w,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueHalal.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueHalal.value,
                title: 'Ya',
                value: 'ya',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueHalal.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueHalal.value,
                title: 'Tidak',
                value: 'tidak',
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> vegetarianBottomSheet(FocusScopeNode currentFocus) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: 360.w,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueVegetarian.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueVegetarian.value,
                title: 'Ya',
                value: 'ya',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueVegetarian.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueVegetarian.value,
                title: 'Tidak',
                value: 'tidak',
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> veganBottomSheet(FocusScopeNode currentFocus) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: 360.w,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueVegan.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueVegan.value,
                title: 'Ya',
                value: 'ya',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueVegan.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueVegan.value,
                title: 'Tidak',
                value: 'tidak',
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> prereferensiOlahragaBottomSheet(FocusScopeNode currentFocus) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: 360.w,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValuePreferensiOlahraga.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValuePreferensiOlahraga.value,
                title: 'Mudah',
                value: 'light',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValuePreferensiOlahraga.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValuePreferensiOlahraga.value,
                title: 'Sedang',
                value: 'moderate',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValuePreferensiOlahraga.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValuePreferensiOlahraga.value,
                title: 'Berat',
                value: 'vigorous',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> tingkatAktivitasBottomSheet(FocusScopeNode currentFocus) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: 360.w,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueTingkatAktivitas.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueTingkatAktivitas.value,
                title: 'Sedentary',
                value: 'sedentary',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueTingkatAktivitas.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueTingkatAktivitas.value,
                title: 'Rendah',
                value: 'low',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueTingkatAktivitas.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueTingkatAktivitas.value,
                title: 'Sedang',
                value: 'medium',
              ),
              radioButton(
                currentFocus: currentFocus,
                function: (value) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    selectedValueTingkatAktivitas.value = value!;
                    Get.back();
                  });
                },
                groupValue: selectedValueTingkatAktivitas.value,
                title: 'Tinggi',
                value: 'high',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton(
      {FocusScopeNode? currentFocus,
      String? groupValue,
      String? value,
      String? title,
      Function(String?)? function}) {
    return Row(
      children: [
        Radio<String>(
          visualDensity: VisualDensity(vertical: -4),
          activeColor: color.secondaryColor,
          value: value!,
          groupValue: groupValue,
          onChanged: function,
        ),
        Text(
          title!,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: color.secondaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

//   SizedBox(
//   height: size.height * 0.02,
// ),
// DropdownSearch<String>(
//   mode: Mode.MENU,
//   showSelectedItem: true,
//   items: levelOlahraga,
//   label: 'Level Olahraga',
//   hint: 'pilih level olahraga',
//   onChanged: (val) {
//     setState(() {
//       // levelOlahragaSelected = val!;
//     });
//   },
//   selectedItem: userController
//       .userHealthPreferenceLatestResponse
//       .value
//       .sportDifficulty,
//   // dropdownSearchDecoration: InputDecoration(),
// ),
// SizedBox(
//   height: size.height * 0.02,
// ),
// DropdownSearch<String>(
//   mode: Mode.MENU,
//   showSelectedItem: true,
//   items: vegan,
//   label: 'Vegan',

//   onChanged: (val) {},
//   selectedItem: userController
//               .userHealthPreferenceLatestResponse
//               .value
//               .vegan ==
//           true
//       ? 'Ya'
//       : 'Tidak',
//   // dropdownSearchDecoration: InputDecoration(),
// ),
// SizedBox(
//   height: size.height * 0.02,
// ),
// DropdownSearch<String>(
//   mode: Mode.MENU,
//   showSelectedItem: true,
//   items: vegan,
//   label: 'Vegetarian',

//   onChanged: (val) {},
//   selectedItem: userController
//               .userHealthPreferenceLatestResponse
//               .value
//               .vegetarian ==
//           true
//       ? 'Ya'
//       : 'Tidak',
//   // dropdownSearchDecoration: InputDecoration(),
// ),
// SizedBox(
//   height: size.height * 0.02,
// ),
// DropdownSearch<String>(
//   mode: Mode.MENU,
//   showSelectedItem: true,
//   items: vegan,
//   label: 'Halal',

//   onChanged: (val) {},
//   selectedItem: userController
//               .userHealthPreferenceLatestResponse
//               .value
//               .halal ==
//           true
//       ? 'Ya'
//       : 'Tidak',
//   // dropdownSearchDecoration: InputDecoration(),
// ),
