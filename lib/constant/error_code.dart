class LoginErrorCode {
  LoginErrorCode._();
  //401
  static const String usernameNotFound401 = '2115E15A43';
  static const String wrongPassword401 = '2115F09C83';
  //403
  static const String userNotActivatedYet403 = '20DA469057';
}

class RegisterErrorCode {
  RegisterErrorCode._();
//400
  static const String usernameAlreadyExist400 = '21517C2821';
  static const String emailAlreadyExist400 = '21518B6A61';
}

class ActivationErrorCode {
  ActivationErrorCode._();

  //400
  static const userWithAssociateEmailNotFound400 = '218D16F609';
  static const userAlreadyActivated400 = '218D263849';
  static const verificationNotFound400 = '218D357A89';
  static const verificationAlreadyUsed400 =
      '218D44BCC9'; //tanyain ke vindy maksudnya gimana?
  static const wrongVerificationCode400 = '218D53FF09'; //handlingnya gimana?
  static const verificationAlreadyExpired400 =
      '218D634149'; //handlingnya gimana?

}

class VerificationErrorCode {
  VerificationErrorCode._();

  //400
  static const invalidVerification400 = '20A5D32259';
}

class OpenWebsocketErrorCode {
  OpenWebsocketErrorCode._();

  //500
  static const verificationNotNeedNoVerification500 = '22FA77C3E9';
  static const websocketServerNotReady500 = '22FA870629';
}
