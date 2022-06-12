import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/auth_controller.dart';
import '../../model/auth_model/initialSetup_request_model.dart';

class InitialSetupScreen extends StatefulWidget {
  InitialSetupScreen({Key? key}) : super(key: key);

  @override
  State<InitialSetupScreen> createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  final authController = Get.find<AuthController>();
  final color = Get.find<ColorConstantController>();
  final textC = Get.find<InitialSetupTextC>();
  final arguments = Get.arguments;
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

  void convertDate(DateTime dateTime) {
    selectedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // FocusNode focusTinggi = FocusNode();
  // FocusNode focusBerat = FocusNode();
  String selectedValueJenisKelamin = 'female';
  String selectedValueTingkatAktivitas = 'sedentary';
  String selectedValuePreferensiOlahraga = 'light';
  String selectedValueVegetarian = 'ya';
  String selectedValueVegan = 'ya';
  String selectedValueHalal = 'ya';
  int pageActive = 0;
  String selectedDate = 'Pilih Tanggal Lahir';
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      backgroundColor: color.bgColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
              child: Column(children: [
            Expanded(
              flex: 12,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    pageActive = index;
                  });
                },
                children: [
                  pageOne(currentFocus),
                  pageTwo(currentFocus),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(2, (int index) {
                            return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 12.h,
                                width: 10.w,
                                margin: EdgeInsets.only(
                                    left: 5.w, right: 5.w, bottom: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: (index == pageActive)
                                        ? color.tersierColor
                                        : color.secondaryColor
                                            .withOpacity(0.4)));
                          })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                              onPressed: () {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                _controller.previousPage(
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeInOutQuint);
                              },
                              margin: EdgeInsets.only(top: 10.h),
                              style: NeumorphicStyle(
                                  color: color.secondaryColor,
                                  depth: 4,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 50.w),
                              child: Text(
                                "Kembali",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                          SizedBox(width: 20.w),
                          NeumorphicButton(
                              onPressed: () {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (pageActive == 1) {
                                  final initialSetupRequest =
                                      InitialSetupRequest(
                                          activityLevel:
                                              selectedValueTingkatAktivitas,
                                          dob: selectedDate,
                                          gender: selectedValueJenisKelamin,
                                          halal: selectedValueHalal == 'ya'
                                              ? true
                                              : false,
                                          vegetarian:
                                              selectedValueVegetarian == 'ya'
                                                  ? true
                                                  : false,
                                          vegan: selectedValueVegan == 'ya'
                                              ? true
                                              : false,
                                          sportDifficulty:
                                              selectedValuePreferensiOlahraga,
                                          height: textC.heightC.text.isNotEmpty
                                              ? int.parse(textC.heightC.text)
                                              : 0,
                                          weight: textC.weightC.text.isNotEmpty
                                              ? int.parse(textC.weightC.text)
                                              : 0,
                                          lang: 'indonesia');
                                  authController.postInitialSetup(
                                      initialSetupRequest: initialSetupRequest,
                                      accessToken: arguments[0].toString());
                                  print(initialSetupRequest.toJson());
                                }

                                _controller.nextPage(
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeInOutQuint);
                              },
                              margin: EdgeInsets.only(top: 10.h),
                              style: NeumorphicStyle(
                                  color: color.secondaryColor,
                                  depth: 4,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 50.w),
                              child: Text(
                                pageActive == 1 ? 'Submit' : "Lanjut",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ])),
        ),
      ),
    );
  }

  Container pageOne(currentFocus) {
    return Container(
      height: 800.h,
      width: 360.w,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            children: [
              SizedBox(
                height: 28.h,
              ),
              Text(
                'Konfigurasi Data Awal',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Container(
                margin: EdgeInsets.all(20.sp),
                child: Text(
                  'Kami membutuhkan data Anda untuk merekomendasikan pola hidup sehat yang cocok untuk Anda.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),

          //segmen 2
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Tanggal Lahir',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Neumorphic(
                  style:
                      NeumorphicStyle(depth: -5, color: color.backgroundColor),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.only(bottom: 30.h),
                  child: TextFormField(
                    readOnly: true,
                    controller: textC.dateC,
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                            headerColor: color.secondaryColor,
                            cancelStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                            itemStyle: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.secondaryTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                            doneStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          minTime: DateTime(1950, 1, 1),
                          maxTime: DateTime(2050, 1, 1),
                          onChanged: (date) {}, onConfirm: (date) {
                        setState(() {
                          convertDate(date);
                        });
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: selectedDate != 'Pilih tanggal lahir'
                            ? selectedDate
                            : 'Pilih tanggal lahir',
                        suffixIcon: IconButton(
                          splashRadius: 20.sp,
                          onPressed: () {
                            if (selectedDate != 'Pilih tanggal lahir') {
                              setState(() {
                                selectedDate = 'Pilih tanggal lahir';
                              });
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.times,
                              size: 14.sp,
                              color: selectedDate != 'Pilih tanggal lahir'
                                  ? color.redColor
                                  : color.hintTextColor),
                        ),
                        hintStyle: TextStyle(
                            color: selectedDate != 'Pilih tanggal lahir'
                                ? color.secondaryTextColor
                                : color.hintTextColor,
                            fontSize: 14.sp)),
                  ),
                ),
                Text(
                  'Jenis Kelamin',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    children: [
                      radioButton(
                        currentFocus: currentFocus,
                        function: (value) {
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            selectedValueJenisKelamin = value!;
                          });
                        },
                        groupValue: selectedValueJenisKelamin,
                        title: 'Perempuan',
                        value: 'female',
                      ),
                      SizedBox(width: 50.w),
                      radioButton(
                        currentFocus: currentFocus,
                        function: (value) {
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            selectedValueJenisKelamin = value!;
                          });
                        },
                        groupValue: selectedValueJenisKelamin,
                        title: 'Laki-laki',
                        value: 'male',
                      )
                    ],
                  ),
                ),
                Text(
                  'Tinggi Badan',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Neumorphic(
                  style:
                      NeumorphicStyle(depth: -5, color: color.backgroundColor),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.only(bottom: 30.h),
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
                            color: color.hintTextColor, fontSize: 14.sp)),
                  ),
                ),
                Text(
                  'Berat Badan',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Neumorphic(
                  style:
                      NeumorphicStyle(depth: -5, color: color.backgroundColor),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.only(bottom: 30.h),
                  child: TextFormField(
                    controller: textC.weightC,
                    keyboardType: TextInputType.number,
                    onTap: () {
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        suffixText: 'kg',
                        border: InputBorder.none,
                        hintText: '65 kg',
                        hintStyle: TextStyle(
                            color: color.hintTextColor, fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

//
  Container pageTwo(currentFocus) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 800.h,
      width: 360.w,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 28.h,
              ),
              Text(
                'Tingkat Aktivitas',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.w),
                child: Column(
                  children: [
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueTingkatAktivitas = value!;
                        });
                      },
                      groupValue: selectedValueTingkatAktivitas,
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
                          selectedValueTingkatAktivitas = value!;
                        });
                      },
                      groupValue: selectedValueTingkatAktivitas,
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
                          selectedValueTingkatAktivitas = value!;
                        });
                      },
                      groupValue: selectedValueTingkatAktivitas,
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
                          selectedValueTingkatAktivitas = value!;
                        });
                      },
                      groupValue: selectedValueTingkatAktivitas,
                      title: 'Tinggi',
                      value: 'high',
                    ),
                  ],
                ),
              ),
              Text(
                'Preferensi Olahraga',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValuePreferensiOlahraga = value!;
                        });
                      },
                      groupValue: selectedValuePreferensiOlahraga,
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
                          selectedValuePreferensiOlahraga = value!;
                        });
                      },
                      groupValue: selectedValuePreferensiOlahraga,
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
                          selectedValuePreferensiOlahraga = value!;
                        });
                      },
                      groupValue: selectedValuePreferensiOlahraga,
                      title: 'Berat',
                      value: 'vigorous',
                    ),
                  ],
                ),
              ),
              Text(
                'Vegetarian',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  children: [
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueVegetarian = value!;
                        });
                      },
                      groupValue: selectedValueVegetarian,
                      title: 'Ya',
                      value: 'ya',
                    ),
                    SizedBox(width: 50.w),
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueVegetarian = value!;
                        });
                      },
                      groupValue: selectedValueVegetarian,
                      title: 'Tidak',
                      value: 'tidak',
                    )
                  ],
                ),
              ),
              Text(
                'Vegan',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  children: [
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueVegan = value!;
                        });
                      },
                      groupValue: selectedValueVegan,
                      title: 'Ya',
                      value: 'ya',
                    ),
                    SizedBox(width: 50.w),
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueVegan = value!;
                        });
                      },
                      groupValue: selectedValueVegan,
                      title: 'Tidak',
                      value: 'tidak',
                    )
                  ],
                ),
              ),
              Text(
                'Halal',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  children: [
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueHalal = value!;
                        });
                      },
                      groupValue: selectedValueHalal,
                      title: 'Ya',
                      value: 'ya',
                    ),
                    SizedBox(width: 50.w),
                    radioButton(
                      currentFocus: currentFocus,
                      function: (value) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          selectedValueHalal = value!;
                        });
                      },
                      groupValue: selectedValueHalal,
                      title: 'Tidak',
                      value: 'tidak',
                    )
                  ],
                ),
              ),
            ]),
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
