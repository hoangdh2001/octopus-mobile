// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:uuid/uuid.dart';

part 'attachment.g.dart';

/// The class that contains the information about an attachment
@JsonSerializable(includeIfNull: false)
class Attachment extends Equatable {
  /// Constructor used for json serialization
  Attachment({
    String? id,
    this.type,
    this.thumbnailUrl,
    this.url,
    String? title,
    UploadState? uploadState,
    this.fileSize,
    this.mimeType,
    this.file,
    this.secureUrl,
    this.originalWidth,
    this.originalHeight,
    this.originalName,
    this.createdAt,
    this.updatedAt,
  })  : id = id ?? const Uuid().v4(),
        title = title ?? file?.name ?? originalName,
        localUri = file?.path != null ? Uri.parse(file!.path!) : null {
    this.uploadState = uploadState ??
        ((url != null)
            ? const UploadState.success()
            : const UploadState.preparing());
  }

  /// Create a new instance from a json
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  // factory Attachment.fromOGAttachment(OGAttachmentResponse ogAttachment) =>
  //     Attachment(
  //       type: ogAttachment.type,
  //       text: ogAttachment.text,
  //       url: ogAttachment.imageUrl,
  //       thumbnailUrl: ogAttachment.thumbUrl,
  //       uploadState: const UploadState.success(),
  //     );

  @JsonKey(name: "type")
  final String? type;

  final String? thumbnailUrl;

  final String? url;

  final String? secureUrl;

  final Uri? localUri;

  late final UploadState uploadState;

  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "filesize")
  final int? fileSize;

  final String? mimeType;

  final int? originalWidth;

  final int? originalHeight;

  final String? originalName;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final AttachmentFile? file;

  final String? title;

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  /// Serialize to db data
  Map<String, dynamic> toData() => _$AttachmentToJson(this);

  Attachment copyWith({
    String? id,
    String? type,
    String? title,
    String? thumbnailUrl,
    String? url,
    String? secureUrl,
    String? mimeType,
    int? fileSize,
    UploadState? uploadState,
    int? originalWidth,
    int? originalHeight,
    String? originalName,
    DateTime? createdAt,
    DateTime? updatedAt,
    AttachmentFile? file,
  }) =>
      Attachment(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        url: url ?? this.url,
        secureUrl: secureUrl ?? this.secureUrl,
        mimeType: mimeType ?? this.mimeType,
        fileSize: fileSize ?? this.fileSize,
        uploadState: uploadState ?? this.uploadState,
        originalWidth: originalWidth ?? this.originalWidth,
        originalHeight: originalHeight ?? this.originalHeight,
        originalName: originalName ?? this.originalName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        file: file ?? this.file,
      );

  Attachment merge(Attachment? other) {
    if (other == null) return this;
    return copyWith(
      type: other.type,
      thumbnailUrl: other.thumbnailUrl,
      url: other.url,
      secureUrl: other.secureUrl,
      mimeType: other.mimeType,
      fileSize: other.fileSize,
      uploadState: other.uploadState,
      originalWidth: other.originalWidth,
      originalHeight: other.originalHeight,
      originalName: other.originalName,
      createdAt: other.createdAt,
      updatedAt: other.updatedAt,
      file: other.file,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        secureUrl,
        localUri,
        thumbnailUrl,
        url,
        mimeType,
        fileSize,
        uploadState,
        file,
      ];
}
