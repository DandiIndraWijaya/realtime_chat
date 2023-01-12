// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageHiveAdapter extends TypeAdapter<ChatMessageHive> {
  @override
  final int typeId = 1;

  @override
  ChatMessageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageHive(
      chatUid: fields[0] as String,
      message: fields[1] as String,
      messageDate: fields[2] as String,
      messageTime: fields[3] as String,
      sentBy: fields[4] as String,
      isDeleted: fields[6] as bool,
      timestamp: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.chatUid)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.messageDate)
      ..writeByte(3)
      ..write(obj.messageTime)
      ..writeByte(4)
      ..write(obj.sentBy)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
