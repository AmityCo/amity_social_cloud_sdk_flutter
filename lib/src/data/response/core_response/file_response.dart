import 'dart:convert';

List<FileResponse> fileResponseFromJson(String str) => List<FileResponse>.from(
    json.decode(str).map((x) => FileResponse.fromJson(x)));
List<FileResponse> fileResponseFromList(List<dynamic> data) =>
    data.map((e) => FileResponse.fromJson(e)).toList();
String fileResponseToJson(List<FileResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileResponse {
  FileResponse({
    required this.fileId,
    required this.fileUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
    this.videoUrl 
  });

  final String fileId;
  final String fileUrl;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Attributes attributes;
  Map<String, dynamic>? videoUrl = {};

  factory FileResponse.fromJson(Map<String, dynamic> json) => FileResponse(
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        type: json["type"],
        videoUrl: json["videoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "fileUrl": fileUrl,
        "type": type,
        "videoUrl": videoUrl,
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
  final AttributesMetadata? metadata;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        ext: json["extension"],
        size: '${json["size"]}',
        mimeType: json["mimeType"],
        metadata: json["metadata"] == null
            ? null
            : AttributesMetadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "extension": ext,
        "size": size,
        "mimeType": mimeType,
        "metadata": metadata?.toJson(),
      };
}

class AttributesMetadata {
  AttributesMetadata({
    required this.exif,
    required this.gps,
    required this.height,
    required this.width,
    required this.isFull,
    required this.video,
    required this.audio,
  });

  final ExifClass? exif;
  final ExifClass? gps;
  final int? height;
  final int? width;
  final bool? isFull;
  final Video? video;
  final Audio? audio;

  factory AttributesMetadata.fromJson(Map<String, dynamic> json) =>
      AttributesMetadata(
        exif: json["exif"] == null ? null : ExifClass.fromJson(json["exif"]),
        gps: json["gps"] == null ? null : ExifClass.fromJson(json["gps"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
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

class Video {
  int? width;
  int? height;
  double? duration;
  int? bitrate;
  double? avgframerate;
  double? displayaspectratio;
  String? colourprimaries;

  Video(
      {this.width,
      this.height,
      this.duration,
      this.bitrate,
      this.avgframerate,
      this.displayaspectratio,
      this.colourprimaries});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
      width: json['width'],
      height: json['height'],
      duration: json['duration'].toDouble(),
      bitrate: json['bit_rate'],
      avgframerate: json['avg_frame_rate'].toDouble(),
      displayaspectratio: json['display_aspect_ratio'].toDouble(),
      colourprimaries: json['colour_primaries']
  );
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['duration'] = duration;
    data['bit_rate'] = bitrate;
    data['avg_frame_rate'] = avgframerate;
    data['display_aspect_ratio'] = displayaspectratio;
    data['colour_primaries'] = colourprimaries;
    return data;
  }
}

class Audio {
  String? samplerate;
  String? duration;
  String? bitrate;

  Audio({this.samplerate, this.duration, this.bitrate});

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
      samplerate: json['sample_rate'],
      duration: json['duration'],
      bitrate: json['bit_rate']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sample_rate'] = samplerate;
    data['duration'] = duration;
    data['bit_rate'] = bitrate;
    return data;
  }
}

class ExifClass {
  ExifClass();

  factory ExifClass.fromJson(Map<String, dynamic> json) => ExifClass();

  Map<String, dynamic> toJson() => {};
}
