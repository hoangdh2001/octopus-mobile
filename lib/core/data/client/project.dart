import 'dart:async';

import 'package:collection/collection.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/space_state.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/repositories/workspace_repository.dart';
import 'package:rxdart/rxdart.dart';

class Project {
  final WorkspaceRepository _workspaceRepository;
  String? _id;

  Project(this._workspaceRepository, this._workspace, this._id);
  Workspace get client => _workspace;
  final Workspace _workspace;

  String? get id => state?._projectState.id ?? _id;

  Project.fromState(this._workspace, ProjectState projectState,
      WorkspaceRepository workspaceRepository)
      : _id = projectState.id,
        _workspaceRepository = workspaceRepository {
    _initializedCompleter.complete(true);
    state = ProjectClientState(this, projectState);
    _workspace.client.logger.info('New Project instance initialized');
  }

  final Completer<bool> _initializedCompleter = Completer();

  ProjectClientState? state;

  Future<bool> get initialized => _initializedCompleter.future;

  String get name {
    _checkInitialized();
    return state!._project.name;
  }

  DateTime get createdDate {
    _checkInitialized();
    return state!._projectState.createdDate;
  }

  DateTime? get updatedDate {
    _checkInitialized();
    return state!._projectState.updatedDate;
  }

  DateTime? get deletedDate {
    _checkInitialized();
    return state!._projectState.deletedDate;
  }

  bool? get status {
    _checkInitialized();
    return state!._projectState.status;
  }

  Setting get setting {
    _checkInitialized();
    return state!._projectState.setting;
  }

  Future<void> updateTask(String spaceID, Task task) async {
    _checkInitialized();
    state!.updateTask(spaceID, task);
  }

  void _checkInitialized() {
    assert(
      _initializedCompleter.isCompleted,
      "Project $_id hasn't been initialized yet. Make sure to call .watch()"
      ' or to instantiate the client using [Project.fromState]',
    );
  }

  Future<void> dispose() async {
    await _initializedCompleter.future;
    state?.dispose();
  }
}

class ProjectClientState {
  final Project _project;

  ProjectClientState(this._project, ProjectState projectState) {
    _projectStateController = BehaviorSubject.seeded(projectState);

    updateProjectState(projectState);
  }

  List<SpaceState> get spacesState =>
      _projectStateController.value.spaces ?? [];

  Stream<List<SpaceState>> get spacesStateStream => _projectStateController
      .map((cs) => cs.spaces ?? <SpaceState>[])
      .distinct(const ListEquality().equals);

  ProjectState get _projectState => _projectStateController.value;

  Stream<ProjectState> get projectStateStream => _projectStateController.stream;

  ProjectState get projectState => _projectStateController.value;
  late BehaviorSubject<ProjectState> _projectStateController;

  set _projectState(ProjectState v) {
    _projectStateController.add(v);
  }

  void updateTask(String spaceID, Task task) {
    final space = spacesState.firstWhere((s) => s.id == spaceID);
    final newTasks = [...(space.tasks ?? <Task>[])];
    final oldIndex = newTasks.indexWhere((t) => t.id == task.id);
    if (oldIndex != -1) {
      newTasks[oldIndex] = task;
    } else {
      newTasks.add(task);
    }
    updateSpace(space.copyWith(tasks: newTasks));
  }

  void updateSpace(SpaceState space) {
    final newSpaces = [...spacesState];
    final oldIndex = newSpaces.indexWhere((s) => s.id == space.id);
    if (oldIndex != -1) {
      ProjectState? p;
      newSpaces[oldIndex] = space;
    } else {
      newSpaces.add(space);
    }
    _projectState = _projectState.copyWith(
      spaces: newSpaces,
    );
  }

  void updateProjectState(ProjectState updateState) {
    _projectState = updateState;
  }

  void dispose() {
    _projectStateController.close();
  }
}
