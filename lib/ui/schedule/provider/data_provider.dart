import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tv_shedule/common/constants.dart';
import 'package:tv_shedule/data/repository/schedule_repository_impl.dart';
import 'package:tv_shedule/data/repository/schedule_table.dart';
import 'package:tv_shedule/data/schedule.dart';
import 'package:tv_shedule/utils/model_table.dart';
import 'package:tv_shedule/utils/result.dart';

class ScheduleViewModel extends ChangeNotifier {
  ScheduleViewModel({
    required ScheduleRepositoryImpl repository,
  }) : _repository = repository;

  final ScheduleRepositoryImpl _repository;

  String _errorText = "На западном фронте без перемен";
  String get errorText => _errorText;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ScheduleDto? _schedule;
  ScheduleDto? get schedule => _schedule;

  String defaultFilePath = AppConstants.defaultPath;

  String selectedPath = "";

  String _selectedDay = AppConstants.days[0];

  set selectedDay(String value){
    _selectedDay = value;
    notifyListeners();
  }

  String get selectedDay => _selectedDay;

  List<String> days = AppConstants.days;
  List<String> headers = AppConstants.headers;

  bool _isNetwork = false;
  set isNetwork(bool flag) => _isNetwork = flag;
  bool get isNetwork => _isNetwork;

  Future<void> onGetScheduleByNetwork() async {
    try {
      _isLoading = true;
      notifyListeners();

      var data = await _repository.onGetScheduleByNetwork();
      data.when(success: (item) async {
          _schedule = item;
        },
        failure: (error) {
          _errorText = error.toString();
      });

    } catch (e) {
      log('Error fetching items: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void onGetScheduleFromDisk() async {
    _isLoading = true;
    notifyListeners();

    String currentPath = selectedPath.isNotEmpty ? selectedPath : defaultFilePath;
    final response = await _repository.onGetScheduleFromDisk(currentPath);

    if (response is Ok<ScheduleDto>){
      _schedule = response.value;
      filterByDay(selectedDay, days.indexOf(selectedDay));
      setListSuggestions(_schedule!.data);
    }

    _isLoading = false;
    notifyListeners();
  }

  List<String> suggestion = [];
  List<ScheduleTable> dataForTable = [];

  void setListSuggestions(List<GroupDto> groupList){
    suggestion.clear();
    for (var i in groupList){
      suggestion.add(i.group);
    }
  }

  filterByDay(String sel_day, int index) {
    final data = _schedule!.data;

    List<ScheduleTable> result = [];

    List<DayDto> week = [];
    List<String> groups = [];

    // вытащили все пары в этот день
    for (var d in data){
      for (var t in d.day){
        if (t.type == sel_day){
          groups.add(d.group);
          week.add(t);
        }
      }
    }

    int m = 0;
    for(var f in week){
      for (var l in f.lessons){
        ScheduleTable item = ScheduleTable(
            groups[m],
            l?.number?.toString() ?? "-",
            l?.lesson ?? "-",
            l?.cabinet ?? "-",
            l?.teacher ?? "-",
            l?.replacementLesson ?? "-",
            l?.replacementCabinet ?? "-",
            l?.replacementTeacher ?? "-"
        );
        result.add(item);
      }
      m++;
    }
    dataForTable = result;
    filteredLessons = result;
  }

  Map<ModelOfTableHeaders, String> genMapOperation(List<ScheduleTable> data, int index) {
    var selected = data[index];

    var map = {
      const ModelOfTableHeaders("Пара", 1) : selected.number,
      const ModelOfTableHeaders("Группа", 1): selected.group,
      const ModelOfTableHeaders("Предмет", 1): selected.lesson,
      const ModelOfTableHeaders("Кабинет", 1): selected.cabinet,
      const ModelOfTableHeaders("Преподаватель", 1): selected.teacher,
      const ModelOfTableHeaders("Зам.предмет", 1): selected.replacementLesson,
      const ModelOfTableHeaders("Зам.кабинет", 1): selected.replacementCabinet,
      const ModelOfTableHeaders("Зам.преподаватель", 1): selected.replacementTeacher,
    };

    return map;
  }

  String _enteredKeyWord = "";

  set enteredKeyWord(String value){
    _enteredKeyWord = value;
    notifyListeners();
  }

  void applyFilter() {
    List<ScheduleTable> initialData = dataForTable;

    final filteredData = initialData.where((item) {
      return item.group.toString().toLowerCase()
          .contains(_enteredKeyWord.toLowerCase());
    }).toList();

    filteredLessons = List.from(filteredData);
    notifyListeners();
  }

  List<ScheduleTable> filteredLessons = [];

  void sortByNumberGroup(bool isEnable){
    if (isEnable){
      filteredLessons = dataForTable;
      filteredLessons.sort((a, b) => a.number.compareTo(b.number));
    } else {
      filteredLessons = List.from(dataForTable);
    }

    notifyListeners();
  }
}