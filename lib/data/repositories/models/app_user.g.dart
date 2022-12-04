// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      favoriteDrinks: (json['favoriteDrinks'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'favoriteDrinks': instance.favoriteDrinks,
    };
