import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/model/obejctbox_model.dart/food_exercise_model.dart';
import 'package:sirkadian_app/objectbox.g.dart';
import 'package:sirkadian_app/screen/home/exercise_screen/exercise_future_sportPlan_screen.dart';
import 'package:sirkadian_app/widget/exercise_widget/exercise_tile.dart';
import 'package:path_provider/path_provider.dart';
import '../../../controller/hexcolor_controller.dart';
import '../../../controller/information_controller.dart';
import '../../../model/exercise_model/exercise_history_request_model.dart';
import '../../../widget/exercise_widget/exercise_gauge.dart';
import 'exercise_history_screen.dart';
import 'exercise_recommendation_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseGeneralScreen extends StatefulWidget {
  const ExerciseGeneralScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseGeneralScreen> createState() => _ExerciseGeneralScreenState();
}

class ExerciseGaugeModel {
  final Color color;
  final String stringValue;
  final String day;
  final double value;

  ExerciseGaugeModel(
      {required this.color,
      required this.stringValue,
      required this.day,
      required this.value});
}

class _ExerciseGeneralScreenState extends State<ExerciseGeneralScreen> {
  final color = Get.find<ColorConstantController>();
  final exerciseController = Get.find<ExerciseController>();
  final informationController = Get.find<InformationController>();
  final data = GetStorage('myData');
  late Stream<List<Exercise>> _exerciseStream;
  var hasbeeninitialized = false;
  var isExpandedOpen = false;
  List<Sports> listExercise = [];

  @override
  void initState() {
    if (data.read('dataSessionExercise') == null) {
      data.write('dataSessionExercise', {
        'sessionExercise': false,
      });
    }

    exerciseController.getDateTime();
    exerciseController.getDatePerWeek();

    getApplicationDocumentsDirectory().then((dir) {
      exerciseController.exerciseStore =
          Store(getObjectBoxModel(), directory: '${dir.path}/exercise');
    }).then((value) => setState(() {
          _exerciseStream = exerciseController.exerciseStore
              .box<Exercise>()
              .query(Exercise_.date
                  .equals(exerciseController.selectedDay.toString()))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          hasbeeninitialized = true;
        }));

    super.initState();
  }

