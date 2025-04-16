import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class ScheduleDto {
  final List<GroupDto> data;

  ScheduleDto({required this.data});

  factory ScheduleDto.fromJson(Map<String, dynamic> json) {
    return _$ScheduleDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ScheduleDtoToJson(this);
}

@JsonSerializable()
class GroupDto {
  final String group;
  final List<DayDto> day;

  GroupDto({required this.group, required this.day});

  factory GroupDto.fromJson(Map<String, dynamic> json) {
    return _$GroupDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GroupDtoToJson(this);
}

@JsonSerializable()
class DayDto {
  final String type;
  final List<LessonDto?> lessons;

  DayDto({required this.type, required this.lessons});

  factory DayDto.fromJson(Map<String, dynamic> json) {
    return _$DayDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DayDtoToJson(this);
}

@JsonSerializable()
class LessonDto {
  final int? number;
  final String? lesson;
  final String? cabinet;
  final String? replacementLesson;
  final String? replacementCabinet;
  final String? teacher;
  @JsonKey(name: "replacement_teacher")
  final String? replacementTeacher;

  LessonDto(
      this.replacementLesson,
      this.replacementCabinet,
      this.replacementTeacher, this.number, {
        required this.teacher,
        required this.lesson,
        required this.cabinet
      }
    );

  factory LessonDto.fromJson(Map<String, dynamic> json) {
    return _$LessonDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LessonDtoToJson(this);
}