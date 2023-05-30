import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

/// The class that contains the information about a device
@JsonSerializable()
class Device {
  /// Constructor used for json serialization
  Device({
    required this.deviceID,
    required this.pushProvider,
    this.name,
  });

  /// Create a new instance from a json
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// The id of the device
  final String deviceID;

  /// The notification push provider
  final String pushProvider;

  final String? name;

  /// Serialize to json
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
