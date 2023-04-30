import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET("/users")
  Future<List<User>> getUsers();

  @GET("/users/{id}")
  Future<User> getUserByID(@Path("id") String id);

  @GET("/users/{id}/devices")
  Future<List<Device>> getDevices(@Path("id") String id);

  @POST("/users/{id}/devices")
  Future<EmptyResponse> addDevice(@Path("id") String id, @Body() Device device);

  @DELETE("/users/{id}/devices")
  Future<EmptyResponse> removeDevice(
      @Path("id") String id, @Query("id") String deviceID);
}
