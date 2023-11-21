// entity/person.dart

import 'package:floor/floor.dart';
@entity
class MenuDetailsTable {
  @primaryKey
  final int id;
  final String groupName;
  final String groupData;

  MenuDetailsTable(this.id, this.groupName, this.groupData);
}