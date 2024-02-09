enum AnalyticsEventSyncPriority {
  HIGH,
  LOW,
}

extension AnalyticsEventSyncPriorityExtension on AnalyticsEventSyncPriority {
  String get apiKey {
    return AnalyticsEventSyncPriority.values[index].name.toLowerCase();
  }

  static AnalyticsEventSyncPriority enumOf(String value) {
    return AnalyticsEventSyncPriority.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AnalyticsEventSyncPriority.LOW,
    );
  }
}
