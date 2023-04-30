// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      deviceID: json['deviceID'] as String,
      pushProvider: json['pushProvider'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'deviceID': instance.deviceID,
      'pushProvider': instance.pushProvider,
      'name': instance.name,
    };
