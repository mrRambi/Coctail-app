// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'drink_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DrinkState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() drinkLoading,
    required TResult Function(String message) drinkLoadFailure,
    required TResult Function(DrinksData data) drinkLoadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DrinkLoading value) drinkLoading,
    required TResult Function(_DrinkLoadFailure value) drinkLoadFailure,
    required TResult Function(_DrinkLoadSuccess value) drinkLoadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinkStateCopyWith<$Res> {
  factory $DrinkStateCopyWith(
          DrinkState value, $Res Function(DrinkState) then) =
      _$DrinkStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$DrinkStateCopyWithImpl<$Res> implements $DrinkStateCopyWith<$Res> {
  _$DrinkStateCopyWithImpl(this._value, this._then);

  final DrinkState _value;
  // ignore: unused_field
  final $Res Function(DrinkState) _then;
}

/// @nodoc
abstract class _$$_DrinkLoadingCopyWith<$Res> {
  factory _$$_DrinkLoadingCopyWith(
          _$_DrinkLoading value, $Res Function(_$_DrinkLoading) then) =
      __$$_DrinkLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_DrinkLoadingCopyWithImpl<$Res> extends _$DrinkStateCopyWithImpl<$Res>
    implements _$$_DrinkLoadingCopyWith<$Res> {
  __$$_DrinkLoadingCopyWithImpl(
      _$_DrinkLoading _value, $Res Function(_$_DrinkLoading) _then)
      : super(_value, (v) => _then(v as _$_DrinkLoading));

  @override
  _$_DrinkLoading get _value => super._value as _$_DrinkLoading;
}

/// @nodoc

class _$_DrinkLoading implements _DrinkLoading {
  const _$_DrinkLoading();

  @override
  String toString() {
    return 'DrinkState.drinkLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_DrinkLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() drinkLoading,
    required TResult Function(String message) drinkLoadFailure,
    required TResult Function(DrinksData data) drinkLoadSuccess,
  }) {
    return drinkLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
  }) {
    return drinkLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoading != null) {
      return drinkLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DrinkLoading value) drinkLoading,
    required TResult Function(_DrinkLoadFailure value) drinkLoadFailure,
    required TResult Function(_DrinkLoadSuccess value) drinkLoadSuccess,
  }) {
    return drinkLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
  }) {
    return drinkLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoading != null) {
      return drinkLoading(this);
    }
    return orElse();
  }
}

abstract class _DrinkLoading implements DrinkState {
  const factory _DrinkLoading() = _$_DrinkLoading;
}

/// @nodoc
abstract class _$$_DrinkLoadFailureCopyWith<$Res> {
  factory _$$_DrinkLoadFailureCopyWith(
          _$_DrinkLoadFailure value, $Res Function(_$_DrinkLoadFailure) then) =
      __$$_DrinkLoadFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_DrinkLoadFailureCopyWithImpl<$Res>
    extends _$DrinkStateCopyWithImpl<$Res>
    implements _$$_DrinkLoadFailureCopyWith<$Res> {
  __$$_DrinkLoadFailureCopyWithImpl(
      _$_DrinkLoadFailure _value, $Res Function(_$_DrinkLoadFailure) _then)
      : super(_value, (v) => _then(v as _$_DrinkLoadFailure));

  @override
  _$_DrinkLoadFailure get _value => super._value as _$_DrinkLoadFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_DrinkLoadFailure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DrinkLoadFailure implements _DrinkLoadFailure {
  const _$_DrinkLoadFailure(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'DrinkState.drinkLoadFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrinkLoadFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_DrinkLoadFailureCopyWith<_$_DrinkLoadFailure> get copyWith =>
      __$$_DrinkLoadFailureCopyWithImpl<_$_DrinkLoadFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() drinkLoading,
    required TResult Function(String message) drinkLoadFailure,
    required TResult Function(DrinksData data) drinkLoadSuccess,
  }) {
    return drinkLoadFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
  }) {
    return drinkLoadFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoadFailure != null) {
      return drinkLoadFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DrinkLoading value) drinkLoading,
    required TResult Function(_DrinkLoadFailure value) drinkLoadFailure,
    required TResult Function(_DrinkLoadSuccess value) drinkLoadSuccess,
  }) {
    return drinkLoadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
  }) {
    return drinkLoadFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoadFailure != null) {
      return drinkLoadFailure(this);
    }
    return orElse();
  }
}

abstract class _DrinkLoadFailure implements DrinkState {
  const factory _DrinkLoadFailure(final String message) = _$_DrinkLoadFailure;

  String get message;
  @JsonKey(ignore: true)
  _$$_DrinkLoadFailureCopyWith<_$_DrinkLoadFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DrinkLoadSuccessCopyWith<$Res> {
  factory _$$_DrinkLoadSuccessCopyWith(
          _$_DrinkLoadSuccess value, $Res Function(_$_DrinkLoadSuccess) then) =
      __$$_DrinkLoadSuccessCopyWithImpl<$Res>;
  $Res call({DrinksData data});

  $DrinksDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_DrinkLoadSuccessCopyWithImpl<$Res>
    extends _$DrinkStateCopyWithImpl<$Res>
    implements _$$_DrinkLoadSuccessCopyWith<$Res> {
  __$$_DrinkLoadSuccessCopyWithImpl(
      _$_DrinkLoadSuccess _value, $Res Function(_$_DrinkLoadSuccess) _then)
      : super(_value, (v) => _then(v as _$_DrinkLoadSuccess));

  @override
  _$_DrinkLoadSuccess get _value => super._value as _$_DrinkLoadSuccess;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_DrinkLoadSuccess(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DrinksData,
    ));
  }

  @override
  $DrinksDataCopyWith<$Res> get data {
    return $DrinksDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$_DrinkLoadSuccess implements _DrinkLoadSuccess {
  const _$_DrinkLoadSuccess(this.data);

  @override
  final DrinksData data;

  @override
  String toString() {
    return 'DrinkState.drinkLoadSuccess(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrinkLoadSuccess &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_DrinkLoadSuccessCopyWith<_$_DrinkLoadSuccess> get copyWith =>
      __$$_DrinkLoadSuccessCopyWithImpl<_$_DrinkLoadSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() drinkLoading,
    required TResult Function(String message) drinkLoadFailure,
    required TResult Function(DrinksData data) drinkLoadSuccess,
  }) {
    return drinkLoadSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
  }) {
    return drinkLoadSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? drinkLoading,
    TResult Function(String message)? drinkLoadFailure,
    TResult Function(DrinksData data)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoadSuccess != null) {
      return drinkLoadSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DrinkLoading value) drinkLoading,
    required TResult Function(_DrinkLoadFailure value) drinkLoadFailure,
    required TResult Function(_DrinkLoadSuccess value) drinkLoadSuccess,
  }) {
    return drinkLoadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
  }) {
    return drinkLoadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DrinkLoading value)? drinkLoading,
    TResult Function(_DrinkLoadFailure value)? drinkLoadFailure,
    TResult Function(_DrinkLoadSuccess value)? drinkLoadSuccess,
    required TResult orElse(),
  }) {
    if (drinkLoadSuccess != null) {
      return drinkLoadSuccess(this);
    }
    return orElse();
  }
}

abstract class _DrinkLoadSuccess implements DrinkState {
  const factory _DrinkLoadSuccess(final DrinksData data) = _$_DrinkLoadSuccess;

  DrinksData get data;
  @JsonKey(ignore: true)
  _$$_DrinkLoadSuccessCopyWith<_$_DrinkLoadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
