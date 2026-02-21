import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/core/utils/enums.dart';

List<SpaceModel> suggestedSpaces = [
  SpaceModel(id: '', name: 'Kitchen', houseKey: ''),
  SpaceModel(id: '', name: 'Bedroom', houseKey: ''),
  SpaceModel(id: '', name: 'Drawing Room', houseKey: ''),
  SpaceModel(id: '', name: 'Washroom', houseKey: ''),
];

final kTaskSchedule = {
  TaskSchedule.doNotRepeat: 'One Time',
  TaskSchedule.daily: 'Daily',
  TaskSchedule.alternateDays: 'Alternate Days',
  TaskSchedule.monthly: 'Monthly',
  TaskSchedule.customWeek: 'Custom Week',
};
