import 'dart:async';

import 'package:collection/collection.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/client/project.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/data/models/get_task_response.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_group.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/data/models/workspace_role.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/data/repositories/workspace_repository.dart';
import 'package:rxdart/rxdart.dart';

class Workspace {
  final WorkspaceRepository _workspaceRepository;
  String? _id;

  Workspace(this._workspaceRepository, this._client, this._id);
  Client get client => _client;
  final Client _client;

  String? get id => state?._workspaceState.id ?? _id;

  Workspace.fromState(this._client, WorkspaceState workspaceState,
      WorkspaceRepository workspaceRepository)
      : _id = workspaceState.id,
        _workspaceRepository = workspaceRepository {
    state = WorkspaceClientState(this, workspaceState);
    _initializedCompleter.complete(true);
    _client.logger.info('New Channel instance initialized');
  }

  final Completer<bool> _initializedCompleter = Completer();

  WorkspaceClientState? state;

  Future<bool> get initialized => _initializedCompleter.future;

  String get name {
    _checkInitialized();
    return state!._workspaceState.name;
  }

  Future<WorkspaceState> createProject(
      String name,
      List<TaskStatus> statusList,
      bool createChannelForProject,
      bool workspaceAccess,
      List<User> users) async {
    _checkInitialized();
    final workspace = await _workspaceRepository.createProject(
        id!, name, statusList, createChannelForProject, workspaceAccess,
        members: users.map((e) => e.id).toList());

    // final updatedProject = await _workspaceRepository.addMemberToProject(
    //     id!, project.id, users.map((e) => e.id).toList());
    state?.updateWorkspaceState(workspace);
    return workspace;
  }

  Future<ProjectState> createSpace(
      String projectID, String name, Setting setting) async {
    _checkInitialized();
    final project =
        await _workspaceRepository.createSpace(id!, projectID, name, setting);
    state?.updateProject(project);
    return project;
  }

  Future<ProjectState> newTask(
    String projectID,
    String spaceID,
    String name, {
    String? description,
    List<User>? assignees,
    DateTime? startDate,
    DateTime? dueDate,
    required TaskStatus taskStatus,
  }) async {
    _checkInitialized();
    final a = assignees?.map((e) => e.id).toList();
    final project = await _workspaceRepository.createTask(
      id!,
      projectID,
      spaceID,
      name,
      description: description,
      assignees: a,
      startDate: startDate,
      dueDate: dueDate,
      taskStatus: taskStatus,
    );
    state?.updateProject(project);
    return project;
  }

  Future<ProjectState> updatePartialTask(Task task) async {
    _checkInitialized();
    final project = await _workspaceRepository.updateTask(id!, task.id, task);
    state?.updateProject(project);
    return project;
  }

  Future<GetTaskResponse> getTodayTasks() async {
    _checkInitialized();
    final tasks = await _workspaceRepository.getTodayTasks(id!);
    state?.updateWorkspaceState(tasks.workspace);
    return tasks;
  }

  Future<GetTaskResponse> getTasksOverdue() async {
    _checkInitialized();
    final tasks = await _workspaceRepository.getTasksOverdue(id!);
    state?.updateWorkspaceState(tasks.workspace);
    return tasks;
  }

  Future<GetTaskResponse> getTasksNotDueDate() async {
    _checkInitialized();
    final tasks = await _workspaceRepository.getTasksNotDueDate(id!);
    state?.updateWorkspaceState(tasks.workspace);
    return tasks;
  }

  Future<GetTaskResponse> getTasksByDateInterm() async {
    _checkInitialized();
    final tasks = await _workspaceRepository.getTasksByDateInterm(id!);
    state?.updateWorkspaceState(tasks.workspace);
    return tasks;
  }

  Future<GetTaskResponse> getTaskDone() async {
    _checkInitialized();
    final tasks = await _workspaceRepository.getTaskDone(id!);
    state?.updateWorkspaceState(tasks.workspace);
    return tasks;
  }

  Future<void> deleteTask(String projectID, String taskID) async {
    _checkInitialized();
    final project =
        await _workspaceRepository.deleteTask(id!, projectID, taskID);
    state?.updateProject(project);
  }

  Future<void> deleteSpace(String projectID, String spaceID) async {
    _checkInitialized();
    final project =
        await _workspaceRepository.deleteSpace(id!, projectID, spaceID);
    state?.updateProject(project);
  }

