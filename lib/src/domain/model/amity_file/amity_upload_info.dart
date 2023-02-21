class AmityUploadInfo {
  final Map<String, dynamic> _fileProperties;
  AmityUploadInfo(this._fileProperties);

  double getBytesWritten() {
    return _fileProperties['bytesWritten'];
  }

  int getProgressPercentage() {
    return _fileProperties['progress'];
  }

  double getContentLength() {
    return _fileProperties['contentLength'];
  }

  String getFilePath() {
    return _fileProperties['path'];
  }

  @override
  String toString() => 'AmityUploadInfo(_fileProperties: $_fileProperties)';
}
