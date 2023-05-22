// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_members_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMembersRequest _$AddMembersRequestFromJson(Map<String, dynamic> json) =>
    AddMembersRequest(
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddMembersRequestToJson(AddMembersRequest instance) =>
    <String, dynamic>{
      'members': instance.members,
    };
