import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';

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
  int pageChanged = 0;
  String selectedDate = 'Pilih Tanggal Lahir';
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color.primaryColor,
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
                    pageChanged = index;
                  });
                },
                children: [
                  pageOne(size, currentFocus),
                  pageTwo(size, currentFocus),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(2, (int index) {
                          return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: size.height * 0.015,
                              width: 10,
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (index == pageChanged)
                                      ? color.tersierColor
                                      : color.secondaryColor.withOpacity(0.4)));
                        })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicButton(
                            onPressed: () {
                              _controller.previousPage(
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutQuint);
                            },
                            margin: EdgeInsets.only(top: 10),
                            style: NeumorphicStyle(
                                color: color.secondaryColor,
                                depth: 4,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20),
                                )),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: size.width * 0.13),
                            child: Text(
                              "Kembali",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                        SizedBox(width: 20),
                        NeumorphicButton(
                            onPressed: () {
                              if (pageChanged == 1) {
                                final initialSetupRequest = InitialSetupRequest(
                                    activityLevel:
                                        selectedValueTingkatAktivitas,
                                    dob: selectedDate,
                                    gender: selectedValueJenisKelamin,
                                    halal: selectedValueHalal == 'ya'
                                        ? true
                                        : false,
                                    vegetarian: selectedValueVegetarian == 'ya'
                                        ? true
                                        : false,
                                    vegan: selectedValueVegan == 'ya'
                                        ? true
                                        : false,
                                    sportDifficulty:
                                        selectedValuePreferensiOlahraga,
                                    height: int.parse(textC.heightC.text),
                                    weight: int.parse(textC.weightC.text),
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
                            margin: EdgeInsets.only(top: 10),
                            style: NeumorphicStyle(
                                color: color.secondaryColor,
                                depth: 4,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20),
                                )),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: size.width * 0.15),
                            child: Text(
                              pageChanged == 1 ? 'Submit' : "Lanjut",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ),
      ),
    );
  }

  Container pageOne(Size size, currentFocus) {
    return Container(
      // padding: EdgeInsets.only(top: 10),
      height: size.height,
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Konfigurasi Data Awal',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Kami membutuhkan data Anda untuk merekomendasikan pola hidup sehat yang cocok untuk Anda.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),

        //segmen 2
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Tanggal Lahir',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(bottom: 30),
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
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                          itemStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                          doneStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryColor,
                                fontSize: 16,
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
                        splashRadius: 20,
                        onPressed: () {
                          if (selectedDate != 'Pilih tanggal lahir') {
                            setState(() {
                              selectedDate = 'Pilih tanggal lahir';
                            });
                          }
                        },
                        icon: FaIcon(FontAwesomeIcons.times,
                            size: 14,
                            color: selectedDate != 'Pilih tanggal lahir'
                                ? color.redColor
                                : color.hintTextColor),
                      ),
                      hintStyle: TextStyle(
                          color: selectedDate != 'Pilih tanggal lahir'
                              ? color.secondaryTextColor
                              : color.hintTextColor,
                          fontSize: size.width * 0.04)),
                ),
              ),
              Text(
                'Jenis Kelamin',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
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
                    SizedBox(width: 50),
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
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
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
                style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
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
                      focusedBorder: InputBorder.none,
                      suffixText: 'kg',
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
      ]),
    );
  }

//
  Container pageTwo(Size size, currentFocus) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: size.height,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Tingkat Aktivitas',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                  SizedBox(width: 50),
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
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                  SizedBox(width: 50),
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
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                  SizedBox(width: 50),
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
    );
  }

  Widget pageFour(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: size.height,
      width: double.infinity,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //segmen 1
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              Text(
                'Selamat Datang di',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.secondaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                'Sirkadian',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.greenColor,
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset('assets/images/sirkadianlogo.png',
                  fit: BoxFit.fitHeight,
                  height: size.height * 0.07,
                  width: size.width * 0.15),
            ],
          ),
        ),
      ]),
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
