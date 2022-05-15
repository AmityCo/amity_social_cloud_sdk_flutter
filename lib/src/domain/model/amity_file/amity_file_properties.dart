class AmityFileProperties {
  String? fileId;
  String? fileUrl;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  //Attribute
  String? name;
  String? ext;
  String? size;
  String? mimeType;

  //Metadata
  int? height;
  int? width;
  bool? isFull;

  @override
  String toString() {
    return 'AmityFileProperties(fileId: $fileId, fileUrl: $fileUrl, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, ext: $ext, size: $size, mimeType: $mimeType, height: $height, width: $width, isFull: $isFull)';
  }
}
