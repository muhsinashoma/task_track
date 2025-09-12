import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart'; // 👈 for JSON serialization

@freezed
class KTask with _$KTask {
  const factory KTask({
    required String title,
    required String taskId,
    required String createdBy, // new field
    required String createdAt, // new field
  }) = _KTask;

  factory KTask.fromJson(Map<String, dynamic> json) => _$KTaskFromJson(json);
}
