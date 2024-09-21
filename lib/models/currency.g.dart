// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyModelAdapter extends TypeAdapter<CurrencyModel> {
  @override
  final int typeId = 2;

  @override
  CurrencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..code = fields[2] as String
      ..symbol = fields[3] as String
      ..symbolPosition = fields[4] as String
      ..thousandSeparator = fields[5] as String
      ..decimalSeparator = fields[6] as String
      ..decimalPlaces = fields[7] as int
      ..sample = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, CurrencyModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.symbolPosition)
      ..writeByte(5)
      ..write(obj.thousandSeparator)
      ..writeByte(6)
      ..write(obj.decimalSeparator)
      ..writeByte(7)
      ..write(obj.decimalPlaces)
      ..writeByte(8)
      ..write(obj.sample);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