  Future<void> addMember(
      String email, WorkspaceRole role, WorkspaceGroup? group) async {
    _checkInitialized();
    final user =
        await _workspaceRepository.addMember(id!, email, role.id, group?.id);
    state?.updateMember(user);
  }

  Future<void> addGroup(String name,
      {String? description, List<String> members = const []}) async {
    _checkInitialized();
    final group = await _workspaceRepository.addGroup(id!, name,
        description: description, members: members);
    state?.updateWorkspaceState(group);
  }

  Future<void> addRole(String name,
      {String? description,
      List<WorkspaceOwnCapability> capabilities = const []}) async {
    _checkInitialized();
    final role = await _workspaceRepository.addRole(id!, name,
        description: description, permissions: capabilities);
    state?.updateWorkspaceState(role);
  }

  void _checkInitialized() {
    assert(
      _initializedCompleter.isCompleted,
      "Channel $_id hasn't been initialized yet. Make sure to call .watch()"
      ' or to instantiate the client using [Channel.fromState]',
    );
  }

  Future<void> dispose() async {
    await _initializedCompleter.future;
    state?.dispose();
  }
}

class WorkspaceClientState {
  final Workspace _workspace;

  WorkspaceClientState(this._workspace, WorkspaceState workspaceState) {
    _workspaceStateController = BehaviorSubject.seeded(workspaceState);

    updateWorkspaceState(workspaceState);
  }

  List<ProjectState> get projects =>
      _workspaceState.projects ?? <ProjectState>[];

  Stream<List<ProjectState>> get projectsStream => workspaceStateStream
      .map((cs) => cs.projects ?? <ProjectState>[])
      .distinct(const ListEquality().equals);

  WorkspaceState get _workspaceState => _workspaceStateController.value;

  Stream<WorkspaceState> get workspaceStateStream =>
      _workspaceStateController.stream;

  List<Project> get projectsMap => _projectsController.value;

  Stream<List<Project>> get projectsMapStream => _projectsController.stream;

  WorkspaceState get workspaceState => _workspaceStateController.value;
  late BehaviorSubject<WorkspaceState> _workspaceStateController;

  final BehaviorSubject<List<Project>> _projectsController =
      BehaviorSubject.seeded([]);

  set projectsMap(List<Project> v) {
    _projectsController.add(v);
  }

  void addProject(List<Project> projects) {
    final newProjects = [...projectsMap, ...projects];
    projectsMap = newProjects;
  }

  void removeProject(String projectID) {
    projectsMap = projectsMap
      ..removeWhere((project) => project.id == projectID);
  }

  set _workspaceState(WorkspaceState v) {
    _workspaceStateController.add(v);
  }

  void updateProject(ProjectState project) {
    final newProjects = [...projects];
    final oldIndex = newProjects.indexWhere((p) => p.id == project.id);
    if (oldIndex != -1) {
      ProjectState? p;
      newProjects[oldIndex] = project;
    } else {
      newProjects.add(project);
    }
    _workspaceState = _workspaceState.copyWith(
      projects: newProjects,
    );
    projectsMap = _mapProjectStateToProject([project]);
  }

  List<Project> _mapProjectStateToProject(
    List<ProjectState> projectsState,
  ) {
    final projects = [...projectsMap];
    for (final projectState in projectsState) {
      final project =
          projects.firstWhereOrNull((project) => project.id == projectState.id);
      if (project != null) {
        project.state?.updateProjectState(projectState);
      } else {
        final newProject = Project.fromState(
            _workspace, projectState, _workspace._workspaceRepository);
        if (newProject.id != null) {
          projects.add(newProject);
        }
      }
    }
    return projects;
  }

  void updateMember(WorkspaceMember user) {
    final newMembers = [..._workspaceState.members ?? <WorkspaceMember>[]];
    final oldIndex = newMembers.indexWhere((p) => p.user.id == user.user.id);
    if (oldIndex != -1) {
      newMembers[oldIndex] = user;
    } else {
      newMembers.add(user);
    }
    _workspaceState = _workspaceState.copyWith(
      members: newMembers,
    );
  }

  void updateWorkspaceState(WorkspaceState workspaceState) {
    _workspaceState = workspaceState.copyWith(
      projects: workspaceState.projects,
    );
    final project = _mapProjectStateToProject(workspaceState.projects ?? []);
    projectsMap = project;
  }

  void dispose() {
    _workspaceStateController.close();
  }
}
