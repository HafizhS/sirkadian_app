import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sirkadian_app/model/url_model.dart';
import 'package:sirkadian_app/model/user_model/user_health_history_request_model.dart';
import 'package:sirkadian_app/model/user_model/user_health_preference_request_model.dart';

class UserProvider extends GetConnect {
  final data = GetStorage('myData');
  //get method ----------------------------------------

  Future<Response> getUserHealthPreferenceLatest(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userHealthPreferenceLatestGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getUserHealthHistoryLatest(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userHealthHistoryLatestGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getUserInformation(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userInformationGetUrl, headers: headers);

    return _response;
  }

  //post method

  Future<Response> postUserHealthPreference(accessToken,
      UserHealthPreferenceRequest postUserHealthPreferenceRequest) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await post(
        userHealthPreferencePostUrl, postUserHealthPreferenceRequest.toJson(),
        headers: headers);

    return _response;
  }

  Future<Response> postUserHealthHistory(
      accessToken, UserHealthHistoryRequest userHealthHistoryRequest) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await post(
        userHealthHistoryPostUrl, userHealthHistoryRequest.toJson(),
        headers: headers);

    return _response;
  }

  static var client = http.Client();
  Future<bool> postUserImageProfile(accessToken, image) async {
    Uri addressUri = Uri.parse(userImageProfilePostUrl);

    var headers = {'Authorization': 'Bearer ${accessToken}'};
    final imageUploadRequest = http.MultipartRequest('POST', addressUri);

    final file = await http.MultipartFile.fromPath('image', image.path);

    imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.files.add(file);
    var isSucceed = false;
    try {
      final streamedResponse = await imageUploadRequest.send();

      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print(responseData);
        Get.back();
        isSucceed = true;
      } else {
        print(response.statusCode);
        print(response.body);
        Get.back();
        isSucceed = false;
      }
    } catch (e) {
      print(e.toString());
    }
    return isSucceed;
  }
}