  @override
  void dispose() {
    //print('-------------------------store Closed------------------------');
    exerciseController.exerciseStore.close();
    hasbeeninitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    exerciseController.getMonth();
    return !hasbeeninitialized
        ? SafeArea(
            child: Scaffold(
                body: Center(
            child: CircularProgressIndicator(
              color: color.secondaryColor,
            ),
          )))
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
                          appBar: appBarWidget(context, snapshot),
                          body: childWidget(context, snapshot)));
                case ConnectionState.done:
                  return SafeArea(
                      child: Scaffold(
                          appBar: appBarWidget(context, snapshot),
                          backgroundColor: color.bgColor,
                          body: childWidget(context, snapshot)));
              }
            });
  }

  PreferredSize appBarWidget(
      BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
    return PreferredSize(
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
                  exerciseController.selectedDayGauge = DateTime.utc(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day);
                  exerciseController.getDatePerWeek();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: color.bgColor,
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
              'SirkaExercise',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.w),
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureExercisePlanScreen(
                                hasBeenInitialized: hasbeeninitialized,
                                listExercise: snapshot.data!,
                              )));
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: color.bgColor,
                ),
                padding: EdgeInsets.all(16.sp),
                child: FaIcon(
                  FontAwesomeIcons.calendarAlt,
                  size: 16.sp,
                  color: color.secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(70.h),
    );
  }

  Widget childWidget(
    BuildContext context,
    AsyncSnapshot<List<Exercise>> snapshot,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Stack(alignment: Alignment.bottomRight, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 18.h),
          //segment 2
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //segment 2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: Text(
                          'Progress',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: color.primaryTextColor.withOpacity(0.1),
                            borderRadius: isExpandedOpen
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))
                                : BorderRadius.circular(10)),
                        margin: EdgeInsets.only(right: 20.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpandedOpen = !isExpandedOpen;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                exerciseController.selectedDayGauge.day
                                        .isLowerThan(8)
                                    ? 'Minggu 1'
                                    : exerciseController.selectedDayGauge.day
                                            .isLowerThan(15)
                                        ? 'Minggu 2'
                                        : exerciseController
                                                .selectedDayGauge.day
                                                .isLowerThan(22)
                                            ? 'Minggu 3'
                                            : 'Minggu 4',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              FaIcon(
                                isExpandedOpen
                                    ? FontAwesomeIcons.chevronUp
                                    : FontAwesomeIcons.chevronDown,
                                color: color.primaryTextColor.withOpacity(0.7),
                                size: 12.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 100),
                        opacity: isExpandedOpen ? 1 : 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          height: isExpandedOpen ? 50.h : 0,
                          margin: isExpandedOpen
                              ? EdgeInsets.symmetric(horizontal: 10.w)
                              : EdgeInsets.all(0),
                          padding: isExpandedOpen
                              ? EdgeInsets.all(10)
                              : EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: color.primaryTextColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              weekSelectWidget('Minggu 1', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 7);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget('Minggu 2', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 14);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget('Minggu 3', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 21);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget('Minggu 4', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 28);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      )
                      // exerciseGaugeWidget(size)
                    ],
                  )
                ],
              ),
              Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.all(20.sp),
                style: NeumorphicStyle(
                    color: color.bgColor,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(15),
                    )),
                child: Column(
                  children: [
                    Text(
                      'Rekomendasi Olahraga Mingguan',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                      child: Neumorphic(
                          style: NeumorphicStyle(
                              depth: -4,
                              color: color.backgroundColor,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20),
                              )),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Container(
                              height: 18.h,
                              width: 360.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: color.secondaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 28.h,
                              width: 0, // diganti sama sport history duration
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(left: 150.w),
                            //   child: Text(
                            //     '70 Menit',
                            //     style: GoogleFonts.inter(
                            //       textStyle: TextStyle(
                            //           color: color.primaryTextColor,
                            //           fontSize: 10.sp,
                            //           fontWeight: FontWeight.normal),
                            //     ),
                            //   ),
                            // ),
                          ])),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            '0 Menit',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '160 Menit',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 28.h,
              ),
            ],
          ),

          //segment 3

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Text(
                          'Olahraga hari ini',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          exerciseController.dateNoww,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
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
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(5)),
                        ),
                        margin: EdgeInsets.only(right: 20.w),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 20.sp,
                          color: color.secondaryTextColor,
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ExerciseHistoryScreen()));
                        },
                        padding: EdgeInsets.all(5.sp),
                        style: NeumorphicStyle(
                          depth: 2,
                          color: color.bgColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(5)),
                        ),
                        margin: EdgeInsets.only(right: 20.w),
                        child: FaIcon(
                          FontAwesomeIcons.history,
                          size: 20.sp,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          (snapshot.data!.isEmpty)
              ? Expanded(
                  child: Center(
                    child: Text(
                      'Belum ada Olahraga yang kamu pilih',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                )
              : listExerciseWidget(snapshot),
        ]),
        snapshot.data!.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                child: NeumorphicButton(
                    margin: EdgeInsets.only(top: 12.h),
                    onPressed: () {
                      if (exerciseController.sessionExerciseClosed == false) {
                        setState(() {
                          exerciseController.sessionExerciseClosed.value = true;
                          exerciseController.saveSession();
                        });
                      } else {
                        setState(() {
                          exerciseController.sessionExerciseClosed.value =
                              false;
                          exerciseController.saveSession();
                        });
                      }

                      // snapshot.data!.forEach((element) {
                      //   listExercise.add(Sports(
                      //     sportId: element.sportId,
                      //     duration: 10,
                      //     amount: 10,
                      //     set: 2,
                      //   ));
                      // });
                      // final exerciseHistoryRequest = ExerciseHistoryRequest(
                      //     sportDate:
                      //         '${exerciseController.selectedDay.year}-${exerciseController.selectedDay.month}-${exerciseController.selectedDay.day}',
                      //     sports: listExercise);
                      // exerciseController.postExerciseHistory(
                      //     exerciseHistoryRequest: exerciseHistoryRequest);
                    },
                    style: NeumorphicStyle(
                        color: exerciseController.sessionExerciseClosed == true
                            ? color.redColor
                            : color.secondaryColor,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        )
                        //border: NeumorphicBorder()
                        ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
                    child: Text(
                      exerciseController.sessionExerciseClosed == true
                          ? 'Batalkan Sesi'
                          : 'Selesaikan Sesi',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
              )
            : Container()
      ]),
    );
  }

  Container weekSelectWidget(String week, Function() onPress) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
          color: color.primaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: onPress,
        child: Text(
          week,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Container exerciseGaugeWidget() {
    return Container(
        height: 320.h,
        width: 360.w,
        margin: EdgeInsets.all(20.sp),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: exerciseController.weekDays.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 360.w * 0.035, vertical: 5.h),
                child: ExerciseGauge(
                  textColor: DateTime.now().day.toString() ==
                          exerciseController.weekDays[index].day
                      ? color.secondaryColor
                      : color.secondaryTextColor,
                  backgroundColor: color.backgroundColor,
                  foregroundColor: exerciseController.weekDays[index].color,
                  value: exerciseController.weekDays[index].value,
                  day: exerciseController.weekDays[index].day,
                  stringValue:
                      exerciseController.weekDays[index].stringValue.toString(),
                ),
              );
            }));
  }

  Widget listExerciseWidget(
    AsyncSnapshot<List<Exercise>> snapshot,
  ) {
    return Expanded(
      child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ExerciseTile(
              containerButton: () {},
              onpressPlus: () {},
              onpressDelete: () {
                if (exerciseController.sessionExerciseClosed == true) {
                  informationController.snackBarError('Sesi Sudah Ditutup',
                      'Batalkan sesi untuk mengubah Olahraga');
                } else {
                  exerciseController.exerciseStore
                      .box<Exercise>()
                      .remove(snapshot.data![index].id);
                }
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
                  difficulty: exerciseController.listExercise[index].difficulty,
                );
                exerciseController.exerciseStore.box<Exercise>().put(exercise);
              },
              icon: exerciseController.sessionExerciseClosed == true
                  ? FontAwesomeIcons.check
                  : FontAwesomeIcons.trash,
              iconColor: exerciseController.sessionExerciseClosed == true
                  ? color.secondaryColor
                  : color.redColor,
              imageFilename: snapshot.data![index].imageFilename!,
              onRecom: false,
              color: color,
              mets: snapshot.data![index].mets.toString(),
              difficulty: snapshot.data![index].difficulty!,
              depth: exerciseController.sessionExerciseClosed == true ? 0 : 4,
              desc: snapshot.data![index].desc!,
              title: snapshot.data![index].name!,
            );
          }),
    );
  }
}
