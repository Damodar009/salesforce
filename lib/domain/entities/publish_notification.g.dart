// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PublishNotificationAdapter extends TypeAdapter<PublishNotification> {
  @override
  final int typeId = 14;

  @override
  PublishNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublishNotification(
      path: fields[2] as String?,
      id: fields[3] as String?,
      body: fields[4] as String?,
      title: fields[5] as String?,
      created_date: fields[1] as String?,
      notification_status: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PublishNotification obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.notification_status)
      ..writeByte(1)
      ..write(obj.created_date)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublishNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
