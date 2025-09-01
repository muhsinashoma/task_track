// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KTaskImpl _$$KTaskImplFromJson(Map<String, dynamic> json) => _$KTaskImpl(
      title: json['title'] as String,
      taskId: json['taskId'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$KTaskImplToJson(_$KTaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'taskId': instance.taskId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
    };
