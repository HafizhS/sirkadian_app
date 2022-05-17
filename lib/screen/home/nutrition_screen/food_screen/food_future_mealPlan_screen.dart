import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../model/obejctbox_model.dart/food_model.dart';
import '../../../../objectbox.g.dart';
import '../../../../widget/food_widget/necessity_display.dart';
import 'food_mealplan_screen.dart';

class FutureMealPlanScreen extends StatefulWidget {
  FutureMealPlanScreen({
    Key? key,
    required this.hasBeenInitialized,
    required this.listMealNecessity,
  }) : super(key: key);
  final bool hasBeenInitialized;
  final List<Food> listMealNecessity;

  @override
  State<FutureMealPlanScreen> createState() => _FutureMealPlanScreenState();
}

class _FutureMealPlanScreenState extends State<FutureMealPlanScreen>
    with TickerProviderStateMixin {
  final foodController = Get.find<FoodController>();
  final color = Get.find<ColorConstantController>();
  bool isClicked = false;
  late AnimationController _controller;
  CalendarFormat format = CalendarFormat.month;
  // StreamController<List<Food>> controller = StreamController<List<Food>>();
  late Stream<List<Food>> _necessityStream;
  late Stream<List<Food>> _sarapanStream;
  late Stream<List<Food>> _makanSiangStream;
  late Stream<List<Food>> _makanMalamStream;
  late Stream<List<Food>> _snackStream;
  bool hasBeenInitialized = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    setState(() {
      _necessityStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      _sarapanStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()) &
              Food_.session.equals('Sarapan'))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      _makanSiangStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()) &
              Food_.session.equals('Makan Siang'))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      _makanMalamStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()) &
              Food_.session.equals('Makan Malam'))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      _snackStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()) &
              Food_.session.equals('Snack'))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      hasBeenInitialized = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //segment 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    margin: EdgeInsets.only(left: 20),
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
                  Text(
                    'Jadwalkan Dietmu',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      if (isClicked) {
                        setState(() {
                          _controller.reverse();
                        });
                      } else {
                        setState(() {
                          _controller.forward();
                        });
                      }
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(10),
                      ),
                      color: color.primaryColor,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: EdgeInsets.only(right: 20),
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _controller,
                      size: 20,
                      color: color.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
