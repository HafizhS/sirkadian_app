import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

import '../model/auth_model/activation_request_model.dart';
import '../model/auth_model/initialSetup_request_model.dart';
import '../model/auth_model/login_request_model.dart';
import '../model/auth_model/register_request_model.dart';
import '../model/url_model.dart';

class AuthProvider extends GetConnect {
  final data = GetStorage('myData');

  //post method------------------------------------------------------
  Future<Response> postLogin({
    LoginRequest? loginRequest,
  }) async {
    Response? _response;

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    final body =
        'username=${loginRequest!.username}&password=${loginRequest.password}';

    _response = await post(
      loginUrl,
      body,
      headers: headers,
    );

    return _response;
  }

  Future<Response> postRegister(RegisterRequest registerRequest) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    _response = await post(
      registerUrl,
      registerRequest.toJson(),
      headers: headers,
    );

    return _response;
  }

  Future<Response> getUserAccessToken(String refreshToken) async {
    Response? _response;

    var headers = {'Authorization': 'Bearer ${refreshToken}'};
    _response = await post(refreshTokenUrl, null, headers: headers);

    return _response;
  }

  Future<Response> postInitialSetup(
      {InitialSetupRequest? initialSetupRequest, String? accessToken}) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${accessToken}',
    };

    _response = await post(
      initialSetupPostUrl,
      initialSetupRequest!.toJson(),
      headers: headers,
    );

    return _response;
  }

  Future<Response> postActivation(ActivationRequest activationRequest) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    _response = await post(
      activationUrl,
      activationRequest.toJson(),
      headers: headers,
    );

    return _response;
  }

  //get method-------------------------------------------------------

  Future<Response> getWebsocket(getWebsocketUrl) async {
    Response? _response;

    _response = await get(getWebsocketUrl);

    return _response;
  }

  Future<Response> getLink(getLinkUrl) async {
    Response? _response = await get(getLinkUrl);

    return _response;
  }
}
