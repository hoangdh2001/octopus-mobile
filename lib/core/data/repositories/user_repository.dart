import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({
    Filter? filter,
    List<SortOption>? sort,
    PaginationParams? pagination,
  });
  Future<void> addDevice(String id, Device device);
  Future<void> removeDevice(String id, String deviceID);
  Future<List<Device>> getDevices(String id);
}
