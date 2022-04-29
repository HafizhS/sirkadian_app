import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../screen/list_screen.dart';

import '../model/auth_model/activation_request_model.dart';
import '../model/auth_model/activation_response_model.dart';
import '../model/auth_model/initialSetup_request_model.dart';
import '../model/auth_model/login_request_model.dart';
import '../model/auth_model/login_response_model.dart';
import '../model/auth_model/refreshToken_response_model.dart';
import '../model/auth_model/register_request_model.dart';
import '../model/auth_model/register_response_model.dart';
import '../model/auth_model/websocket_response_model.dart';
import '../model/url_model.dart';
import '../provider/auth_provider.dart';
import 'information_controller.dart';

class AuthController extends GetxController {
  final _provider = Get.put(AuthProvider());
  final informationController = Get.put(InformationController());
  final data = GetStorage('myData');
  final isLoading = false.obs;
  var cekGetWebsocket = false.obs;
  var cekWebsocket = false.obs;
  late WebSocketChannel channel;

  late DataWebsocketResponse websocketResponse = DataWebsocketResponse();

  void rememberAcc(
      {int? id,
      String? username,
      String? password,
      String? accessToken,
      String? refreshToken}) async {
    if (data.read('dataUser') != null) {
      print('dataUser sudah ada');

      if (id != null &&
          username != null &&
          password != null &&
          accessToken != null &&
          refreshToken != null) {
        data.remove('dataUser').then((_) => data.write('dataUser', {
              'id': id,
              'username': username,
              'password': password,
              'accessToken': accessToken,
              'refreshToken': refreshToken,
            }));

        print('disimpan');
      } else {
        print('data tidak lengkap 2');
      }
    } else {
      if (id != null &&
          username != null &&
          password != null &&
          accessToken != null &&
          refreshToken != null) {
        print('data belum ada');

        data.write('dataUser', {
          'id': id,
          'username': username,
          'password': password,
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        });

        print('disimpan');
      } else {
        print('data tidak lengkap 1');
      }
    }
  }

  void rememberRegister(
      {int? id, String? email, String? username, String? password}) {
    if (data.read('dataRegister') != null) {
      print('dataRegister dihapus');
      data.remove('dataRegister');
      if (id != null && email != null && username != null && password != null) {
        data.write('dataRegister', {
          'id': id,
          'email': email,
          'username': username,
          'password': password
        });
      } else {
        print('id/email tidak ditemukan');
      }
    } else {
      if (id != null && email != null) {
        data.write('dataRegister', {
          'id': id,
          'email': email,
          'username': username,
          'password': password
        });
      } else {
        print('id/email tidak ditemukan');
      }
    }
  }

  void logout() {
    if (data.read('dataUser') != null) {
      // data.erase();
      data.remove('dataUser');
      print('dataUser dihapus');
    } else {
      print('data tidak ada dan tidak dihapus');
    }
  }

  //login
  Future<void> postLogin({LoginRequest? loginRequest}) async {
    if (loginRequest!.username != '' && loginRequest.password != '') {
      informationController.loadingDialog('Harap Menunggu, Sedang Login');
      try {
        final Response _res =
            await _provider.postLogin(loginRequest: loginRequest);
        if (_res.statusCode == 200) {
          print(200);
          LoginResponse _loginResponse =
              LoginResponse.fromJson(_res.body as Map<String, dynamic>);

          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('login berhasil');
          if (_loginResponse.data.id != null &&
              _loginResponse.data.accessToken != null) {
            rememberAcc(
              username: loginRequest.username,
              password: loginRequest.password,
              accessToken: _loginResponse.data.accessToken,
              refreshToken: _loginResponse.data.refreshToken,
              id: _loginResponse.data.id,
            );

            Get.offAllNamed(RouteScreens.main);
          }
        } else if (_res.statusCode == 500) {
          print('error sc 500');
        } else {
          print(_res.statusCode);
          print(_res.body);
        }
      } catch (e) {
        e.toString();
        if (Get.isDialogOpen!) Get.back();
        informationController
            .showErrorSnackBar('terjadi masalah, harap ulangi');

        print(e);
      }
    } else {
      if (Get.isDialogOpen!) Get.back();
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan isi semua data pribadi Anda terlebih dahulu");
    }
  }

