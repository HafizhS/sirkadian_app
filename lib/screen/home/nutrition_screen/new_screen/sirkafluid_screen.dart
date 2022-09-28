import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/widget/custom_widget/custom_calendar_bar_widget.dart';

import '../../../../constant/hex_color.dart';

class SirkafluidScreen extends StatefulWidget {
  const SirkafluidScreen({Key? key}) : super(key: key);

  @override
  State<SirkafluidScreen> createState() => _SirkafluidScreenState();
}

class _SirkafluidScreenState extends State<SirkafluidScreen> {
  final isDrinkLogOpen = false.obs;
  final isDrinkWaterOpen = false.obs;

  String _getWaterIntakeString() {
    return "1800/2500ml";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        title: Text(
          "Sirkafluid".toUpperCase(),
          style: GoogleFonts.poppins(
              fontSize: 20.sp,
              letterSpacing: 3.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: HexColor.fromHex("73C639"),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10), child: Container()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 35.sp, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: HexColor.fromHex("F8F9FB"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCalenderBarWidget(
                centerWidget: Text("Hari ini", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500)),
                onCenterPressed: () {
                  print("object");
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Water Intake Goal
                    Container(
                      height: 145.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor.fromHex("73C639"),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(4, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Water Intake Goal",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _getWaterIntakeString(),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    Obx(
                      () => !isDrinkWaterOpen.value
                          ? _buildLogWater()
                          : _buildDrinkWater(),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLogWater() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    isDrinkWaterOpen.value = true;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        child: SvgPicture.asset(
                          "assets/icons/sirkafluid_droplet_empty.svg",
                          color: HexColor.fromHex("73C639"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Icon(Icons.add_rounded,
                            size: 80.sp, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Log Water",
                  style: GoogleFonts.poppins(
                      color: HexColor.fromHex("73C639"),
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: Offset(4, 2), // changes position of shadow
                ),
              ],
            ),
            child: Obx(
              () => Column(
                children: [
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Drink Log",
                          style: GoogleFonts.poppins(
                              color: HexColor.fromHex("73C639"),
                              fontWeight: FontWeight.w400,
                              fontSize: 19),
                        ),
                        IconButton(
                          onPressed: () {
                            isDrinkLogOpen.value = !isDrinkLogOpen.value;
                          },
                          icon: Icon(
                            FontAwesomeIcons.ellipsisH,
                            color: HexColor.fromHex("73C639"),
                          ),
                        )
                      ],
                    ),
                  ),
                  isDrinkLogOpen.value ? _buildDrinkLogList() : Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDrinkLogList() {
    final String drinkValue = "1000";
    final String drinkTime = "12.00 am";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildDrinkLogItem(drinkValue, drinkTime),
          _buildDrinkLogItem(drinkValue, drinkTime),
          _buildDrinkLogItem(drinkValue, drinkTime),
        ],
      ),
    );
  }

  Container _buildDrinkLogItem(String drinkValue, String drinkTime) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(4, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/sirkafluid_droplet_empty.svg",
            height: 20.h,
            color: HexColor.fromHex("73C639"),
          ),
          const SizedBox(width: 8),
          Text(
            "${drinkValue} ml",
            style: GoogleFonts.poppins(
                color: HexColor.fromHex("2E4638"),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp),
          ),
          Expanded(
            child: Text(
              "${drinkTime}",
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  color: HexColor.fromHex("#48647D").withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
          )
        ],
      ),
    );
  }

  Container _buildDrinkWater() {
    final selectedDrinkIndex = 0.obs;
    final totalDrink = 0.obs;

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: Text(
                    "${totalDrink.value}",
                    style: GoogleFonts.poppins(
                      color: HexColor.fromHex("73C639"),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      fontSize: 25.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "ml",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DrinkCircleWidget(
                  drinkValue: 250,
                  isSelected: selectedDrinkIndex.value == 1,
                  onPressed: (isSelected, value) {
                    selectedDrinkIndex.value = 1;
                    totalDrink.value = value!;
                  },
                ),
                _DrinkCircleWidget(
                  drinkValue: 500,
                  isSelected: selectedDrinkIndex.value == 2,
                  onPressed: (isSelected, value) {
                    selectedDrinkIndex.value = 2;
                    totalDrink.value = value!;
                  },
                ),
                _DrinkCircleWidget(
                  drinkValue: 750,
                  isSelected: selectedDrinkIndex.value == 3,
                  onPressed: (isSelected, value) {
                    selectedDrinkIndex.value = 3;
                    totalDrink.value = value!;
                  },
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 250,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  isDrinkWaterOpen.value = false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          child: SvgPicture.asset(
                            "assets/icons/sirkafluid_droplet_empty.svg",
                            color: HexColor.fromHex("73C639"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Icon(Icons.arrow_forward_rounded,
                              size: 70.sp, color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Confirm",
                      style: GoogleFonts.poppins(
                          color: HexColor.fromHex("73C639"),
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrinkCircleWidget extends StatelessWidget {
  const _DrinkCircleWidget({
    Key? key,
    this.isSelected = false,
    required this.onPressed,
    this.drinkValue = 250,
  }) : super(key: key);

  final bool isSelected;
  final int drinkValue;
  final void Function(bool, int?) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 60,
              height: 60,
              child: NeumorphicButton(
                onPressed: () {
                  onPressed(isSelected, drinkValue);
                },
                style: NeumorphicStyle(
                    color:
                        isSelected ? HexColor.fromHex("73C639") : Colors.white,
                    depth: 4,
                    boxShape: NeumorphicBoxShape.circle()),
                child: SvgPicture.asset("assets/icons/glass.svg",
                    color: isSelected ? Colors.white : Colors.grey),
              )),
          const SizedBox(height: 5),
          Text(
            "${drinkValue}ml",
            style: GoogleFonts.poppins(
                color: isSelected ? HexColor.fromHex("73C639") : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
