class FileResponse {
  FileResponse({
    required this.fileId,
    required this.fileUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });

  final String fileId;
  final String fileUrl;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Attributes attributes;

  factory FileResponse.fromJson(Map<String, dynamic> json) => FileResponse(
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "fileUrl": fileUrl,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.name,
    required this.ext,
    required this.size,
    required this.mimeType,
    required this.metadata,
  });

  final String name;
  final String ext;
  final String size;
  final String mimeType;
  final AttributesMetadata metadata;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        ext: json["extension"],
        size: '${json["size"]}',
        mimeType: json["mimeType"],
        metadata: AttributesMetadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "extension": ext,
        "size": size,
        "mimeType": mimeType,
        "metadata": metadata.toJson(),
      };
}

class AttributesMetadata {
  AttributesMetadata({
    required this.exif,
    required this.gps,
    required this.height,
    required this.width,
    required this.isFull,
  });

  final ExifClass? exif;
  final ExifClass? gps;
  final int height;
  final int width;
  final bool isFull;

  factory AttributesMetadata.fromJson(Map<String, dynamic> json) =>
      AttributesMetadata(
        exif: json["exif"] == null ? null : ExifClass.fromJson(json["exif"]),
        gps: json["gps"] == null ? null : ExifClass.fromJson(json["gps"]),
        height: json["height"],
        width: json["width"],
        isFull: json["isFull"],
      );

  Map<String, dynamic> toJson() => {
        "exif": exif == null ? null : exif!.toJson(),
        "gps": gps == null ? null : gps!.toJson(),
        "height": height,
        "width": width,
        "isFull": isFull,
      };
}

class ExifClass {
  ExifClass();

  factory ExifClass.fromJson(Map<String, dynamic> json) => ExifClass();

  Map<String, dynamic> toJson() => {};
}