//segment 2
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    text: foodController.selectedDay.weekday == 1
                        ? 'Senin, '
                        : foodController.selectedDay.weekday == 2
                            ? 'Selasa, '
                            : foodController.selectedDay.weekday == 3
                                ? 'Rabu, '
                                : foodController.selectedDay.weekday == 4
                                    ? 'Kamis, '
                                    : foodController.selectedDay.weekday == 5
                                        ? 'Jumat, '
                                        : foodController.selectedDay.weekday ==
                                                6
                                            ? 'Sabtu, '
                                            : 'Minggu, ',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${foodController.selectedDay.day}/${foodController.selectedDay.month}/${foodController.selectedDay.year}',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder4<List<Food>, List<Food>, List<Food>, List<Food>>(
                  streams: Tuple4(_sarapanStream, _makanSiangStream,
                      _makanMalamStream, _snackStream),
                  // stream: _necessityStream,
                  builder: (context, snapshot) {
                    switch (snapshot.item1.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            color: color.secondaryColor,
                          ),
                        );
                      case ConnectionState.active:
                        return sessionChildWidget(
                            size,
                            snapshot.item1.data!,
                            snapshot.item2.data!,
                            snapshot.item3.data!,
                            snapshot.item4.data!);

                      case ConnectionState.done:
                        return sessionChildWidget(
                            size,
                            snapshot.item1.data!,
                            snapshot.item2.data!,
                            snapshot.item3.data!,
                            snapshot.item4.data!);
                    }
                  }),
              //segment 3
              !hasBeenInitialized
                  ? Center(
                      child: CircularProgressIndicator(
                        color: color.secondaryColor,
                      ),
                    )
                  : StreamBuilder<List<Food>>(
                      stream: _necessityStream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(
                                color: color.secondaryColor,
                              ),
                            );
                          case ConnectionState.active:
                            return childWidget(size, snapshot);
                          case ConnectionState.done:
                            return childWidget(size, snapshot);
                        }
                      })
            ]),
          ),
        ),
      ),
    );
  }

  Container sessionChildWidget(
      Size size,
      List<Food> listMealSarapan,
      List<Food> listMealMakanSiang,
      List<Food> listMealMakanMalam,
      List<Food> listMealSnack) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: size.height * 0.2,
      width: double.infinity,
      child: Swiper(
          itemCount: foodController.sessions.length,
          itemWidth: size.width * 0.8,
          index: 0,
          layout: SwiperLayout.DEFAULT,
          viewportFraction: 0.5,
          scale: 0.9,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return Container(
                  margin: EdgeInsets.all(10),
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodMealScreen(
                                    session: foodController.sessions[index])));
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      child: listMealSarapan.isNotEmpty
                          ? notEmptyChild(
                              listMealSarapan[0].imageFileName!, index, size)
                          : emptySessionChild(size, index)),
                );

              case 1:
                return Container(
                  margin: EdgeInsets.all(10),
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodMealScreen(
                                    session: foodController.sessions[index])));
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      child: listMealMakanSiang.isNotEmpty
                          ? notEmptyChild(
                              listMealMakanSiang[0].imageFileName!, index, size)
                          : emptySessionChild(size, index)),
                );
              case 2:
                return Container(
                  margin: EdgeInsets.all(10),
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodMealScreen(
                                    session: foodController.sessions[index])));
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      child: listMealMakanMalam.isNotEmpty
                          ? notEmptyChild(
                              listMealMakanMalam[0].imageFileName!, index, size)
                          : emptySessionChild(size, index)),
                );
              case 3:
                return Container(
                  margin: EdgeInsets.all(10),
                  child: NeumorphicButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodMealScreen(
                                    session: foodController.sessions[index])));
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      child: listMealSnack.isNotEmpty
                          ? notEmptyChild(
                              listMealSnack[0].imageFileName!, index, size)
                          : emptySessionChild(size, index)),
                );
              default:
                return Container(
                    margin: EdgeInsets.all(10),
                    child: NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodMealScreen(
                                      session:
                                          foodController.sessions[index])));
                        },
                        style: NeumorphicStyle(
                            color: color.primaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            )),
                        child: emptySessionChild(size, index)));
            }
          }),
    );
  }

  Widget notEmptyChild(String imageFilename, int index, Size size) {
    return Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: size.height * 0.1,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero),
          ),
          child: imageFilename == ''
              ? Icon(Icons.image_not_supported_rounded)
              : Image.network(
                  imageFilename,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  fit: BoxFit.cover,
                ),
        ),
        Text(
          foodController.sessions[index],
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(height: size.height * 0.01),
      ]),
    );
  }

  Widget emptySessionChild(Size size, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Neumorphic(
            style: NeumorphicStyle(
              color: color.primaryColor,
              shape: NeumorphicShape.flat,
              depth: 4,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(12.0),
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 16,
              color: color.secondaryColor,
            )),
        SizedBox(height: size.height * 0.02),
        Text(
          foodController.sessions[index],
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

//
  Widget childWidget(Size size, AsyncSnapshot<List<Food>> snapshot) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState:
          isClicked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: !hasBeenInitialized
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Nutrisi Hari ini',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: InkWell(
                          onTap: () {
                            Get.bottomSheet(Container(
                              decoration: BoxDecoration(
                                  color: color.primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              height: size.height * 0.5,
                              width: size.width,
                              padding: EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    bottomSheetNecesityChild(
                                        size,
                                        'Kalsium',
                                        foodController.calcium /
                                            foodController.necessity.value
                                                .micro!.calcium!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Zat Besi',
                                        foodController.iron /
                                            foodController
                                                .necessity.value.micro!.iron!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'zinc',
                                        foodController.zinc /
                                            foodController
                                                .necessity.value.micro!.zinc!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Copper',
                                        foodController.copper /
                                            foodController.necessity.value
                                                .micro!.copper!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Vitamin C',
                                        foodController.vitaminC /
                                            foodController.necessity.value
                                                .micro!.vitaminC!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Vitamin B1',
                                        foodController.vitaminB1 /
                                            foodController.necessity.value
                                                .micro!.vitaminB1!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Vitamin B2',
                                        foodController.vitaminB2 /
                                            foodController.necessity.value
                                                .micro!.vitaminB2!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Vitamin B3',
                                        foodController.vitaminB3 /
                                            foodController.necessity.value
                                                .micro!.vitaminB3!),
                                    bottomSheetNecesityChild(
                                        size,
                                        'Retinol',
                                        foodController.retinol /
                                            foodController.necessity.value
                                                .micro!.retinol!),
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: FaIcon(
                              FontAwesomeIcons.ellipsisH,
                              size: 20,
                              color: color.secondaryTextColor,
                            ),
                          )),
                    )
                  ],
                ),
                NecessityDisplayWidget(
                  size: size,
                  color: color,
                  listMeal: snapshot.data!,
                  foodController: foodController,
                ),
              ],
            ),
      secondChild: TableCalendar(
        focusedDay: foodController.focusedDay,
        firstDay: DateTime.utc(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDay: DateTime(2050),
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: format,
        // onFormatChanged: (CalendarFormat _format) {
        //   format = _format;
        // },
        headerStyle:
            HeaderStyle(formatButtonVisible: false, titleCentered: true),
        onDaySelected: (_selectedDay, _focusedDay) {
          setState(() {
            if (_selectedDay.day == DateTime.now().day) {
              foodController.selectedDay = DateTime.utc(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day);
            } else {
              foodController.selectedDay = _selectedDay;
            }

            foodController.focusedDay = _focusedDay;
            _necessityStream = foodController.foodStore
                .box<Food>()
                .query(Food_.date.equals(foodController.selectedDay.toString()))
                .watch(triggerImmediately: true)
                .map((query) => query.find());
            _sarapanStream = foodController.foodStore
                .box<Food>()
                .query(
                    Food_.date.equals(foodController.selectedDay.toString()) &
                        Food_.session.equals('Sarapan'))
                .watch(triggerImmediately: true)
                .map((query) => query.find());
            _makanSiangStream = foodController.foodStore
                .box<Food>()
                .query(
                    Food_.date.equals(foodController.selectedDay.toString()) &
                        Food_.session.equals('Makan Siang'))
                .watch(triggerImmediately: true)
                .map((query) => query.find());
            _makanMalamStream = foodController.foodStore
                .box<Food>()
                .query(
                    Food_.date.equals(foodController.selectedDay.toString()) &
                        Food_.session.equals('Makan Malam'))
                .watch(triggerImmediately: true)
                .map((query) => query.find());
            _snackStream = foodController.foodStore
                .box<Food>()
                .query(
                    Food_.date.equals(foodController.selectedDay.toString()) &
                        Food_.session.equals('Snack'))
                .watch(triggerImmediately: true)
                .map((query) => query.find());
          });
          print(foodController.selectedDay);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(foodController.selectedDay, date);
        },

        calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            selectedDecoration: BoxDecoration(
              color: color.secondaryColor,
            )),
      ),
    );
  }

  Widget bottomSheetNecesityChild(Size size, String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    top: size.height * 0.01,
                    bottom: size.height * 0.01),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 20,
                    top: size.height * 0.01,
                    bottom: size.height * 0.01),
                child: Text(
                  '${((value) * 100).round().toString()}%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14,
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
                  height: size.height * 0.02,
                  width: size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color.secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: size.height * 0.02,
                  width: size.width * value,
                ),
              ])),
        ],
      ),
    );
  }
}
