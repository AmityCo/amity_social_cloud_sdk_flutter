import 'package:amity_sdk/src/core/session/event_bus/base_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';

class AppEventBus extends BaseEventBus<AppEvent> {
  static final AppEventBus _instance = AppEventBus._internal();

  factory AppEventBus() => _instance;

  AppEventBus._internal();
}