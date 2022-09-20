import 'dart:async';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_links/uni_links.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../constant/hex_color.dart';
import 'dart:convert';
import '../../controller/hexcolor_controller.dart';
import '../../model/auth_model/activation_request_model.dart';
import '../../model/auth_model/websocket_response_model.dart';
import '../../model/url_model.dart';

class VerificationScreen extends StatefulWidget {
  final int id;
  final String websocketUrl;
  final String purpose;
  VerificationScreen({
    Key? key,
    required this.id,
    required this.websocketUrl,
    required this.purpose,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final data = GetStorage('myData');
  final authController = Get.find<AuthController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  late WebSocketChannel channel;
  late var dataStream;
  late Map<String, dynamic> myMap;
  var cekDataStream = false;
  var cekGetWebsocket = false;

  //uni_link
  bool _initialURILinkHandled = false;

  StreamSubscription? _sub;

  void getMyMap() {
    print('my map:' + myMap.toString());
    myMap.forEach((key, value) {
      print('udah ke mymap');
      print(key.toString());

      if (key.toString() == widget.id.toString()) {
        print('udah dicocokin');
        DataWebsocketResponse _websocketResponse =
            DataWebsocketResponse.fromJson(value);
        authController.websocketResponse = _websocketResponse;
        print(authController.websocketResponse.code);
        print(authController.websocketResponse.purpose);

        if (authController.websocketResponse.purpose == 'register') {
          setState(() {
            channel.sink.add(widget.id.toString());
          });
        } else if (authController.websocketResponse.purpose ==
            'forgot password') {
          setState(() {
            channel.sink.add(widget.id.toString());
          });
        }
      }

      if (!myMap.containsKey(widget.id)) {
        print('kesini 2');
        print(authController.websocketResponse.purpose);
        if (authController.websocketResponse.purpose == 'register') {
          setState(() {
            channel.sink.close();
            cekGetWebsocket = true;
          });
          print('udah di close');
          print('udah kesini');
          print('cekGet: $cekGetWebsocket');
        } else if (authController.websocketResponse.purpose ==
            'forgot password') {}
      } else {
        print('masih ada isinya');
      }
    });
  }

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      Fluttertoast.showToast(
          msg: "email sedang dikirim",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      _sub = linkStream.listen((String? link) {
        print(link);

        // Parse the link and warn the user, if it is not correct
        if (link != null) {
          print('listener is working');
          var uri = Uri.parse(link);
          authController.getLink(uri.toString());
          if (uri
              .toString()
              .contains('https://api.sirkadian.my.id/verification/')) {
            informationController.loadingDialog('sedang memproses data');
            Future.delayed(Duration(seconds: 3), () {
              myMap = json.decode(dataStream);
// && myMap.containsKey(widget.id)

              if (Get.isDialogOpen! &&
                  myMap.containsKey(widget.id.toString())) {
                Get.back();
                getMyMap();
              } else {
                Future.delayed(Duration(seconds: 4), () {
                  if (Get.isDialogOpen! &&
                      myMap.containsKey(widget.id.toString())) {
                    Get.back();
                    getMyMap();
                  } else {
                    print('kelamaan datanya dateng');
                  }
                });
              }
            });
          }

          if (!mounted) {
            return;
          }
        }
      });
    } else {
      debugPrint("Null Initial URI received");
    }
  }

  @override
  void initState() {
    print('init');

    super.initState();
    authController
        .getWebsocket(widget.websocketUrl, widget.id, widget.purpose)
        .then((value) {
      if (authController.successGetWebsocket) {
        print(authController.successGetWebsocket);

        // TODO Fix Future Still running after Screen Pop/Dispose
        Future.delayed(Duration(seconds: 1), () {
          channel = IOWebSocketChannel.connect(
              Uri.parse('$wssRoot/websocket/${widget.id}'));
          channel.stream.listen((data) {
            setState(() {
              dataStream = data;
              myMap = json.decode(dataStream);

              print('my map:' + myMap.toString());
              myMap.forEach((key, value) {
                if (key.toString() == widget.id.toString()) {
                  setState(() {
                    cekDataStream = true;
                  });
                }
                print('udah ke mymap');
                print(key.toString());
              });
              print(dataStream);
            });
          });
        });
      } else {
        print('channel is not open yet');
      }
    });
    _initURIHandler();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.bgColor,
        body: SafeArea(
          child: cekGetWebsocket == true
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 40.h),
                  height: 800.h,
                  width: 360.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //segmen 1
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Get.back();
                                        setState(() {
                                          channel.sink.close();
                                        });
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
                                    'Aktivasi Akun',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: color.secondaryTextColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(width: 30.h)
                                ],
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              Text(
                                'Akun Anda Telah diverifikasi, aktivasi sekarang!',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.secondaryTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),

                        //segmen 2
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NeumorphicButton(
                                margin: EdgeInsets.only(top: 12.h),
                                onPressed: () {
                                  final _data = data.read('dataRegister');
                                  final activationRequest = ActivationRequest(
                                      code: int.parse(authController
                                          .websocketResponse.code!),
                                      email: _data['email']);

                                  authController.postActivation(
                                      activationRequest, _data['id']);
                                },
                                style: NeumorphicStyle(
                                    color: color.secondaryColor,
                                    depth: 4,
                                    // shadowDarkColor: HexColor.fromHex('#C3C3C3'),
                                    // shadowLightColor: HexColor.fromHex('#FFFFFF'),
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20),
                                    )
                                    //border: NeumorphicBorder()
                                    ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 120.w),
                                child: Text(
                                  "Aktivasi",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )),
                          ],
                        ),
                      ]),
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 40.h),
                  height: 800.h,
                  width: 360.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //segmen 1
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.arrowLeft,
                                        size: 25.sp,
                                        color: color.primaryTextColor,
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                    ),
                                  ),
                                  Text(
                                    'Verifikasi Akun',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: color.secondaryTextColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(width: 30.w)
                                ],
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              Text(
                                'Kami sudah mengirimkan e-mail verfikasi ke alamat e-mail Kamu! Silahkan cek akun kamu di :',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.secondaryTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  authController.data
                                              .read('dataRegister')['email']
                                              .toString() !=
                                          ''
                                      ? authController.data
                                          .read('dataRegister')['email']
                                          .toString()
                                      : 'user@gmail.com',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.tersierColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        cekDataStream == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(
                                          top: 12.h, right: 28.w),
                                      onPressed: () {
                                        // informationController
                                        //     .loadingDialog('sedang memuat data');
                                        //
                                        Map<String, dynamic> myMap =
                                            json.decode(dataStream);

                                        myMap.forEach((key, value) {
                                          print('udah ke mymap');
                                          print(key.toString());

                                          if (key.toString() ==
                                              widget.id.toString()) {
                                            print('udah dicocokin');
                                            DataWebsocketResponse
                                                _websocketResponse =
                                                DataWebsocketResponse.fromJson(
                                                    value);
                                            authController.websocketResponse =
                                                _websocketResponse;
                                            print(authController
                                                .websocketResponse.code);
                                            print(authController
                                                .websocketResponse.purpose);

                                            if (authController.websocketResponse
                                                    .purpose ==
                                                'register') {
                                              setState(() {
                                                channel.sink
                                                    .add(widget.id.toString());
                                              });
                                            } else if (authController
                                                    .websocketResponse
                                                    .purpose ==
                                                'forgot password') {
                                              setState(() {
                                                channel.sink
                                                    .add(widget.id.toString());
                                              });
                                            }
                                          }

                                          if (!myMap.containsKey(widget.id)) {
                                            print('kesini 2');
                                            if (authController.websocketResponse
                                                    .purpose ==
                                                'register') {
                                              setState(() {
                                                channel.sink.close();
                                                cekGetWebsocket = true;
                                              });
                                              print('udah di close');
                                              print('udah kesini');
                                              print('cekGet: $cekGetWebsocket');
                                            } else if (authController
                                                    .websocketResponse
                                                    .purpose ==
                                                'forgot password') {}
                                          } else {
                                            print('masih ada isinya');
                                          }
                                        });
                                        // Future.delayed(Duration(seconds: 5), () {
                                        //   if (authController.websocketResponse.code !=
                                        //       null) {
                                        //     if (Get.isDialogOpen!) Get.back();
                                        //   } else {
                                        //     if (Get.isDialogOpen!) Get.back();
                                        //     informationController.snackBarError(
                                        //         'Gagal Memuat Data',
                                        //         'Silakan konfirmasi email terlebih dahulu. jika sudah harap ulangi kembali');
                                        //   }
                                        // });
                                      },
                                      style: NeumorphicStyle(
                                          color: color.secondaryColor,
                                          depth: 4,
                                          shape: NeumorphicShape.flat,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20),
                                          )
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h, horizontal: 30.w),
                                      child: Text(
                                        "Sudah verifikasi? klik disini",
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )),
                                ],
                              )
                            : Container()
                      ]),
                ),
        ));
  }
}
