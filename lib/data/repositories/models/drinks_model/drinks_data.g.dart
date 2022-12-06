// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'drinks_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DrinksData _$$_DrinksDataFromJson(Map<String, dynamic> json) =>
    _$_DrinksData(
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((e) => Drink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DrinksDataToJson(_$_DrinksData instance) =>
    <String, dynamic>{
      'drinks': instance.drinks,
    };
