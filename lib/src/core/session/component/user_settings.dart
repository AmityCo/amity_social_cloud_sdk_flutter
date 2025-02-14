import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/domain/repo/network_settings_repo.dart';
import 'package:amity_sdk/src/src.dart';

class UserSettingSessionComponent extends SessionComponent {

  UserSettingSessionComponent({
    required super.sessionLifeCycleEventBus,
    required super.sessionStateEventBus,
  });

  void fetchChatSettings() async {
    await serviceLocator<NetworkSettingsRepo>().fetchChatSettings();
  }

  @override
  void onSessionStateChange(SessionState sessionState) {}

  @override
  void establish() {
    fetchChatSettings();
  }

  @override
  void destroy() {
    serviceLocator<NetworkSettingsRepo>().deleteChatSettings();
  }

  @override
  void handleTokenExpire() {}

}