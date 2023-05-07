import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/networks/services/user_service.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<List<User>> getUsers() async {
    final users = await _userService.getUsers();
    return users;
  }

  @override
  Future<void> addDevice(String id, Device device) async {
    try {
      await _userService.addDevice(id, device);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<List<Device>> getDevices(String id) async {
    try {
      final devices = await _userService.getDevices(id);
      return devices;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> removeDevice(String id, String deviceID) async {
    try {
      await _userService.removeDevice(id, deviceID);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
