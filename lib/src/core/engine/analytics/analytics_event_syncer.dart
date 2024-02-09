import 'dart:async';

import 'package:amity_sdk/src/core/engine/analytics/analytics_event_sync_priority.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';

class AnalyticsEventSyncer {

  final AnalyticsRepo analyticsRepository;

  AnalyticsEventSyncer({required this.analyticsRepository});

  static const _highPriorityDuration = Duration(seconds: 10);
  static const _lowPriorityDuration = Duration(seconds: 60);
  StreamSubscription? _highPriorityStreamSubscription;
  StreamSubscription? _lowPriorityStreamSubscription;
  Stream? _highPriorityStream;
  Stream? _lowPriorityStream;

  void start() async {
    _highPriorityStream = Stream.periodic(_highPriorityDuration, (count) => count);
    _lowPriorityStream = Stream.periodic(_lowPriorityDuration, (count) => count);
    _createHighPrioritySyncTimer();
    _createLowPrioritySyncTimer();
  }


  void _createHighPrioritySyncTimer(){
    _highPriorityStreamSubscription = _highPriorityStream?.listen((event) {
      _syncCapturedEvent(AnalyticsEventSyncPriority.HIGH);
    });
  }

  void _createLowPrioritySyncTimer(){
    _lowPriorityStreamSubscription = _lowPriorityStream?.listen((event) {
      _syncCapturedEvent(AnalyticsEventSyncPriority.LOW);
    });
  }

  void _syncCapturedEvent(AnalyticsEventSyncPriority syncPriority){
    analyticsRepository.sendAnalyticsEvents(syncPriority).onError((error, stackTrace) =>  _dispose());
  }

  void deleteAllAnalyticsEvents(){
    analyticsRepository.deleteAllAnalyticsEvents();
  }

  void stop(){
    _dispose();
  }

  void _dispose(){
    _highPriorityStreamSubscription?.cancel();
    _lowPriorityStreamSubscription?.cancel();
  }
  
}
