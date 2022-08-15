// ignore_for_file: constant_identifier_names
/// [AmityMessageSyncState]
enum AmityMessageSyncState { CREATED, UPLOADING, SYNCING, SYNCED, FAILED }

/// [AmityMessageSyncState] Extension
extension AmityMessageSyncStateExtension on AmityMessageSyncState {
  String get value {
    return AmityMessageSyncState.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityMessageSyncState enumOf(String value) {
    return AmityMessageSyncState.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityMessageSyncState.SYNCED,
    );
  }
}
