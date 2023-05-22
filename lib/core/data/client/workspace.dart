import 'dart:async';

import 'package:collection/collection.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/project.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/user.dart';
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
      String name, List<TaskStatus> statusList) async {
    _checkInitialized();
    final workspace =
        await _workspaceRepository.createProject(id!, name, statusList);
    state?.updateWorkspaceState(workspace);
    return workspace;
  }

  Future<Project> createSpace(
      String projectID, String name, Setting setting) async {
    _checkInitialized();
    final project =
        await _workspaceRepository.createSpace(id!, projectID, name, setting);
    state?.updateProject(project);
    return project;
  }

  Future<Project> newTask(
    String projectID,
    String spaceID,
    String name, {
    String? description,
    List<User>? assignees,
    DateTime? startDate,
    DateTime? dueDate,
  }) {
    _checkInitialized();
    final a = assignees?.map((e) => e.id).toList();
    return _workspaceRepository.createTask(
      id!,
      projectID,
      spaceID,
      name,
      description: description,
      assignees: a,
      startDate: startDate,
      dueDate: dueDate,
    );
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

  List<Project> get projects => _workspaceState.projects ?? <Project>[];

  Stream<List<Project>> get projectsStream => workspaceStateStream
      .map((cs) => cs.projects ?? <Project>[])
      .distinct(const ListEquality().equals);

  WorkspaceState get _workspaceState => _workspaceStateController.value;

  Stream<WorkspaceState> get workspaceStateStream =>
      _workspaceStateController.stream;

  WorkspaceState get workspaceState => _workspaceStateController.value;
  late BehaviorSubject<WorkspaceState> _workspaceStateController;

  set _workspaceState(WorkspaceState v) {
    _workspaceStateController.add(v);
  }

  void updateProject(Project project) {
    final newProjects = [...projects];
    final oldIndex = newProjects.indexWhere((p) => p.id == project.id);
    if (oldIndex != -1) {
      Project? p;
      newProjects[oldIndex] = project;
    } else {
      newProjects.add(project);
    }
    _workspaceState = _workspaceState.copyWith(
      projects: newProjects,
    );
  }

  void updateWorkspaceState(WorkspaceState workspaceState) {
    _workspaceState = workspaceState.copyWith(
      projects: workspaceState.projects,
    );
  }

  void dispose() {
    _workspaceStateController.close();
  }
}
