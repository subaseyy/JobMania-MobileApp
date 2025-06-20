// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioHiveModelAdapter extends TypeAdapter<PortfolioHiveModel> {
  @override
  final int typeId = 4;

  @override
  PortfolioHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
      link: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
