import 'dart:convert';

import 'package:octopus/core/data/models/add_group_request.dart';
import 'package:octopus/core/data/models/add_member_to_project_request.dart';
import 'package:octopus/core/data/models/add_members_with_email.dart';
import 'package:octopus/core/data/models/add_role_request.dart';
import 'package:octopus/core/data/models/add_task_request.dart';
import 'package:octopus/core/data/models/create_project_request.dart';
import 'package:octopus/core/data/models/create_space_request.dart';
import 'package:octopus/core/data/models/create_workspace_request.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/data/models/get_task_response.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/data/networks/services/workspace_service.dart';
import 'package:octopus/core/data/repositories/workspace_repository.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final WorkspaceService _workspaceService;

  WorkspaceRepositoryImpl(this._workspaceService);

  @override
  Future<List<WorkspaceState>> getWorkspaces() async {
    final workspaces = await _workspaceService.getWorkspaces();
    return workspaces;
  }

  @override
  Future<WorkspaceState> getWorkspaceByID(String id) async {
    final workspace = await _workspaceService.getWorkspaceByID(id);
    return workspace;
  }

  @override
  Future<List<WorkspaceState>> searchWorkspace(
    Filter? filter, {
    String? query,
    List<SortOption>? sort,
    PaginationParams pagination = const PaginationParams(),
  }) async {
    final channels = await _workspaceService.searchWorkspace(
      jsonEncode(
        {
          if (sort != null) 'sort': sort,
          if (filter != null) 'filter_conditions': filter,
          // pagination
          ...pagination.toJson(),
        },
      ),
    );
    return channels;
  }

  @override
  Future<WorkspaceState> createWorkspace(String name,
      {List<String> members = const []}) async {
    final workspace = await _workspaceService.createWorkspace(
      CreateWorkspaceRequest(
        name: name,
        members: members,
      ),
    );
    return workspace;
  }

  @override
  Future<List<WorkspaceState>> getWorkspaceByUser() async {
    final workspaces = await _workspaceService.getWorkspaceByUser();
    return workspaces;
  }

  @override
  Future<WorkspaceState> createProject(
      String workspaceID,
      String name,
      List<TaskStatus> statusList,
      bool createChannelForProject,
      bool workspaceAccess,
      {List<String> members = const []}) async {
    final workspace = await _workspaceService.createProject(
        workspaceID,
        CreateProjectRequest(
          name: name,
          members: members,
          statusList: statusList,
          createChannel: createChannelForProject,
          workspaceAccess: workspaceAccess,
        ));
    return workspace;
  }

  @override
  Future<ProjectState> createSpace(String workspaceID, String projectID,
      String name, Setting setting) async {
    final space = await _workspaceService.createSpace(workspaceID, projectID,
        CreateSpaceRequest(name: name, setting: setting));
    return space;
  }

  @override
  Future<ProjectState> createTask(
    String workspaceID,
    String projectID,
    String spaceID,
    String name, {
    String? description,
    List<String>? assignees,
    DateTime? startDate,
    DateTime? dueDate,
    required TaskStatus taskStatus,
  }) async {
    final task = await _workspaceService.createTask(
      workspaceID,
      projectID,
      spaceID,
      AddTaskRequest(
        name: name,
        description: description,
        assignees: assignees,
        startDate: startDate,
        dueDate: dueDate,
        taskStatus: taskStatus,
      ),
    );
    return task;
  }

  @override
  Future<ProjectState> updateTask(
      String workspaceID, String taskID, Task task) async {
    final project =
        await _workspaceService.updateTask(workspaceID, taskID, task);
    return project;
  }

  @override
  Future<GetTaskResponse> getTodayTasks(String workspaceID) async {
    final taskResponse = await _workspaceService.getTodayTasks(workspaceID);
    return taskResponse;
  }

  @override
  Future<GetTaskResponse> getTasksOverdue(String workspaceID) async {
    final taskResponse = await _workspaceService.getTasksOverdue(workspaceID);
    return taskResponse;
  }

  @override
  Future<GetTaskResponse> getTasksNotDueDate(String workspaceID) async {
    final taskResponse =
        await _workspaceService.getTasksNotDueDate(workspaceID);
    return taskResponse;
  }

  @override
  Future<GetTaskResponse> getTasksByDateInterm(String workspaceID) async {
    final taskResponse =
        await _workspaceService.getTasksByDateInterm(workspaceID);
    return taskResponse;
  }

  @override
  Future<GetTaskResponse> getTaskDone(String workspaceID) async {
    final taskResponse = await _workspaceService.getTaskDone(workspaceID);
    return taskResponse;
  }

  @override
  Future<ProjectState> deleteTask(
      String workspaceID, String projectID, String taskID) async {
    final project =
        await _workspaceService.deleteTask(workspaceID, projectID, taskID);
    return project;
  }

  @override
  Future<ProjectState> deleteSpace(
      String workspaceID, String projectID, String spaceID) async {
    final project =
        await _workspaceService.deleteSpace(workspaceID, projectID, spaceID);
    return project;
  }

  @override
  Future<WorkspaceMember> addMember(
      String workspaceID, String email, String role, String? group) async {
    final user = await _workspaceService.addMembers(workspaceID,
        AddMemberWithEmail(email: email, role: role, group: group));
    return user;
  }

  @override
  Future<WorkspaceState> addGroup(String workspaceID, String name,
      {String? description, List<String> members = const []}) async {
    final group = await _workspaceService.addGroup(
        workspaceID,
        AddGroupRequest(
            name: name, description: description, memberID: members));
    return group;
  }

  @override
  Future<WorkspaceState> addRole(String workspaceID, String name,
      {String? description,
      List<WorkspaceOwnCapability> permissions = const []}) async {
    final workspace = await _workspaceService.addRole(
        workspaceID,
        AddRoleRequest(
            name: name,
            description: description,
            ownCapabilities: permissions));
    return workspace;
  }

  // @override
  // Future<ProjectState> addMemberToProject(
  //     String workspaceID, String projectID, List<String> members) async {
  //   final project = await _workspaceService.addMemberToProject(
  //       workspaceID, projectID, AddMemberToProjectRequest(members));
  //   return project;
  // }
}
