import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class KTask with _$KTask {
  const factory KTask({
    required String title,
    required String taskId, //Added taskId Field
  }) = _KTask;
}
