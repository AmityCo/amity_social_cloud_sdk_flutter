// token_renewal_session_component.dart
import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/token/access_token_renewal_impl.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:dio/dio.dart';

class TokenRenewalSessionComponent extends SessionComponent {
  final AppEventBus appEventBus;
  Function(AccessTokenRenewal)? _sessionWillRenewAccessToken;
  AccessTokenRenewalImpl? currentRenewal;

  //initiate the first one to be never failed
  DateTime lastFailedDateTime = DateTime.now().subtract(const Duration(days: 999));

  TokenRenewalSessionComponent({
    required this.appEventBus,
    required super.sessionLifeCycleEventBus,
    required super.sessionStateEventBus,
  }) {
    _observeTokenEvent();
  }

  @override
  void onSessionStateChange(SessionState sessionState) {}

  @override
  void establish() {}

  @override
  void destroy() {}

  @override
  void handleTokenExpire() {
    _finishCurrentRenewal();
  }

  void _observeTokenEvent() {
    appEventBus.observe().listen((event) {
      if (event == AppEvent.TokenExpire || event == AppEvent.TokenAboutToExpire) {
        _initiateRenewalIfNeeded();
      }
    });
  }

  void _initiateRenewalIfNeeded() {
    if (!_canInitiateRenewal()) return;
    
    final authRepo = serviceLocator.get<AuthenticationRepo>();
    final accountRepo = serviceLocator.get<AccountRepo>();
    final accessTokenRenewal = AccessTokenRenewalImpl(
      authRepo: authRepo,
      accountRepo: accountRepo,
      appEventBus: appEventBus,
      sessionLifeCycleEventBus: sessionLifeCycleEventBus,
      onRenewTokenSuccess: () {
        appEventBus.publish(AppEvent.TokenRenewSuccess);
        _finishCurrentRenewal();
      },
      onRenewTokenFailed: (throwable) {
        AmityException amityError;
        if (throwable is AmityException) {
          amityError = throwable;
        } else if (throwable is DioException) {
          amityError = throwable.toAmityExcetion();
        } else {
          amityError = AmityException(
            message: throwable.toString(),
            code: AmityError.UNKNOWN.code,
          );
        }
        if (amityError.toAmityError() == AmityError.USER_IS_GLOBAL_BANNED ||
            amityError.toAmityError() == AmityError.UNAUTHORIZED_ERROR) {
          appEventBus.publish(AppEvent.TerminationCodeReceive);
          _finishCurrentRenewal();
        } else {
          _unableToRenewWithCurrentRenewal();
        }
      },
      onUnableToRetrieveAuthToken: () {
        _unableToRenewWithCurrentRenewal();
      },
    );

    _initiateRenewal(accessTokenRenewal);
    _sessionWillRenewAccessToken?.call(accessTokenRenewal);
  }

  bool _canInitiateRenewal() {
    if (currentRenewal != null) return false;

    final tenMinutes = const Duration(minutes: 10);
    if (currentRenewal != null &&
        DateTime.now().isAfter(lastFailedDateTime.add(tenMinutes))) {
      return false;
    }
    return true;
  }

  void _initiateRenewal(AccessTokenRenewalImpl renewal) {
    currentRenewal = renewal;
  }

  void _unableToRenewWithCurrentRenewal() {
    currentRenewal?.invalidate();
    currentRenewal = null;
    lastFailedDateTime = DateTime.now();
  }

  void _finishCurrentRenewal() {
    currentRenewal?.invalidate();
    currentRenewal = null;
    lastFailedDateTime = DateTime.now().subtract(const Duration(days: 999));
  }

  void setSessionWillRenewAccessToken(Function(AccessTokenRenewal)? sessionHandler) {
    if (sessionHandler != null) {
      currentRenewal?.invalidate();
      currentRenewal = null;
      _sessionWillRenewAccessToken = sessionHandler;
      _initiateRenewalIfNeeded();
    }
  }

  bool isLegacyLogin() {
    return _sessionWillRenewAccessToken == null;
  }
}