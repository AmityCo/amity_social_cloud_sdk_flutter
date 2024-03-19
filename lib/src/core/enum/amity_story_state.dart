enum AmityStorySyncState { CREATED, UPLOADING, SYNCING, SYNCED, FAILED }

/// [AmityMessageSyncState] Extension
extension AmityStorySyncStateExtension on AmityStorySyncState {
  String get value {
    return AmityStorySyncState.values[index].name.toLowerCase();
  }

  static AmityStorySyncState enumOf(String value) {
    return AmityStorySyncState.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityStorySyncState.SYNCED,
    );
  }
}