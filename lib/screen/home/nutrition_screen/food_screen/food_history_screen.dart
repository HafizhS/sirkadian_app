import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/model/food_model/food_history_response_model.dart';
import '../../../../controller/food_controller.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/information_controller.dart';

class FoodHistoryScreen extends StatefulWidget {
  FoodHistoryScreen({Key? key}) : super(key: key);

  @override
  State<FoodHistoryScreen> createState() => _FoodHistoryScreenState();
}

class _FoodHistoryScreenState extends State<FoodHistoryScreen> {
  final foodController = Get.find<FoodController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  List<DataFoodHistoryResponse> _searchResult = [];
  String selectedDate = '0000-00-00';
  String convertDate(DateTime dateTime) {
    return selectedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  void initState() {
    foodController.getFoodHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => foodController.isLoadingFoodHistory.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : SafeArea(
                child: Column(children: [
                //segment 1
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
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
                            color: color.bgColor,
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
                        'Riwayat Makan',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: NeumorphicButton(
                          onPressed: () {
                            if (_searchResult.isNotEmpty) {
                              setState(() {
                                _searchResult.clear();
                              });
                            } else {
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
                                  minTime: DateTime(2020, 1, 1),
                                  maxTime: DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day),
                                  onChanged: (date) {}, onConfirm: (date) {
                                setState(() {
                                  convertDate(date);
                                });
                                foodController.listFoodHistory
                                    .forEach((element) {
                                  if (element.foodDate == convertDate(date)) {
                                    _searchResult.add(element);
                                  }
                                });
                                if (_searchResult.isEmpty) {
                                  informationController.snackBarError(
                                      'Data Tidak Ditemukan',
                                      'Tidak ada riwayat makan pada tanggal tersebut.');
                                }
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.id);
                            }
                          },
                          style: NeumorphicStyle(
                            depth: _searchResult.isNotEmpty ? -4 : 4,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            color: color.bgColor,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: FaIcon(
                            FontAwesomeIcons.search,
                            size: 16,
                            color: _searchResult.isNotEmpty
                                ? color.secondaryColor
                                : color.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                //segment 2
                _searchResult.isNotEmpty
                    ? historyListWidget(sourceList: _searchResult)
                    : historyListWidget(
                        sourceList: foodController.listFoodHistory)
              ])),
      ),
    );
  }

  Widget historyListWidget({List<DataFoodHistoryResponse>? sourceList}) {
    return Expanded(
        child: ListView.builder(
            itemCount: sourceList!.length,
            itemBuilder: (context, index) {
              return sourceList[index].isOpen!
                  ? Neumorphic(
                      padding: EdgeInsets.all(10),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: color.primaryColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  sourceList[index].foodDate.toString(),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              NeumorphicButton(
                                margin: EdgeInsets.all(10.sp),
                                onPressed: () {
                                  setState(() {
                                    sourceList[index].isOpen = false;
                                  });
                                },
                                style: NeumorphicStyle(
                                  // depth: 0,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  color: color.primaryColor,
                                ),
                                padding: EdgeInsets.all(10.sp),
                                child: FaIcon(
                                  FontAwesomeIcons.chevronUp,
                                  size: 16.sp,
                                  color: color.secondaryColor,
                                ),
                              ),
                            ],
                          ),

                          ///
                          Column(
                              children: foodController
                                  .listFoodHistory[index].historyList!.reversed
                                  .map((element) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                element.foodTime! == 'breakfast'
                                                    ? 'Sarapan'
                                                    : element.foodTime! ==
                                                            'lunch'
                                                        ? 'Makan Siang'
                                                        : 'Makan Malam',
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: color
                                                          .primaryTextColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              NeumorphicButton(
                                                margin: EdgeInsets.all(10.sp),
                                                onPressed: () {
                                                  Get.bottomSheet(Container(
                                                    decoration: BoxDecoration(
                                                        color: color
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    height: 400.h,
                                                    width: 360.w,
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                              height: 18.h),
                                                          Text(
                                                            'Makro Nutrien',
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryTextColor,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          bottomSheetNecesityChild(
                                                              'Kalori',
                                                              element
                                                                      .totalEnergy! /
                                                                  (element.foodTime ==
                                                                          'breakfast'
                                                                      ? foodController
                                                                          .necessity
                                                                          .value
                                                                          .energy!
                                                                          .breakfast!
                                                                      : element.foodTime ==
                                                                              'lunch'
                                                                          ? foodController
                                                                              .necessity
                                                                              .value
                                                                              .energy!
                                                                              .lunch!
                                                                          : foodController
                                                                              .necessity
                                                                              .value
                                                                              .energy!
                                                                              .dinner!)),
                                                          bottomSheetNecesityChild(
                                                              'Karbohidrat',
                                                              element
                                                                      .totalCarbohydrate! /
                                                                  (element.foodTime ==
                                                                          'breakfast'
                                                                      ? foodController
                                                                          .necessity
                                                                          .value
                                                                          .macro!
                                                                          .breakfast!
                                                                          .carbohydrate!
                                                                      : element.foodTime ==
                                                                              'lunch'
                                                                          ? foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .lunch!
                                                                              .carbohydrate!
                                                                          : foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .dinner!
                                                                              .carbohydrate!)),
                                                          bottomSheetNecesityChild(
                                                              'Protein',
                                                              element
                                                                      .totalProtein! /
                                                                  (element.foodTime ==
                                                                          'breakfast'
                                                                      ? foodController
                                                                          .necessity
                                                                          .value
                                                                          .macro!
                                                                          .breakfast!
                                                                          .protein!
                                                                      : element.foodTime ==
                                                                              'lunch'
                                                                          ? foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .lunch!
                                                                              .protein!
                                                                          : foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .dinner!
                                                                              .protein!)),
                                                          bottomSheetNecesityChild(
                                                              'Lemak',
                                                              element
                                                                      .totalFat! /
                                                                  (element.foodTime ==
                                                                          'breakfast'
                                                                      ? foodController
                                                                          .necessity
                                                                          .value
                                                                          .macro!
                                                                          .breakfast!
                                                                          .fat!
                                                                      : element.foodTime ==
                                                                              'lunch'
                                                                          ? foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .lunch!
                                                                              .fat!
                                                                          : foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .dinner!
                                                                              .fat!)),
                                                          bottomSheetNecesityChild(
                                                              'Serat',
                                                              element
                                                                      .totalFiber! /
                                                                  (element.foodTime ==
                                                                          'breakfast'
                                                                      ? foodController
                                                                          .necessity
                                                                          .value
                                                                          .macro!
                                                                          .breakfast!
                                                                          .fiber!
                                                                      : element.foodTime ==
                                                                              'lunch'
                                                                          ? foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .lunch!
                                                                              .fiber!
                                                                          : foodController
                                                                              .necessity
                                                                              .value
                                                                              .macro!
                                                                              .dinner!
                                                                              .fiber!)),
                                                          SizedBox(
                                                              height: 28.h),
                                                          Text(
                                                            'Mikro Nutrien',
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryTextColor,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          bottomSheetNecesityChild(
                                                              'Kalsium',
                                                              element.totalCalcium! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .calcium!),
                                                          bottomSheetNecesityChild(
                                                              'Zat Besi',
                                                              element.totalIron! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .iron!),
                                                          bottomSheetNecesityChild(
                                                              'zinc',
                                                              element.totalZinc! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .zinc!),
                                                          bottomSheetNecesityChild(
                                                              'Copper',
                                                              element.totalCopper! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .copper!),
                                                          bottomSheetNecesityChild(
                                                              'Vitamin C',
                                                              element.totalVitC! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .vitaminC!),
                                                          bottomSheetNecesityChild(
                                                              'Vitamin B1',
                                                              element.totalVitB1! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .vitaminB1!),
                                                          bottomSheetNecesityChild(
                                                              'Vitamin B2',
                                                              element.totalVitB2! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .vitaminB2!),
                                                          bottomSheetNecesityChild(
                                                              'Vitamin B3',
                                                              element.totalVitB3! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .vitaminB3!),
                                                          bottomSheetNecesityChild(
                                                              'Retinol',
                                                              element.totalRetinol! /
                                                                  foodController
                                                                      .necessity
                                                                      .value
                                                                      .micro!
                                                                      .retinol!),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                style: NeumorphicStyle(
                                                  shape: NeumorphicShape.flat,
                                                  boxShape: NeumorphicBoxShape
                                                      .circle(),
                                                  color: color.primaryColor,
                                                ),
                                                padding: EdgeInsets.all(8.sp),
                                                child: FaIcon(
                                                  FontAwesomeIcons.ellipsisH,
                                                  size: 16.sp,
                                                  color: color.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: color.hintTextColor,
                                              thickness: 1),
                                          Container(
                                            height: 120.h,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    element.foods!.length,
                                                itemBuilder: (context, idx) {
                                                  return Neumorphic(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.w,
                                                            vertical: 10.h),
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    style: NeumorphicStyle(
                                                        color: color.bgColor,
                                                        shape: NeumorphicShape
                                                            .flat,
                                                        boxShape:
                                                            NeumorphicBoxShape
                                                                .roundRect(
                                                          BorderRadius.circular(
                                                              15),
                                                        )),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        element
                                                                    .foods![idx]
                                                                    .food!
                                                                    .imageFilename! ==
                                                                ''
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 20
                                                                            .h),
                                                                child: Icon(Icons
                                                                    .image_not_supported_rounded),
                                                              )
                                                            : Image.network(
                                                                element
                                                                    .foods![idx]
                                                                    .food!
                                                                    .imageFilename!,
                                                                width: double
                                                                    .infinity,
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                        Text(
                                                          element.foods![idx]
                                                              .food!.foodName!,
                                                          style:
                                                              GoogleFonts.inter(
                                                            textStyle: TextStyle(
                                                                color: color
                                                                    .secondaryTextColor,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ))
                                  .toList()),
                        ],
                      ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          sourceList[index].isOpen = true;
                        });
                      },
                      child: Neumorphic(
                          padding: EdgeInsets.all(10.sp),
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            color: color.primaryColor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20)),
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  sourceList[index].foodDate.toString(),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              NeumorphicButton(
                                margin: EdgeInsets.all(10.sp),
                                onPressed: () {
                                  setState(() {
                                    sourceList[index].isOpen = true;
                                  });
                                },
                                style: NeumorphicStyle(
                                  depth: 0,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  color: color.primaryColor,
                                ),
                                padding: EdgeInsets.all(8.sp),
                                child: FaIcon(
                                  FontAwesomeIcons.chevronDown,
                                  size: 16.sp,
                                  color: color.secondaryColor,
                                ),
                              ),
                            ],
                          )),
                    );
            }));
  }

  Widget bottomSheetNecesityChild(String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  '${((value) * 100).round().toString()}%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          Neumorphic(
              style: NeumorphicStyle(
                  depth: -4,
                  color: color.backgroundColor,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  )),
              child: Stack(alignment: Alignment.centerLeft, children: [
                Container(
                  height: 18.h,
                  width: 360.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color.secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 18.h,
                  width: 360.w * value,
                ),
              ])),
        ],
      ),
    );
  }
}
