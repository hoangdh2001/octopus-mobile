import 'package:dartz/dartz.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> addDevice(String id, Device device);
  Future<void> removeDevice(String id, String deviceID);
  Future<List<Device>> getDevices(String id);
}
