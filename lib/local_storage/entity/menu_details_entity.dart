import 'package:floor/floor.dart';

@entity
class MenuDetailsEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String groupName;
  final String groupData;

  MenuDetailsEntity({required this.groupName, required this.groupData});
}
