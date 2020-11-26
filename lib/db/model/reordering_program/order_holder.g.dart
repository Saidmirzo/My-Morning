// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderHolderAdapter extends TypeAdapter<OrderHolder> {
  @override
  final int typeId = 201;

  @override
  OrderHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderHolder(
      (fields[0] as List)?.cast<OrderItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
