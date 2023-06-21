// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogDataModelAdapter extends TypeAdapter<BlogDataModel> {
  @override
  final int typeId = 0;

  @override
  BlogDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlogDataModel(
      imageUrl: fields[0] as String,
      title: fields[1] as String,
      desc: fields[2] as String,
      userId: fields[3] as String,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlogDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
