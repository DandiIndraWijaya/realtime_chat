// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatHiveAdapter extends TypeAdapter<ChatHive> {
  @override
  final int typeId = 2;

  @override
  ChatHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatHive(
      uid: fields[0] as String,
      members: (fields[1] as List).cast<String>(),
      lastMessageSent: fields[2] as String,
      isDeleted: fields[3] as bool,
      createdAt: fields[4] as int,
      updatedAt: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.members)
      ..writeByte(2)
      ..write(obj.lastMessageSent)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
