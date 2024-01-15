
enum AmityError {
  BUSINESS_ERROR, //(500000),
  UNAUTHORIZED_ERROR, //(400100),
  ITEM_NOT_FOUND, //(400400),
  BAD_REQUEST_ERROR, //(400000),
  INVALID_REGULAR_EXPRESSION, //(400001),
  VIDEO_FORMAT_INVALID, //(400002),
  CONFLICT, //(400900),
  FORBIDDEN_ERROR, //(400300),
  PERMISSION_DENIED, //(400301),
  USER_IS_MUTED, //(400302),
  CHANNEL_IS_MUTED, //(400303),
  USER_IS_BANNED, //(400304),
  NUMBER_OF_MEMBER_EXCEED, //(400305),
  EXEMPT_FROM_BAN, //(400306),
  MAX_REPETITION_EXCEED, //(400307),
  BAN_WORD_FOUND, //(400308),
  LINK_NOT_ALLOWED, //(400309),
  TOO_MANY_MEMBER_ERROR, //(400310),
  RPC_RATE_LIMIT_ERROR, //(400311),
  USER_IS_GLOBAL_BANNED, //(400312),
  USER_IS_LAST_MODERATOR, //(400317),
  USER_IS_LAST_MEMBER, //(400318),
  NETWORK_NOTIFICATION_IS_OFF, //(400319),
  // Client SDK Errors
  INVALID_PARAMETER, //(800110),
  MALFORMED_DATA, //(800130),
  FILE_SIZE_EXCEEDED, //(800140),
  UNSUPPORTED, //(800800),
  CONNECTION_ERROR, //(800210),
  UNKNOWN_USER, //(810000),
  MISSING_API_KEY, //(810100),
  NOT_LOGGED_IN, //(800401),
  ESTABLISHING_ERROR, //(800402),
  TOKEN_EXPIRED, //(800403),
  UNKNOWN, //(800000);
}

extension AmityErrorExtention on AmityError {
  static AmityError enumOf(int value) {
    switch (value) {
      case 500000:
        return AmityError.BUSINESS_ERROR;
      case 400100:
        return AmityError.UNAUTHORIZED_ERROR;
      case 400400:
        return AmityError.ITEM_NOT_FOUND;
      case 400000:
        return AmityError.BAD_REQUEST_ERROR;
      case 400001:
        return AmityError.INVALID_REGULAR_EXPRESSION;
      case 400002:
        return AmityError.VIDEO_FORMAT_INVALID;
      case 400900:
        return AmityError.CONFLICT;
      case 400300:
        return AmityError.FORBIDDEN_ERROR;
      case 400301:
        return AmityError.PERMISSION_DENIED;
      case 400302:
        return AmityError.USER_IS_MUTED;
      case 400303:
        return AmityError.CHANNEL_IS_MUTED;
      case 400304:
        return AmityError.USER_IS_BANNED;
      case 400305:
        return AmityError.NUMBER_OF_MEMBER_EXCEED;
      case 400306:
        return AmityError.EXEMPT_FROM_BAN;
      case 400307:
        return AmityError.MAX_REPETITION_EXCEED;
      case 400308:
        return AmityError.BAN_WORD_FOUND;
      case 400309:
        return AmityError.LINK_NOT_ALLOWED;
      case 400310:
        return AmityError.TOO_MANY_MEMBER_ERROR;
      case 400311:
        return AmityError.RPC_RATE_LIMIT_ERROR;
      case 400312:
        return AmityError.USER_IS_GLOBAL_BANNED;
      case 400317:
        return AmityError.USER_IS_LAST_MODERATOR;
      case 400318:
        return AmityError.USER_IS_LAST_MEMBER;
      case 400319:
        return AmityError.NETWORK_NOTIFICATION_IS_OFF;
      case 800110:
        return AmityError.INVALID_PARAMETER;
      case 800130:
        return AmityError.MALFORMED_DATA;
      case 800140:
        return AmityError.FILE_SIZE_EXCEEDED;
      case 800800:
        return AmityError.UNSUPPORTED;
      case 800210:
        return AmityError.CONNECTION_ERROR;
      case 810000:
        return AmityError.UNKNOWN_USER;
      case 810100:
        return AmityError.MISSING_API_KEY;
      case 800401:
        return AmityError.NOT_LOGGED_IN;
      case 800402:
        return AmityError.ESTABLISHING_ERROR;
      case 800403:
        return AmityError.TOKEN_EXPIRED;
      case 800000:
        return AmityError.UNKNOWN;
      default:
        return AmityError.UNKNOWN;
    }
  }

  String get value {
    return AmityError.values[index].name.toLowerCase();
  }

