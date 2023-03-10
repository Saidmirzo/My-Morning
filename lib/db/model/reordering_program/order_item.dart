import 'package:hive/hive.dart';

part 'order_item.g.dart';

@HiveType(typeId: 200)
class OrderItem extends HiveObject {
  OrderItem(this.position, this.id);

  @HiveField(0)
  int position;
  @HiveField(1)
  String id;

  @override
  String toString() {
    return 'OrderItem{position: $position, id: $id}';
  }
}
