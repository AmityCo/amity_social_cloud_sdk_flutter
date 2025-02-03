// token_watcher_session_component.dart
import 'dart:async';
import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/domain/usecase/token/token_verifier.dart';
import 'package:amity_sdk/src/domain/usecase/user/get_current_account_usecase.dart';

class TokenWatcherSessionComponent extends SessionComponent {
  final AppEventBus appEventBus;
  Timer? _tokenWatcherTimer;
  List<StreamSubscription> _disposables = [];

  TokenWatcherSessionComponent({
    required this.appEventBus,
    required super.sessionLifeCycleEventBus,
    required super.sessionStateEventBus,
  });

  @override
  void onSessionStateChange(SessionState sessionState) {}

  @override
  void establish() {
    _disposeSubscriptions();
    _observeSessionState();
    _observeAppEvent();
    _startTokenWatcherInterval();
  }

  @override
  void destroy() {
    _disposeSubscriptions();
  }

  @override
  void handleTokenExpire() {
    _disposeSubscriptions();
  }

  Future<void> _checkAccessTokenExpiration() async {
    try {
      final account = await serviceLocator<GetCurrentAccountUseCase>().get();
        if (account != null) {
        final tokenResult = TokenVerifier.checkExpiration(account);
        log('Token verification result: $tokenResult');
        
        if (tokenResult == TokenVerifierResult.aboutToExpire) {
          appEventBus.publish(AppEvent.TokenAboutToExpire);
        } else if (tokenResult == TokenVerifierResult.expired) {
          appEventBus.publish(AppEvent.TokenExpire);
        }
      }
    } catch (e) {
      log('Error checking token expiration: $e');
    }
  }

  // Check access token expiration when a user continues/resumes an SDK session
  void _observeSessionState() {
    final subscription = sessionStateEventBus.observe()
        .listen((sessionState) {
      if (sessionState == SessionState.Established) {
        _checkAccessTokenExpiration();
      }
    });
    _disposables.add(subscription);
  }

  // Check access token expiration when a user continues/resumes an application session
  void _observeAppEvent() {
    final subscription = appEventBus.observe()
        .where((event) => event == AppEvent.AppForeground)
        .listen((_) {
      _checkAccessTokenExpiration();
    });
    _disposables.add(subscription);
  }

  // Check access token expiration automatically every 10 minutes regardless of user/sdk events
  void _startTokenWatcherInterval() {
    _tokenWatcherTimer?.cancel();
    _tokenWatcherTimer = Timer.periodic(
      const Duration(minutes: 10), // Adjust interval as needed
      (_) => _checkAccessTokenExpiration(),
    );
  }

  void _disposeSubscriptions() {
    _tokenWatcherTimer?.cancel();
    _tokenWatcherTimer = null;
    for (var subscription in _disposables) {
      subscription.cancel();
    }
    _disposables.clear();
  }
}
