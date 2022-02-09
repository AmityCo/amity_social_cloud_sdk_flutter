// To parse this JSON data, do
//
//     final sessionResponse = sessionResponseFromJson(jsonString);

import 'dart:convert';

SessionResponse sessionResponseFromJson(String str) =>
    SessionResponse.fromJson(json.decode(str));

String sessionResponseToJson(SessionResponse data) =>
    json.encode(data.toJson());

class SessionResponse {
  SessionResponse({
    required this.status,
    required this.data,
  });

  final String status;
  final Data data;

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.users,
    required this.files,
  });

  final String accessToken;
  final String refreshToken;
  final List<User> users;
  final List<FileElement> files;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
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

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
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
    required this.extension,
    required this.size,
    required this.mimeType,
    required this.metadata,
  });

  final String name;
  final String extension;
  final String size;
  final String mimeType;
  final AttributesMetadata metadata;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        extension: json["extension"],
        size: json["size"],
        mimeType: json["mimeType"],
        metadata: AttributesMetadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "extension": extension,
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

  final ExifClass exif;
  final ExifClass gps;
  final int height;
  final int width;
  final bool isFull;

  factory AttributesMetadata.fromJson(Map<String, dynamic> json) =>
      AttributesMetadata(
        exif: ExifClass.fromJson(json["exif"]),
        gps: ExifClass.fromJson(json["gps"]),
        height: json["height"],
        width: json["width"],
        isFull: json["isFull"],
      );

  Map<String, dynamic> toJson() => {
        "exif": exif.toJson(),
        "gps": gps.toJson(),
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

class User {
  User({
    required this.userId,
    required this.roles,
    required this.permissions,
    required this.displayName,
    required this.description,
    required this.avatarFileId,
    required this.avatarCustomUrl,
    required this.flagCount,
    required this.hashFlag,
    required this.metadata,
    required this.isGlobalBan,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final List<String> roles;
  final List<String> permissions;
  final String displayName;
  final String description;
  final String avatarFileId;
  final String avatarCustomUrl;
  final int flagCount;
  final HashFlag hashFlag;
  final ExifClass metadata;
  final bool isGlobalBan;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        displayName: json["displayName"],
        description: json["description"],
        avatarFileId: json["avatarFileId"],
        avatarCustomUrl: json["avatarCustomUrl"],
        flagCount: json["flagCount"],
        hashFlag: HashFlag.fromJson(json["hashFlag"]),
        metadata: ExifClass.fromJson(json["metadata"]),
        isGlobalBan: json["isGlobalBan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "displayName": displayName,
        "description": description,
        "avatarFileId": avatarFileId,
        "avatarCustomUrl": avatarCustomUrl,
        "flagCount": flagCount,
        "hashFlag": hashFlag.toJson(),
        "metadata": metadata.toJson(),
        "isGlobalBan": isGlobalBan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class HashFlag {
  HashFlag({
    required this.bits,
    required this.hashes,
    required this.hash,
  });

  final int bits;
  final int hashes;
  final List<int> hash;

  factory HashFlag.fromJson(Map<String, dynamic> json) => HashFlag(
        bits: json["bits"],
        hashes: json["hashes"],
        hash: List<int>.from(json["hash"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bits": bits,
        "hashes": hashes,
        "hash": List<dynamic>.from(hash.map((x) => x)),
      };
}
