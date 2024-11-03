import 'package:hive/hive.dart';

part 'hive_saved_model.g.dart';

@HiveType(typeId: 0)
class HiveSavedModel {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int trainingId;

  HiveSavedModel({
    required this.userId,
    required this.trainingId,
  });
}