  int get code {
    if (value == AmityError.BUSINESS_ERROR.value) {
      return 500000;
    }
    if (value == AmityError.UNAUTHORIZED_ERROR.value) {
      return 400100;
    }
    if (value == AmityError.BAD_REQUEST_ERROR.value) {
      return 400000;
    }
    if (value == AmityError.ITEM_NOT_FOUND.value) {
      return 400400;
    }
    if (value == AmityError.INVALID_REGULAR_EXPRESSION.value) {
      return 400001;
    }
    if (value == AmityError.VIDEO_FORMAT_INVALID.value) {
      return 400002;
    }
    if (value == AmityError.CONFLICT.value) {
      return 400900;
    }
    if (value == AmityError.FORBIDDEN_ERROR.value) {
      return 400300;
    }
    if (value == AmityError.PERMISSION_DENIED.value) {
      return 400301;
    }
    if (value == AmityError.USER_IS_MUTED.value) {
      return 400302;
    }
    if (value == AmityError.CHANNEL_IS_MUTED.value) {
      return 400303;
    }
    if (value == AmityError.USER_IS_BANNED.value) {
      return 400304;
    }
    if (value == AmityError.NUMBER_OF_MEMBER_EXCEED.value) {
      return 400305;
    }
    if (value == AmityError.EXEMPT_FROM_BAN.value) {
      return 400306;
    }
    if (value == AmityError.MAX_REPETITION_EXCEED.value) {
      return 400307;
    }
    if (value == AmityError.BAN_WORD_FOUND.value) {
      return 400308;
    }
    if (value == AmityError.LINK_NOT_ALLOWED.value) {
      return 400309;
    }
    if (value == AmityError.TOO_MANY_MEMBER_ERROR.value) {
      return 400310;
    }
    if (value == AmityError.RPC_RATE_LIMIT_ERROR.value) {
      return 400311;
    }
    if (value == AmityError.USER_IS_GLOBAL_BANNED.value) {
      return 400312;
    }
    if (value == AmityError.USER_IS_LAST_MODERATOR.value) {
      return 400317;
    }
    if (value == AmityError.USER_IS_LAST_MEMBER.value) {
      return 400318;
    }
    if (value == AmityError.NETWORK_NOTIFICATION_IS_OFF.value) {
      return 400319;
    }
    if (value == AmityError.INVALID_PARAMETER.value) {
      return 800110;
    }
    if (value == AmityError.MALFORMED_DATA.value) {
      return 800130;
    }
    if (value == AmityError.FILE_SIZE_EXCEEDED.value) {
      return 800140;
    }
    if (value == AmityError.UNSUPPORTED.value) {
      return 800800;
    }
    if (value == AmityError.CONNECTION_ERROR.value) {
      return 800210;
    }
    if (value == AmityError.MISSING_API_KEY.value) {
      return 810000;
    }
    if (value == AmityError.NOT_LOGGED_IN.value) {
      return 800401;
    }
    if (value == AmityError.ESTABLISHING_ERROR.value) {
      return 800402;
    }
    if (value == AmityError.TOKEN_EXPIRED.value) {
      return 800403;
    }
    

    return 800000;
  }

  int getValue(AmityError error) {
    if (error.value == AmityError.BUSINESS_ERROR.value) {
      return 500000;
    }
    if (error.value == AmityError.UNAUTHORIZED_ERROR.value) {
      return 400100;
    }
    if (error.value == AmityError.BAD_REQUEST_ERROR.value) {
      return 400000;
    }
    if (error.value == AmityError.ITEM_NOT_FOUND.value) {
      return 400400;
    }
    if (error.value == AmityError.INVALID_REGULAR_EXPRESSION.value) {
      return 400001;
    }
    if (error.value == AmityError.VIDEO_FORMAT_INVALID.value) {
      return 400002;
    }
    if (error.value == AmityError.CONFLICT.value) {
      return 400900;
    }
    if (error.value == AmityError.FORBIDDEN_ERROR.value) {
      return 400300;
    }
    if (error.value == AmityError.PERMISSION_DENIED.value) {
      return 400301;
    }
    if (error.value == AmityError.USER_IS_MUTED.value) {
      return 400302;
    }
    if (error.value == AmityError.CHANNEL_IS_MUTED.value) {
      return 400303;
    }
    if (error.value == AmityError.USER_IS_BANNED.value) {
      return 400304;
    }
    if (error.value == AmityError.NUMBER_OF_MEMBER_EXCEED.value) {
      return 400305;
    }
    if (error.value == AmityError.EXEMPT_FROM_BAN.value) {
      return 400306;
    }
    if (error.value == AmityError.MAX_REPETITION_EXCEED.value) {
      return 400307;
    }
    if (error.value == AmityError.BAN_WORD_FOUND.value) {
      return 400308;
    }
    if (error.value == AmityError.LINK_NOT_ALLOWED.value) {
      return 400309;
    }
    if (error.value == AmityError.TOO_MANY_MEMBER_ERROR.value) {
      return 400310;
    }
    if (error.value == AmityError.RPC_RATE_LIMIT_ERROR.value) {
      return 400311;
    }
    if (error.value == AmityError.USER_IS_GLOBAL_BANNED.value) {
      return 400312;
    }
    if (error.value == AmityError.USER_IS_LAST_MODERATOR.value) {
      return 400317;
    }
    if (error.value == AmityError.USER_IS_LAST_MEMBER.value) {
      return 400318;
    }
    if (error.value == AmityError.NETWORK_NOTIFICATION_IS_OFF.value) {
      return 400319;
    }
    if (error.value == AmityError.INVALID_PARAMETER.value) {
      return 800110;
    }
    if (error.value == AmityError.MALFORMED_DATA.value) {
      return 800130;
    }
    if (error.value == AmityError.FILE_SIZE_EXCEEDED.value) {
      return 800140;
    }
    if (error.value == AmityError.UNSUPPORTED.value) {
      return 800800;
    }
    if (error.value == AmityError.CONNECTION_ERROR.value) {
      return 800210;
    }
    if (error.value == AmityError.MISSING_API_KEY.value) {
      return 810000;
    }
    if (error.value == AmityError.NOT_LOGGED_IN.value) {
      return 800401;
    }
    if (error.value == AmityError.ESTABLISHING_ERROR.value) {
      return 800402;
    }
    if (error.value == AmityError.TOKEN_EXPIRED.value) {
      return 800403;
    }
    

    return 800000;
  }
}
