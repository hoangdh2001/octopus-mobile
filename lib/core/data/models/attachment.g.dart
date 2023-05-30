// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      url: json['url'] as String?,
      title: json['title'] as String?,
      uploadState: json['uploadState'] == null
          ? null
          : UploadState.fromJson(json['uploadState'] as Map<String, dynamic>),
      fileSize: json['filesize'] as int?,
      mimeType: json['mimeType'] as String?,
      file: json['file'] == null
          ? null
          : AttachmentFile.fromJson(json['file'] as Map<String, dynamic>),
      secureUrl: json['secureUrl'] as String?,
      originalWidth: json['originalWidth'] as int?,
      originalHeight: json['originalHeight'] as int?,
      originalName: json['originalName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('thumbnailUrl', instance.thumbnailUrl);
  writeNotNull('url', instance.url);
  writeNotNull('secureUrl', instance.secureUrl);
  val['uploadState'] = instance.uploadState;
  val['_id'] = instance.id;
  writeNotNull('filesize', instance.fileSize);
  writeNotNull('mimeType', instance.mimeType);
  writeNotNull('originalWidth', instance.originalWidth);
  writeNotNull('originalHeight', instance.originalHeight);
  writeNotNull('originalName', instance.originalName);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('file', instance.file);
  writeNotNull('title', instance.title);
  return val;
}
