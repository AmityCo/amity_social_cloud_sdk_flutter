/// [AmityFileProperties]
class AmityFileProperties {
  /// File Id
  String? fileId;

  /// File Url
  String? fileUrl;

  /// File Path
  String? filePath;

  /// Type
  String? type;

  /// Create At
  DateTime? createdAt;

  /// Updated At
  DateTime? updatedAt;

  //Attribute
  /// File Name
  String? name;

  /// File Ext
  String? ext;

  /// File Size
  String? size;

  /// File Mime Type
  String? mimeType;

  //Metadata
  /// File Height
  int? height;

  /// File Width
  int? width;

  /// is Full Size
  bool? isFull;

  /// Raw File 
  Map<String, dynamic>? rawFile;

  @override
  String toString() {
    return 'AmityFileProperties(fileId: $fileId, fileUrl: $fileUrl, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, ext: $ext, size: $size, mimeType: $mimeType, height: $height, width: $width, isFull: $isFull)';
  }
}
