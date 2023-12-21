import 'package:floor/floor.dart';

@entity
class OrderCreateResponseEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String resData;
  final String resId;

  // final String groupData;

  OrderCreateResponseEntity({required this.resData,required this.resId, this.id});
}
