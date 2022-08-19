// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'drinks_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DrinksData _$DrinksDataFromJson(Map<String, dynamic> json) {
  return _DrinksData.fromJson(json);
}

/// @nodoc
mixin _$DrinksData {
  List<Drink>? get drinks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DrinksDataCopyWith<DrinksData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinksDataCopyWith<$Res> {
  factory $DrinksDataCopyWith(
          DrinksData value, $Res Function(DrinksData) then) =
      _$DrinksDataCopyWithImpl<$Res>;
  $Res call({List<Drink>? drinks});
}

/// @nodoc
class _$DrinksDataCopyWithImpl<$Res> implements $DrinksDataCopyWith<$Res> {
  _$DrinksDataCopyWithImpl(this._value, this._then);

  final DrinksData _value;
  // ignore: unused_field
  final $Res Function(DrinksData) _then;

  @override
  $Res call({
    Object? drinks = freezed,
  }) {
    return _then(_value.copyWith(
      drinks: drinks == freezed
          ? _value.drinks
          : drinks // ignore: cast_nullable_to_non_nullable
              as List<Drink>?,
    ));
  }
}

/// @nodoc
abstract class _$$_DrinksDataCopyWith<$Res>
    implements $DrinksDataCopyWith<$Res> {
  factory _$$_DrinksDataCopyWith(
          _$_DrinksData value, $Res Function(_$_DrinksData) then) =
      __$$_DrinksDataCopyWithImpl<$Res>;
  @override
  $Res call({List<Drink>? drinks});
}

/// @nodoc
class __$$_DrinksDataCopyWithImpl<$Res> extends _$DrinksDataCopyWithImpl<$Res>
    implements _$$_DrinksDataCopyWith<$Res> {
  __$$_DrinksDataCopyWithImpl(
      _$_DrinksData _value, $Res Function(_$_DrinksData) _then)
      : super(_value, (v) => _then(v as _$_DrinksData));

  @override
  _$_DrinksData get _value => super._value as _$_DrinksData;

  @override
  $Res call({
    Object? drinks = freezed,
  }) {
    return _then(_$_DrinksData(
      drinks: drinks == freezed
          ? _value._drinks
          : drinks // ignore: cast_nullable_to_non_nullable
              as List<Drink>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DrinksData implements _DrinksData {
  _$_DrinksData({final List<Drink>? drinks}) : _drinks = drinks;

  factory _$_DrinksData.fromJson(Map<String, dynamic> json) =>
      _$$_DrinksDataFromJson(json);

  final List<Drink>? _drinks;
  @override
  List<Drink>? get drinks {
    final value = _drinks;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DrinksData(drinks: $drinks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrinksData &&
            const DeepCollectionEquality().equals(other._drinks, _drinks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_drinks));

  @JsonKey(ignore: true)
  @override
  _$$_DrinksDataCopyWith<_$_DrinksData> get copyWith =>
      __$$_DrinksDataCopyWithImpl<_$_DrinksData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DrinksDataToJson(
      this,
    );
  }
}

abstract class _DrinksData implements DrinksData {
  factory _DrinksData({final List<Drink>? drinks}) = _$_DrinksData;

  factory _DrinksData.fromJson(Map<String, dynamic> json) =
      _$_DrinksData.fromJson;

  @override
  List<Drink>? get drinks;
  @override
  @JsonKey(ignore: true)
  _$$_DrinksDataCopyWith<_$_DrinksData> get copyWith =>
      throw _privateConstructorUsedError;
}
