// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pokemon_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePokemonInfoAdapter extends TypeAdapter<HivePokemonInfo> {
  @override
  final int typeId = 3;

  @override
  HivePokemonInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePokemonInfo(
      id: fields[0] as String,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      height: fields[3] as String,
      weight: fields[4] as String,
      category: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HivePokemonInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePokemonInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
