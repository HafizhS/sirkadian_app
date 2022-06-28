import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/hexcolor_controller.dart';
import '../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
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
    return !hasBeenInitialized
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
                  return SafeArea(
                    child: Scaffold(
                        backgroundColor: color.bgColor,
                        appBar: appBarWidget(context),
                        body: childWidget(context, snapshot)),
                  );
                case ConnectionState.done:
                  return SafeArea(
                    child: Scaffold(
                        backgroundColor: color.bgColor,
                        appBar: appBarWidget(context),
                        body: childWidget(context, snapshot)),
                  );
              }
            });
  }

  PreferredSize appBarWidget(BuildContext context) {
    return PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NeumorphicButton(
                margin: EdgeInsets.only(left: 20.w),
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
              Text(
                'Jadwalkan Olahragamu',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              NeumorphicButton(
                onPressed: () {
                  if (closeTopContainer) {
                    setState(() {
                      _controller.reverse();
                    });
                  } else {
                    setState(() {
                      _controller.forward();
                    });
                  }
                  setState(() {
                    closeTopContainer = !closeTopContainer;
                  });
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(10),
                  ),
                  color: color.primaryColor,
                ),
                padding: EdgeInsets.all(12.sp),
                margin: EdgeInsets.only(right: 20.w),
                child: AnimatedIcon(
                  icon: AnimatedIcons.event_add,
                  progress: _controller,
                  size: 20.sp,
                  color: color.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(70.h));
  }

  Widget childWidget(
      BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //segment 1

      AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: closeTopContainer ? 0 : 1,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 360.w,
          alignment: Alignment.topCenter,
          height: closeTopContainer ? 0 : 360.h,
          child: dateChildWidget(snapshot),
        ),
      ),

//segment 3
      Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
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
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold)),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '${exerciseController.selectedDay.day}/${exerciseController.selectedDay.month}/${exerciseController.selectedDay.year}',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16.sp,
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
                            margin: EdgeInsets.only(right: 10.w),
                            child: Text(
                              snapshot.data!.length.toString() + ' item',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              setState(() {
                                closeTopContainer = false;
                              });
                            },
                            padding: EdgeInsets.all(5.sp),
                            style: NeumorphicStyle(
                              depth: 2,
                              color: color.bgColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(5)),
                            ),
                            margin: EdgeInsets.only(right: 10.w),
                            child: FaIcon(
                              FontAwesomeIcons.chevronDown,
                              size: 20.sp,
                              color: color.secondaryTextColor,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: Text(
                          snapshot.data!.length.toString() + ' item',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                NeumorphicButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExerciseRecommendationScreen()));
                  },
                  padding: EdgeInsets.all(5.sp),
                  style: NeumorphicStyle(
                    depth: 2,
                    color: color.bgColor,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
                  ),
                  margin: EdgeInsets.only(right: 20.w),
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 20.sp,
                    color: color.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
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
                containerButton: () {},
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
                    difficulty:
                        exerciseController.listExercise[index].difficulty,
                  );
                  exerciseController.exerciseStore
                      .box<Exercise>()
                      .put(exercise);
                },
                icon: FontAwesomeIcons.trash,
                iconColor: color.redColor,
                imageFilename: snapshot.data![index].imageFilename!,
                depth: 4,
                onRecom: false,
                color: color,
                mets: snapshot.data![index].mets.toString(),
                desc: snapshot.data![index].desc!,
                difficulty: snapshot.data![index].difficulty!,
                title: snapshot.data![index].name!,
              );
            }),
      ),
    ]);
  }

//
  Widget dateChildWidget(AsyncSnapshot<List<Exercise>> snapshot) {
    return FittedBox(
      fit: BoxFit.fill,
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 360.w,
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

  Widget bottomSheetNecesityChild(String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
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
