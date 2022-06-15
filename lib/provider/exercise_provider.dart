import 'package:get/get_connect.dart';
import 'package:sirkadian_app/model/exercise_model/exercise_history_request_model.dart';
import 'package:sirkadian_app/model/url_model.dart';

class ExerciseProvider extends GetConnect {
  //post method------------------------------------------------------

  //get method-------------------------------------------------------

  Future<Response> getAllExercise(accessToken) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(exerciseAllGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getExerciseItem(accessToken, id) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get('$exerciseItemGetUrl/$id', headers: headers);

    return _response;
  }

  Future<Response> getExerciseHistory(
      {String? accessToken, String? startDate, String? endDate}) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(
        '$exerciseHistoryUrl?end_date=$endDate&start_date=$startDate',
        headers: headers);

    return _response;
  }

  //post method
  Future<Response> postExerciseHistory(
      {String? accessToken,
      ExerciseHistoryRequest? exerciseHistoryRequest}) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await post(
      exerciseHistoryUrl,
      exerciseHistoryRequest!.toJson(),
      headers: headers,
    );

    return _response;
  }
}
