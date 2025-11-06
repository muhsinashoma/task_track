// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KTask _$KTaskFromJson(Map<String, dynamic> json) {
  return _KTask.fromJson(json);
}

/// @nodoc
mixin _$KTask {
  String get title => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError; // new field
  String get createdAt => throw _privateConstructorUsedError;
  int get projectId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KTaskCopyWith<KTask> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KTaskCopyWith<$Res> {
  factory $KTaskCopyWith(KTask value, $Res Function(KTask) then) =
      _$KTaskCopyWithImpl<$Res, KTask>;
  @useResult
  $Res call(
      {String title,
      String taskId,
      String createdBy,
      String createdAt,
      int projectId});
}

/// @nodoc
class _$KTaskCopyWithImpl<$Res, $Val extends KTask>
    implements $KTaskCopyWith<$Res> {
  _$KTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? taskId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? projectId = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KTaskImplCopyWith<$Res> implements $KTaskCopyWith<$Res> {
  factory _$$KTaskImplCopyWith(
          _$KTaskImpl value, $Res Function(_$KTaskImpl) then) =
      __$$KTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String taskId,
      String createdBy,
      String createdAt,
      int projectId});
}

/// @nodoc
class __$$KTaskImplCopyWithImpl<$Res>
    extends _$KTaskCopyWithImpl<$Res, _$KTaskImpl>
    implements _$$KTaskImplCopyWith<$Res> {
  __$$KTaskImplCopyWithImpl(
      _$KTaskImpl _value, $Res Function(_$KTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? taskId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? projectId = null,
  }) {
    return _then(_$KTaskImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KTaskImpl implements _KTask {
  const _$KTaskImpl(
      {required this.title,
      required this.taskId,
      required this.createdBy,
      required this.createdAt,
      required this.projectId});

  factory _$KTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$KTaskImplFromJson(json);

  @override
  final String title;
  @override
  final String taskId;
  @override
  final String createdBy;
// new field
  @override
  final String createdAt;
  @override
  final int projectId;

  @override
  String toString() {
    return 'KTask(title: $title, taskId: $taskId, createdBy: $createdBy, createdAt: $createdAt, projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KTaskImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, taskId, createdBy, createdAt, projectId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KTaskImplCopyWith<_$KTaskImpl> get copyWith =>
      __$$KTaskImplCopyWithImpl<_$KTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KTaskImplToJson(
      this,
    );
  }
}

abstract class _KTask implements KTask {
  const factory _KTask(
      {required final String title,
      required final String taskId,
      required final String createdBy,
      required final String createdAt,
      required final int projectId}) = _$KTaskImpl;

  factory _KTask.fromJson(Map<String, dynamic> json) = _$KTaskImpl.fromJson;

  @override
  String get title;
  @override
  String get taskId;
  @override
  String get createdBy;
  @override // new field
  String get createdAt;
  @override
  int get projectId;
  @override
  @JsonKey(ignore: true)
  _$$KTaskImplCopyWith<_$KTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