  //register ------------------------------------------------------------------------------
  Future<void> postRegister(RegisterRequest registerRequest) async {
    if (registerRequest.username!.isNotEmpty &&
        registerRequest.email!.isNotEmpty &&
        registerRequest.password!.isNotEmpty) {
      informationController
          .loadingDialog('Harap Menunggu, Sedang Mendaftarkan Akun Anda');
      try {
        final Response _res = await _provider.postRegister(registerRequest);

        if (_res.statusCode == 200) {
          RegisterResponse _registerResponse =
              RegisterResponse.fromJson(_res.body as Map<String, dynamic>);

          if (_registerResponse.data.id != null) {
            rememberRegister(
                id: _registerResponse.data.id,
                email: registerRequest.email,
                username: registerRequest.username,
                password: registerRequest.password);

            final String getWebsocketUrl =
                '$root/websocket/open/${_registerResponse.data.id}';

            if (cekGetWebsocket.value == false) {
              Future.delayed(Duration(seconds: 3), () {
                if (Get.isDialogOpen!) Get.back();
                informationController.showSuccessSnackBar('register berhasil');
                getWebsocket(
                    getWebsocketUrl, _registerResponse.data.id, 'register');
                Get.toNamed(RouteScreens.verification);
              });
            } else {
              //websocket udah true
              print('cekwebsocekttrue');
            }
          }
        } else if (_res.statusCode == 500) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showErrorSnackBar(
              'terjadi kesalahan pada server, harap ulangi pendaftaran');
        } else {
          print(_res.statusCode);
          print(_res.body);
        }
      } catch (e) {
        e.toString();
        if (Get.isDialogOpen!) Get.back();
        informationController.showErrorSnackBar(
            'terjadi kesalahan pada server, harap ulangi pendaftaran');
        print(e);
      }
    } else {
      if (Get.isDialogOpen!) Get.back();
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan isi semua data pribadi Anda terlebih dahulu");
    }
  }

  //activation ------------------------------------------------------------------------------
  Future<void> postActivation(
      ActivationRequest activationRequest, int _registerResponseId) async {
    if (activationRequest.code != null && activationRequest.email != '') {
      informationController
          .loadingDialog('Harap menunggu, Akun sedang diaktivasi');
      try {
        final Response _res = await _provider.postActivation(activationRequest);

        if (_res.statusCode == 200) {
          ActivationResponse _activationResponse =
              ActivationResponse.fromJson(_res.body as Map<String, dynamic>);

          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('Aktivasi berhasil');
          if (_activationResponse.data.accessToken != null) {
            Get.offNamed(RouteScreens.initialSetup, arguments: [
              _activationResponse.data.accessToken,
              _registerResponseId
            ]);
          }
        } else if (_res.statusCode == 500) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showErrorSnackBar(
              'terjadi kesalahan pada server, harap ulangi aktivasi');
        } else {}
      } catch (e) {
        e.toString();
        if (Get.isDialogOpen!) Get.back();
        informationController.showErrorSnackBar(
            'terjadi kesalahan pada sistem, tunggu beberapa saat lagi');
        print('error:' + e.toString());
      }
    } else {}
  }

  Future<void> postInitialSetup(
      {InitialSetupRequest? initialSetupRequest, String? accessToken}) async {
    informationController
        .loadingDialog('Harap menunggu, sedang memproses Data Anda');
    if (initialSetupRequest != null) {
      try {
        final Response _res = await _provider.postInitialSetup(
            initialSetupRequest: initialSetupRequest, accessToken: accessToken);

        if (_res.statusCode == 200) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('Initial Setup berhasil');
          final username = data.read('dataRegister')['username'];
          final password = data.read('dataRegister')['password'];
          Future.delayed(Duration(seconds: 2), () {
            postLogin(
                loginRequest:
                    LoginRequest(username: username, password: password));
          });
        } else {
          if (Get.isDialogOpen!) Get.back();
          informationController
              .showErrorSnackBar('terjadi kesalahan pada server, harap ulangi');
        }
      } catch (e) {
        e.toString();
        informationController.showErrorSnackBar(
            'terjadi kesalahan pada sistem, tunggu beberapa saat lagi');
        print('error:' + e.toString());
      }
    } else {
      // snackBarError("silakan isi ");
    }
  }

  //websocket ------------------------------------------------------------------------------
  Future<void> getWebsocket(getWebsocketUrl, id, purpose) async {
    try {
      final Response _res = await _provider.getWebsocket(getWebsocketUrl);

      if (_res.statusCode == 200) {
        channel =
            IOWebSocketChannel.connect(Uri.parse('$wssRoot/websocket/$id'));

        channel.stream.listen((data) {
          Map<String, dynamic> myMap = json.decode(data);
          print(data);
          if (cekWebsocket.value == false) {
            myMap.forEach((key, value) {
              print('udah ke mymap');
              print(key.toString());

              if (key.toString() == id.toString()) {
                print('udah dicocokin');
                DataWebsocketResponse _websocketResponse =
                    DataWebsocketResponse.fromJson(value);
                websocketResponse = _websocketResponse;

                if (purpose == 'register') {
                  if (websocketResponse.purpose == 'register') {
                    channel.sink.add(id.toString());

                    cekWebsocket(true);
                    print(cekWebsocket);
                  }
                } else if (purpose == 'forgot password') {
                  if (websocketResponse.purpose == 'forgot password') {
                    channel.sink.add(id.toString());

                    cekWebsocket(true);
                    print(cekWebsocket);
                  }
                }
              }
            });
          } else {
            if (!myMap.containsKey(id)) {
              if (websocketResponse.purpose == 'register') {
                channel.sink.close();
                print('udah di close');

                cekGetWebsocket(true);
                print('cekGet: $cekGetWebsocket');
              } else if (websocketResponse.purpose == 'forgot password') {}
            } else {
              print('masih ada isinya');
            }
          }
        });
      } else if (_res.statusCode == 500) {}
    } catch (e) {
      informationController.showErrorSnackBar(
          'terjadi kesalahan pada sistem, tunggu beberapa saat lagi');
      print('error websocket open:' + e.toString());
      print(e);
    }
  }

  //refreshToken ------------------------------------------------------------------------------
  Future<void> getUsableToken() async {
    final accessToken = data.read('dataUser')['accessToken'];
    if (accessToken != null) {
      bool isTokenExpired = JwtDecoder.isExpired(accessToken);
      /* getExpirationDate() - this method returns the expiration date of the token */
      DateTime expirationDate = JwtDecoder.getExpirationDate(accessToken);

      print('/refreshToken_provider.dart | Token Expiration date :' +
          expirationDate.toString());
      if (isTokenExpired) {
        print('token expired otw ganti token baru');
        getAccessToken();
      } else {
        print('/refreshToken_provider.dart | Token not Expired');
      }
    } else {
      print('accesstokenbelomkeread');
    }
  }

  Future<void> getAccessToken() async {
    final refreshToken = data.read('dataUser')['refreshToken'];

    try {
      final Response _res = await _provider.getUserAccessToken(refreshToken);

      if (_res.statusCode == 200) {
        RefreshTokenResponse _refreshTokenResponse =
            RefreshTokenResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_refreshTokenResponse.data != null) {
          rememberAcc(
            username: data.read('dataUser')['username'],
            password: data.read('dataUser')['password'],
            accessToken: _refreshTokenResponse.data!.accessToken,
            refreshToken: _refreshTokenResponse.data!.refreshToken,
            id: _refreshTokenResponse.data!.id,
          );
          print('dataUser diperbarui');
        } else {
          print('tidak ada refreshTokenResponse');
        }
      }
    } catch (e) {}
  }
}
