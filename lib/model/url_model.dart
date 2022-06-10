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
final String userInfromationGetUrl = '$rootUser/info';

//subscription
final String rootSubscription = '$root/subscription';
final String subscriptionAllGetUrl = '$rootSubscription/all';

//foods
final String rootFood = '$root/food';
final String rootUserFood = '$root/user_food';
final String foodAllGetUrl = '$rootFood/all';
final String foodRecommendationGetUrl = '$rootUserFood/recommendation?';
final String necessityGetUrl = '$rootUserFood/necessity';
final String foodHistoryGetPostUrl = '$rootUserFood/history';
// final String foodHistoryGetUrl = '$root/food/history?';

//exercise
final String rootExercise = '$root/sport';
final String rootUserExercise = '$root/user_sport';
final String exerciseAllGetUrl = '$rootExercise/all';
final String exerciseHistoryUrl = '$rootUserExercise/history';





//akun
// final String userUpdateEmailGetUrl = '$root/user/update_email';
// final String userUpdateEmailPatchUrl = '$root/user/verify_update_email';
// final String userUpdatePasswordGetUrl = '$root/user/update_password';
// final String userUpdatePasswordPatchUrl = '$root/user/verify_update_password';
// final String userUpdateGenderDobLangPatchUrl = '$root/user/update';

//drinks
// final String historyDrinkUrl = '$root/drink/history';