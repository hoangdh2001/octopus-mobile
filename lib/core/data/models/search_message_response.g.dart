// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMessagesResponse _$SearchMessagesResponseFromJson(
        Map<String, dynamic> json) =>
    SearchMessagesResponse()
      ..results = (json['results'] as List<dynamic>?)
              ?.map(
                  (e) => GetMessageResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..next = json['next'] as String?
      ..previous = json['previous'] as String?;
