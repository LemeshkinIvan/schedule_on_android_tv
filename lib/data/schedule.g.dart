// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDto _$ScheduleDtoFromJson(Map<String, dynamic> json) => ScheduleDto(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => GroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ScheduleDtoToJson(ScheduleDto instance) =>
    <String, dynamic>{'data': instance.data};

GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) => GroupDto(
  group: json['group'] as String,
  day:
      (json['day'] as List<dynamic>)
          .map((e) => DayDto.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GroupDtoToJson(GroupDto instance) => <String, dynamic>{
  'group': instance.group,
  'day': instance.day,
};

DayDto _$DayDtoFromJson(Map<String, dynamic> json) => DayDto(
  type: json['type'] as String,
  lessons:
      (json['lessons'] as List<dynamic>)
          .map(
            (e) =>
                e == null
                    ? null
                    : LessonDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$DayDtoToJson(DayDto instance) => <String, dynamic>{
  'type': instance.type,
  'lessons': instance.lessons,
};

LessonDto _$LessonDtoFromJson(Map<String, dynamic> json) => LessonDto(
  json['replacementLesson'] as String?,
  json['replacementCabinet'] as String?,
  json['replacement_teacher'] as String?,
  (json['number'] as num?)?.toInt(),
  teacher: json['teacher'] as String?,
  lesson: json['lesson'] as String?,
  cabinet: json['cabinet'] as String?,
);

Map<String, dynamic> _$LessonDtoToJson(LessonDto instance) => <String, dynamic>{
  'number': instance.number,
  'lesson': instance.lesson,
  'cabinet': instance.cabinet,
  'replacementLesson': instance.replacementLesson,
  'replacementCabinet': instance.replacementCabinet,
  'teacher': instance.teacher,
  'replacement_teacher': instance.replacementTeacher,
};
