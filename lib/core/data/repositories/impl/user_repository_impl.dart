import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/networks/services/user_service.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<List<User>> getUsers(
      {Filter? filter,
      List<SortOption>? sort,
      PaginationParams? pagination}) async {
    final users = await _userService.getUsers(jsonEncode({
      if (filter != null) 'filter_conditions': filter,
      if (sort != null) 'sort': sort,
      'page': pagination?.page,
      'size': pagination?.limit,
    }));
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
