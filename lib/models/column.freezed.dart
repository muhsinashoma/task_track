// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'column.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KColumn {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<KTask> get children => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KColumnCopyWith<KColumn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KColumnCopyWith<$Res> {
  factory $KColumnCopyWith(KColumn value, $Res Function(KColumn) then) =
      _$KColumnCopyWithImpl<$Res, KColumn>;
  @useResult
  $Res call({int id, String title, List<KTask> children, Color color});
}

/// @nodoc
class _$KColumnCopyWithImpl<$Res, $Val extends KColumn>
    implements $KColumnCopyWith<$Res> {
  _$KColumnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? children = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<KTask>,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KColumnImplCopyWith<$Res> implements $KColumnCopyWith<$Res> {
  factory _$$KColumnImplCopyWith(
          _$KColumnImpl value, $Res Function(_$KColumnImpl) then) =
      __$$KColumnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, List<KTask> children, Color color});
}

/// @nodoc
class __$$KColumnImplCopyWithImpl<$Res>
    extends _$KColumnCopyWithImpl<$Res, _$KColumnImpl>
    implements _$$KColumnImplCopyWith<$Res> {
  __$$KColumnImplCopyWithImpl(
      _$KColumnImpl _value, $Res Function(_$KColumnImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? children = null,
    Object? color = null,
  }) {
    return _then(_$KColumnImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<KTask>,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$KColumnImpl implements _KColumn {
  const _$KColumnImpl(
      {required this.id,
      required this.title,
      required this.children,
      this.color = Colors.blue});

  @override
  final int id;
  @override
  final String title;
  @override
  final List<KTask> children;
  @override
  @JsonKey()
  final Color color;

  @override
  String toString() {
    return 'KColumn(id: $id, title: $title, children: $children, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KColumnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title,
      const DeepCollectionEquality().hash(children), color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KColumnImplCopyWith<_$KColumnImpl> get copyWith =>
      __$$KColumnImplCopyWithImpl<_$KColumnImpl>(this, _$identity);
}

abstract class _KColumn implements KColumn {
  const factory _KColumn(
      {required final int id,
      required final String title,
      required final List<KTask> children,
      final Color color}) = _$KColumnImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  List<KTask> get children;
  @override
  Color get color;
  @override
  @JsonKey(ignore: true)
  _$$KColumnImplCopyWith<_$KColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
