import 'package:get/get_connect.dart';
import 'package:sirkadian_app/model/url_model.dart';

class SubscriptionProvider extends GetConnect {
  //post method------------------------------------------------------

  //get method-------------------------------------------------------

  Future<Response> getAllSubscription(accessToken) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(subscriptionAllGetUrl, headers: headers);

    return _response;
  }
}
