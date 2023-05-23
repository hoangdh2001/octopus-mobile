import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/add_task_request.dart';
import 'package:octopus/core/data/models/create_project_request.dart';
import 'package:octopus/core/data/models/create_space_request.dart';
import 'package:octopus/core/data/models/create_workspace_request.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:retrofit/retrofit.dart';

part 'workspace_service.g.dart';

@RestApi()
abstract class WorkspaceService {
  factory WorkspaceService(Dio dio, {String baseUrl}) = _WorkspaceService;

  @GET('/workspaces')
  Future<List<WorkspaceState>> getWorkspaces();

  @GET('/workspaces/{id}')
  Future<WorkspaceState> getWorkspaceByID(@Path('id') String id);

  @GET('/workspaces/search')
  Future<List<WorkspaceState>> searchWorkspace(
      @Query('payload') String payload);

  @POST('/workspaces')
  Future<WorkspaceState> createWorkspace(
      @Body() CreateWorkspaceRequest createWorkspaceRequest);

  @GET('/workspaces/users')
  Future<List<WorkspaceState>> getWorkspaceByUser();

  @POST('/workspaces/{id}/projects')
  Future<WorkspaceState> createProject(
      @Path('id') String id, @Body() CreateProjectRequest project);

  @POST('/workspaces/{id}/projects/{projectID}/spaces')
  Future<ProjectState> createSpace(@Path('id') String id,
      @Path('projectID') String projectID, @Body() CreateSpaceRequest project);

  @POST('/workspaces/{id}/projects/{projectID}/spaces/{spaceID}/tasks')
  Future<ProjectState> createTask(
      @Path('id') String id,
      @Path('projectID') String projectID,
      @Path('spaceID') String spaceID,
      @Body() AddTaskRequest addTaskRequest);

  @PUT('/workspaces/{id}/tasks/{taskID}')
  Future<ProjectState> updateTask(
    @Path('id') String id,
    @Path('taskID') String taskID,
    @Body() Task data,
  );
}
