// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountTypeModelAdapter extends TypeAdapter<AccountTypeModel> {
  @override
  final int typeId = 3;

  @override
  AccountTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountTypeModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..code = fields[2] as String
      ..description = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, AccountTypeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
