import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

abstract class WorkspaceRepository {
  Future<List<WorkspaceState>> getWorkspaces();

  Future<WorkspaceState> getWorkspaceByID(String id);

  Future<List<WorkspaceState>> searchWorkspace(
    Filter? filter, {
    String? query,
    List<SortOption>? sort,
    PaginationParams pagination = const PaginationParams(),
  });

  Future<WorkspaceState> createWorkspace(String name,
      {List<String> members = const []});

  Future<List<WorkspaceState>> getWorkspaceByUser();

  Future<WorkspaceState> createProject(
      String workspaceID, String name, List<TaskStatus> statusList,
      {List<String> members = const []});

  Future<ProjectState> createSpace(
      String workspaceID, String projectID, String name, Setting setting);

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
  });

  Future<ProjectState> updateTask(String workspaceID, String taskID, Task task);
}
