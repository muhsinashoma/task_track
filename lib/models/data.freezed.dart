// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KData {
  int get from => throw _privateConstructorUsedError;
  KTask get task => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KDataCopyWith<KData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KDataCopyWith<$Res> {
  factory $KDataCopyWith(KData value, $Res Function(KData) then) =
      _$KDataCopyWithImpl<$Res, KData>;
  @useResult
  $Res call({int from, KTask task, String taskId});

  $KTaskCopyWith<$Res> get task;
}

/// @nodoc
class _$KDataCopyWithImpl<$Res, $Val extends KData>
    implements $KDataCopyWith<$Res> {
  _$KDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? task = null,
    Object? taskId = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as KTask,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KTaskCopyWith<$Res> get task {
    return $KTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KDataImplCopyWith<$Res> implements $KDataCopyWith<$Res> {
  factory _$$KDataImplCopyWith(
          _$KDataImpl value, $Res Function(_$KDataImpl) then) =
      __$$KDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int from, KTask task, String taskId});

  @override
  $KTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$KDataImplCopyWithImpl<$Res>
    extends _$KDataCopyWithImpl<$Res, _$KDataImpl>
    implements _$$KDataImplCopyWith<$Res> {
  __$$KDataImplCopyWithImpl(
      _$KDataImpl _value, $Res Function(_$KDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? task = null,
    Object? taskId = null,
  }) {
    return _then(_$KDataImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as KTask,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$KDataImpl implements _KData {
  const _$KDataImpl(
      {required this.from, required this.task, required this.taskId});

  @override
  final int from;
  @override
  final KTask task;
  @override
  final String taskId;

  @override
  String toString() {
    return 'KData(from: $from, task: $task, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KDataImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, task, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KDataImplCopyWith<_$KDataImpl> get copyWith =>
      __$$KDataImplCopyWithImpl<_$KDataImpl>(this, _$identity);
}

abstract class _KData implements KData {
  const factory _KData(
      {required final int from,
      required final KTask task,
      required final String taskId}) = _$KDataImpl;

  @override
  int get from;
  @override
  KTask get task;
  @override
  String get taskId;
  @override
  @JsonKey(ignore: true)
  _$$KDataImplCopyWith<_$KDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
