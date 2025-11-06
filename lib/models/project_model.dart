class Project {
  final int id;
  final String name;
  final String project_owner_name;
  final int taskCount;

  Project({
    required this.id,
    required this.name,
    required this.project_owner_name,
    required this.taskCount,
  });

  // Create from JSON (if loading from API)
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      project_owner_name: json['project_owner_name'] ?? '',
      taskCount: int.tryParse(json['taskCount'].toString()) ?? 0,
    );
  }

  // Convert to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'project_owner_name': project_owner_name,
      'taskCount': taskCount,
    };
  }
}
