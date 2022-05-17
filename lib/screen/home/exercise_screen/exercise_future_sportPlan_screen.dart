import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controller/hexcolor_controller.dart';
import '../../../../model/obejctbox_model.dart/food_model.dart';
import '../../../../objectbox.g.dart';
import '../../../widget/exercise_widget/exercise_tile.dart';
import 'exercise_recommendation_screen.dart';

class FutureExercisePlanScreen extends StatefulWidget {
  FutureExercisePlanScreen({
    Key? key,
    required this.hasBeenInitialized,
    required this.listExercise,
  }) : super(key: key);
  final bool hasBeenInitialized;
  final List<Exercise> listExercise;

  @override
  State<FutureExercisePlanScreen> createState() =>
      _FutureExercisePlanScreenState();
}

class _FutureExercisePlanScreenState extends State<FutureExercisePlanScreen>
    with TickerProviderStateMixin {
  final exerciseController = Get.find<ExerciseController>();
  final color = Get.find<ColorConstantController>();
  ScrollController _scrollController = ScrollController();
  bool isClicked = false;
  late AnimationController _controller;
  CalendarFormat format = CalendarFormat.month;
  late Stream<List<Exercise>> _exerciseStream;
  bool hasBeenInitialized = false;
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    setState(() {
      _exerciseStream = exerciseController.exerciseStore
          .box<Exercise>()
          .query(
              Exercise_.date.equals(exerciseController.selectedDay.toString()))
          .watch(triggerImmediately: true)
          .map((query) => query.find());

      hasBeenInitialized = true;
    });
    _scrollController.addListener(() {
      setState(() {
        if (closeTopContainer == false) {
          print('false');
          closeTopContainer = _scrollController.offset > 50;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.backgroundColor,
      body: SafeArea(
          child: !hasBeenInitialized
              ? Center(
                  child: CircularProgressIndicator(
                    color: color.secondaryColor,
                  ),
                )
              : StreamBuilder<List<Exercise>>(
                  stream: _exerciseStream,
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
                        return childWidget(context, size, snapshot);
                      case ConnectionState.done:
                        return childWidget(context, size, snapshot);
                    }
                  })),
    );
  }

  Padding childWidget(
      BuildContext context, Size size, AsyncSnapshot<List<Exercise>> snapshot) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              'Jadwalkan Olahragamu',
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
        SizedBox(
          height: size.height * 0.01,
        ),
        //segment 2
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: closeTopContainer ? 0 : 1,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: size.width,
            alignment: Alignment.topCenter,
            height: closeTopContainer ? 0 : size.height * 0.5,
            child: dateChildWidget(size, snapshot),
          ),
        ),

//segment 3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  text: exerciseController.selectedDay.weekday == 1
                      ? 'Senin, '
                      : exerciseController.selectedDay.weekday == 2
                          ? 'Selasa, '
                          : exerciseController.selectedDay.weekday == 3
                              ? 'Rabu, '
                              : exerciseController.selectedDay.weekday == 4
                                  ? 'Kamis, '
                                  : exerciseController.selectedDay.weekday == 5
                                      ? 'Jumat, '
                                      : exerciseController
                                                  .selectedDay.weekday ==
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
                          '${exerciseController.selectedDay.day}/${exerciseController.selectedDay.month}/${exerciseController.selectedDay.year}',
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
            Row(
              children: [
                closeTopContainer
                    ? Row(
                        children: [
                          Container(
                            child: Text(
                              snapshot.data!.length.toString() + ' item',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  closeTopContainer = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.chevronDown,
                                  size: 20,
                                  color: color.secondaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: Text(
                          snapshot.data!.length.toString() + ' item',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ExerciseRecommendationScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 20,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              controller: _scrollController,
              // scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                double scale = 1.0;
                if (topContainer > 0.5) {
                  scale = index + 0.5 - topContainer;
                  if (scale < 0) {
                    scale = 0;
                  } else if (scale > 1) {
                    scale = 1;
                  }
                }
                return ExerciseTile(
                  onpressPlus: () {},
                  onpressDelete: () {
                    exerciseController.exerciseStore
                        .box<Exercise>()
                        .remove(snapshot.data![index].id);
                  },
                  onpressCheck: () {
                    exerciseController.exerciseStore
                        .box<Exercise>()
                        .remove(snapshot.data![index].id);
                    final exercise = Exercise(
                      name: exerciseController.listExercise[index].name,
                      desc: exerciseController.listExercise[index].desc,
                      isChecked: snapshot.data![index].isChecked =
                          !snapshot.data![index].isChecked!,
                      imageFilename: '',
                      date: exerciseController.selectedDay.toString(),
                      sportId: exerciseController.listExercise[index].sportId,
                      mets: exerciseController.listExercise[index].mets,
                    );
                    exerciseController.exerciseStore
                        .box<Exercise>()
                        .put(exercise);
                  },
                  exercise: snapshot.data![index],
                  imageFilename: '',
                  onRecom: false,
                  color: color,
                  subtitle_1: snapshot.data![index].mets.toString(),
                  subtitle_2: snapshot.data![index].desc!,
                  size: size,
                  title: snapshot.data![index].name!,
                );
              }),
        ),
      ]),
    );
  }

//
  Widget dateChildWidget(Size size, AsyncSnapshot<List<Exercise>> snapshot) {
    return FittedBox(
      fit: BoxFit.fill,
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: size.width,
        child: TableCalendar(
            focusedDay: exerciseController.focusedDay,
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
                  exerciseController.selectedDay = DateTime.utc(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day);
                } else {
                  exerciseController.selectedDay = _selectedDay;
                }

                exerciseController.focusedDay = _focusedDay;
                _exerciseStream = exerciseController.exerciseStore
                    .box<Exercise>()
                    .query(Exercise_.date
                        .equals(exerciseController.selectedDay.toString()))
                    .watch(triggerImmediately: true)
                    .map((query) => query.find());
              });
              print(exerciseController.selectedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(exerciseController.selectedDay, date);
            },
            calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                  color: color.secondaryColor,
                ))),
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
