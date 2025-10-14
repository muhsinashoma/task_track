class ProjectListItem {
  final int id;
  final String name;
  final String project_owner_name;
  final String? attached_file;
  int taskCount;

  ProjectListItem({
    required this.id,
    required this.name,
    required this.project_owner_name,
    this.attached_file,
    this.taskCount = 0,
  });
}
