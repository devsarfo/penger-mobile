// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 4;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..initialBalance = fields[2] as double
      ..initialBalanceText = fields[3] as String
      ..currentBalance = fields[4] as double
      ..currentBalanceText = fields[5] as String
      ..colourCode = fields[6] as String?
      ..active = fields[7] as int
      ..currency = fields[8] as CurrencyModel
      ..accountType = fields[9] as AccountTypeModel;
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.initialBalance)
      ..writeByte(3)
      ..write(obj.initialBalanceText)
      ..writeByte(4)
      ..write(obj.currentBalance)
      ..writeByte(5)
      ..write(obj.currentBalanceText)
      ..writeByte(6)
      ..write(obj.colourCode)
      ..writeByte(7)
      ..write(obj.active)
      ..writeByte(8)
      ..write(obj.currency)
      ..writeByte(9)
      ..write(obj.accountType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
