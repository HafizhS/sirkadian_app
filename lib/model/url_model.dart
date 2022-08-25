final String root = 'https://api.sirkadian.my.id';
final String wssRoot = 'wss://api.sirkadian.my.id';

//auth
final String rootAuth = '$root/auth';
final String loginUrl = '$rootAuth/login';
final String registerUrl = '$rootAuth/register';
final String activationUrl = '$rootAuth/activation';
final String refreshTokenUrl = '$rootAuth/refresh';
final String usernamePassInputUrl = '$rootAuth/identity_setup';
final String forgotPasswordUrl = '$rootAuth/forgot';
final String verifikasiForgotPasswordUrl = '$rootAuth/verify_forgot';

// ---------------------------------------------------------------
//user
final String rootUser = '$root/user';
final String initialSetupPostUrl = '$rootUser/initial_setup';
final String userHealthPreferenceLatestGetUrl =
    '$rootUser/preference_history/latest';
final String userHealthPreferencePostUrl = '$rootUser/preference_history/add';
final String userHealthHistoryLatestGetUrl = '$rootUser/health_history/latest';
final String userHealthHistoryPostUrl = '$rootUser/health_history/add';
final String userInformationGetUrl = '$rootUser/info';
final String userImageProfilePostUrl = '$rootUser/change_image';

//subscription
final String rootSubscription = '$root/subscription';
final String rootUserSubscription = '$root/user_subscription';
final String subscriptionAllGetUrl = '$rootSubscription/all';
final String subscriptionClaimCouponPostUrl = '$rootSubscription/claim_coupon';
final String subscriptionActiveUserGetUrl =
    '$rootUserSubscription/active_subscription';
final String subscriptionHistoryUserGetUrl =
    '$rootUserSubscription/subscription_history';

//foods
final String rootFood = '$root/food';
final String rootUserFood = '$root/user_food';
final String foodAllGetUrl = '$rootFood/all';
final String foodItemGetUrl = '$rootFood';
final String foodRecommendationGetUrl = '$rootUserFood/recommendation?';
final String foodRecommendationByFoodGetUrl = '$rootUserFood/';
final String foodRecommendationMenuGetUrl =
    '$rootUserFood/menu_recommendation?';
final String necessityGetUrl = '$rootUserFood/necessity';
final String foodHistoryGetPostUrl = '$rootUserFood/history';

//exercise
final String rootExercise = '$root/sport';
final String rootUserExercise = '$root/user_sport';
final String exerciseAllGetUrl = '$rootExercise/all';
final String exerciseItemGetUrl = '$rootExercise';
final String exerciseHistoryUrl = '$rootUserExercise/history';

//article
final String rootArticle = '$root/article';
final String articleAllGetUrl = '$rootArticle/all?';
final String articleDetailGetUrl = '$rootArticle/';
