import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/add_group_request.dart';
import 'package:octopus/core/data/models/add_member_to_project_request.dart';
import 'package:octopus/core/data/models/add_members_with_email.dart';
import 'package:octopus/core/data/models/add_role_request.dart';
import 'package:octopus/core/data/models/add_task_request.dart';
import 'package:octopus/core/data/models/create_project_request.dart';
import 'package:octopus/core/data/models/create_space_request.dart';
import 'package:octopus/core/data/models/create_workspace_request.dart';
import 'package:octopus/core/data/models/get_task_response.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
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

  @GET('/workspaces/{id}/tasks/today')
  Future<GetTaskResponse> getTodayTasks(@Path('id') String id);

  @GET('/workspaces/{id}/tasks/overdue')
  Future<GetTaskResponse> getTasksOverdue(@Path('id') String id);

  @GET('/workspaces/{id}/tasks/notduedate')
  Future<GetTaskResponse> getTasksNotDueDate(@Path('id') String id);

  @GET('/workspaces/{id}/tasks/notstartday')
  Future<GetTaskResponse> getTasksByDateInterm(@Path('id') String id);

  @GET('/workspaces/{id}/tasks/done')
  Future<GetTaskResponse> getTaskDone(@Path('id') String id);

  @DELETE('/workspaces/{id}/projects/{projectID}/tasks/{taskID}')
  Future<ProjectState> deleteTask(
    @Path('id') String id,
    @Path('projectID') String projectID,
    @Path('taskID') String taskID,
  );

  @DELETE('/workspaces/{id}/projects/{projectID}/spaces/{spaceID}')
  Future<ProjectState> deleteSpace(
    @Path('id') String id,
    @Path('projectID') String projectID,
    @Path('spaceID') String spaceID,
  );

  @POST('/workspaces/{id}/members')
  Future<WorkspaceMember> addMembers(
    @Path('id') String id,
    @Body() AddMemberWithEmail addMemberWithEmail,
  );

  @POST('/workspaces/{id}/groups')
  Future<WorkspaceState> addGroup(
      @Path('id') String id, @Body() AddGroupRequest request);

  @POST('/workspaces/{id}/roles')
  Future<WorkspaceState> addRole(
      @Path('id') String id, @Body() AddRoleRequest request);

  // @POST('/workspaces/{id}/projects/{projectID}/members')
  // Future<ProjectState> addMemberToProject(
  //     @Path('id') String workspaceID,
  //     @Path('projectID') String projectID,
  //     @Body() AddMemberToProjectRequest request);
}
