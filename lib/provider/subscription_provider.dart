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

  Future<Response> getSubscriptionActiveUser(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(subscriptionActiveUserGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getSubscriptionHistoryUser(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(subscriptionHistoryUserGetUrl, headers: headers);

    return _response;
  }

  //post method
  Future<Response> postSubscriptionClaimCoupon(accessToken, couponCode) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await post(
        '$subscriptionClaimCouponPostUrl?coupon_code=$couponCode', null,
        headers: headers);

    return _response;
  }
}
