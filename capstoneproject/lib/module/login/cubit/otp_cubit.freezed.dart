// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'otp_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OtpState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpStateCopyWith<$Res> {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) then) =
      _$OtpStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtpStateCopyWithImpl<$Res> implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._value, this._then);

  final OtpState _value;
  // ignore: unused_field
  final $Res Function(OtpState) _then;
}

/// @nodoc
abstract class _$$OtpStateLoadingCopyWith<$Res> {
  factory _$$OtpStateLoadingCopyWith(
          _$OtpStateLoading value, $Res Function(_$OtpStateLoading) then) =
      __$$OtpStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateLoadingCopyWithImpl<$Res> extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateLoadingCopyWith<$Res> {
  __$$OtpStateLoadingCopyWithImpl(
      _$OtpStateLoading _value, $Res Function(_$OtpStateLoading) _then)
      : super(_value, (v) => _then(v as _$OtpStateLoading));

  @override
  _$OtpStateLoading get _value => super._value as _$OtpStateLoading;
}

/// @nodoc

class _$OtpStateLoading implements OtpStateLoading {
  const _$OtpStateLoading();

  @override
  String toString() {
    return 'OtpState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OtpStateLoading implements OtpState {
  const factory OtpStateLoading() = _$OtpStateLoading;
}

/// @nodoc
abstract class _$$OtpStateSendFailedCopyWith<$Res> {
  factory _$$OtpStateSendFailedCopyWith(_$OtpStateSendFailed value,
          $Res Function(_$OtpStateSendFailed) then) =
      __$$OtpStateSendFailedCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$OtpStateSendFailedCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateSendFailedCopyWith<$Res> {
  __$$OtpStateSendFailedCopyWithImpl(
      _$OtpStateSendFailed _value, $Res Function(_$OtpStateSendFailed) _then)
      : super(_value, (v) => _then(v as _$OtpStateSendFailed));

  @override
  _$OtpStateSendFailed get _value => super._value as _$OtpStateSendFailed;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$OtpStateSendFailed(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpStateSendFailed implements OtpStateSendFailed {
  const _$OtpStateSendFailed(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OtpState.sendFailed(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateSendFailed &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$OtpStateSendFailedCopyWith<_$OtpStateSendFailed> get copyWith =>
      __$$OtpStateSendFailedCopyWithImpl<_$OtpStateSendFailed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return sendFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return sendFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (sendFailed != null) {
      return sendFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return sendFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return sendFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (sendFailed != null) {
      return sendFailed(this);
    }
    return orElse();
  }
}

abstract class OtpStateSendFailed implements OtpState {
  const factory OtpStateSendFailed(final String error) = _$OtpStateSendFailed;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$OtpStateSendFailedCopyWith<_$OtpStateSendFailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpStateVerifyFailedCopyWith<$Res> {
  factory _$$OtpStateVerifyFailedCopyWith(_$OtpStateVerifyFailed value,
          $Res Function(_$OtpStateVerifyFailed) then) =
      __$$OtpStateVerifyFailedCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$OtpStateVerifyFailedCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateVerifyFailedCopyWith<$Res> {
  __$$OtpStateVerifyFailedCopyWithImpl(_$OtpStateVerifyFailed _value,
      $Res Function(_$OtpStateVerifyFailed) _then)
      : super(_value, (v) => _then(v as _$OtpStateVerifyFailed));

  @override
  _$OtpStateVerifyFailed get _value => super._value as _$OtpStateVerifyFailed;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$OtpStateVerifyFailed(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpStateVerifyFailed implements OtpStateVerifyFailed {
  const _$OtpStateVerifyFailed(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OtpState.verifyFailed(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateVerifyFailed &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$OtpStateVerifyFailedCopyWith<_$OtpStateVerifyFailed> get copyWith =>
      __$$OtpStateVerifyFailedCopyWithImpl<_$OtpStateVerifyFailed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return verifyFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return verifyFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (verifyFailed != null) {
      return verifyFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return verifyFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return verifyFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (verifyFailed != null) {
      return verifyFailed(this);
    }
    return orElse();
  }
}

abstract class OtpStateVerifyFailed implements OtpState {
  const factory OtpStateVerifyFailed(final String error) =
      _$OtpStateVerifyFailed;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$OtpStateVerifyFailedCopyWith<_$OtpStateVerifyFailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpStateSendSuccessCopyWith<$Res> {
  factory _$$OtpStateSendSuccessCopyWith(_$OtpStateSendSuccess value,
          $Res Function(_$OtpStateSendSuccess) then) =
      __$$OtpStateSendSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateSendSuccessCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateSendSuccessCopyWith<$Res> {
  __$$OtpStateSendSuccessCopyWithImpl(
      _$OtpStateSendSuccess _value, $Res Function(_$OtpStateSendSuccess) _then)
      : super(_value, (v) => _then(v as _$OtpStateSendSuccess));

  @override
  _$OtpStateSendSuccess get _value => super._value as _$OtpStateSendSuccess;
}

/// @nodoc

class _$OtpStateSendSuccess implements OtpStateSendSuccess {
  const _$OtpStateSendSuccess();

  @override
  String toString() {
    return 'OtpState.sendSuccess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpStateSendSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return sendSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return sendSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (sendSuccess != null) {
      return sendSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return sendSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return sendSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (sendSuccess != null) {
      return sendSuccess(this);
    }
    return orElse();
  }
}

abstract class OtpStateSendSuccess implements OtpState {
  const factory OtpStateSendSuccess() = _$OtpStateSendSuccess;
}

/// @nodoc
abstract class _$$OtpStateVerifySuccessCopyWith<$Res> {
  factory _$$OtpStateVerifySuccessCopyWith(_$OtpStateVerifySuccess value,
          $Res Function(_$OtpStateVerifySuccess) then) =
      __$$OtpStateVerifySuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateVerifySuccessCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateVerifySuccessCopyWith<$Res> {
  __$$OtpStateVerifySuccessCopyWithImpl(_$OtpStateVerifySuccess _value,
      $Res Function(_$OtpStateVerifySuccess) _then)
      : super(_value, (v) => _then(v as _$OtpStateVerifySuccess));

  @override
  _$OtpStateVerifySuccess get _value => super._value as _$OtpStateVerifySuccess;
}

/// @nodoc

class _$OtpStateVerifySuccess implements OtpStateVerifySuccess {
  const _$OtpStateVerifySuccess();

  @override
  String toString() {
    return 'OtpState.verifySuccess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpStateVerifySuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return verifySuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return verifySuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (verifySuccess != null) {
      return verifySuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return verifySuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return verifySuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (verifySuccess != null) {
      return verifySuccess(this);
    }
    return orElse();
  }
}

abstract class OtpStateVerifySuccess implements OtpState {
  const factory OtpStateVerifySuccess() = _$OtpStateVerifySuccess;
}

/// @nodoc
abstract class _$$OtpStateRegisterFailedCopyWith<$Res> {
  factory _$$OtpStateRegisterFailedCopyWith(_$OtpStateRegisterFailed value,
          $Res Function(_$OtpStateRegisterFailed) then) =
      __$$OtpStateRegisterFailedCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$OtpStateRegisterFailedCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateRegisterFailedCopyWith<$Res> {
  __$$OtpStateRegisterFailedCopyWithImpl(_$OtpStateRegisterFailed _value,
      $Res Function(_$OtpStateRegisterFailed) _then)
      : super(_value, (v) => _then(v as _$OtpStateRegisterFailed));

  @override
  _$OtpStateRegisterFailed get _value =>
      super._value as _$OtpStateRegisterFailed;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$OtpStateRegisterFailed(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpStateRegisterFailed implements OtpStateRegisterFailed {
  const _$OtpStateRegisterFailed(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OtpState.registerFailed(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateRegisterFailed &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$OtpStateRegisterFailedCopyWith<_$OtpStateRegisterFailed> get copyWith =>
      __$$OtpStateRegisterFailedCopyWithImpl<_$OtpStateRegisterFailed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return registerFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return registerFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (registerFailed != null) {
      return registerFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return registerFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return registerFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (registerFailed != null) {
      return registerFailed(this);
    }
    return orElse();
  }
}

abstract class OtpStateRegisterFailed implements OtpState {
  const factory OtpStateRegisterFailed(final String error) =
      _$OtpStateRegisterFailed;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$OtpStateRegisterFailedCopyWith<_$OtpStateRegisterFailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpStateRegisterSuccessCopyWith<$Res> {
  factory _$$OtpStateRegisterSuccessCopyWith(_$OtpStateRegisterSuccess value,
          $Res Function(_$OtpStateRegisterSuccess) then) =
      __$$OtpStateRegisterSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateRegisterSuccessCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateRegisterSuccessCopyWith<$Res> {
  __$$OtpStateRegisterSuccessCopyWithImpl(_$OtpStateRegisterSuccess _value,
      $Res Function(_$OtpStateRegisterSuccess) _then)
      : super(_value, (v) => _then(v as _$OtpStateRegisterSuccess));

  @override
  _$OtpStateRegisterSuccess get _value =>
      super._value as _$OtpStateRegisterSuccess;
}

/// @nodoc

class _$OtpStateRegisterSuccess implements OtpStateRegisterSuccess {
  const _$OtpStateRegisterSuccess();

  @override
  String toString() {
    return 'OtpState.registerSuccess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateRegisterSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return registerSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return registerSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return registerSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return registerSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess(this);
    }
    return orElse();
  }
}

abstract class OtpStateRegisterSuccess implements OtpState {
  const factory OtpStateRegisterSuccess() = _$OtpStateRegisterSuccess;
}

/// @nodoc
abstract class _$$OtpStateValidEmailCopyWith<$Res> {
  factory _$$OtpStateValidEmailCopyWith(_$OtpStateValidEmail value,
          $Res Function(_$OtpStateValidEmail) then) =
      __$$OtpStateValidEmailCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateValidEmailCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateValidEmailCopyWith<$Res> {
  __$$OtpStateValidEmailCopyWithImpl(
      _$OtpStateValidEmail _value, $Res Function(_$OtpStateValidEmail) _then)
      : super(_value, (v) => _then(v as _$OtpStateValidEmail));

  @override
  _$OtpStateValidEmail get _value => super._value as _$OtpStateValidEmail;
}

/// @nodoc

class _$OtpStateValidEmail implements OtpStateValidEmail {
  const _$OtpStateValidEmail();

  @override
  String toString() {
    return 'OtpState.validEmail()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpStateValidEmail);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return validEmail();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return validEmail?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (validEmail != null) {
      return validEmail();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return validEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return validEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (validEmail != null) {
      return validEmail(this);
    }
    return orElse();
  }
}

abstract class OtpStateValidEmail implements OtpState {
  const factory OtpStateValidEmail() = _$OtpStateValidEmail;
}

/// @nodoc
abstract class _$$OtpStateInValidEmailCopyWith<$Res> {
  factory _$$OtpStateInValidEmailCopyWith(_$OtpStateInValidEmail value,
          $Res Function(_$OtpStateInValidEmail) then) =
      __$$OtpStateInValidEmailCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$OtpStateInValidEmailCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateInValidEmailCopyWith<$Res> {
  __$$OtpStateInValidEmailCopyWithImpl(_$OtpStateInValidEmail _value,
      $Res Function(_$OtpStateInValidEmail) _then)
      : super(_value, (v) => _then(v as _$OtpStateInValidEmail));

  @override
  _$OtpStateInValidEmail get _value => super._value as _$OtpStateInValidEmail;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$OtpStateInValidEmail(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpStateInValidEmail implements OtpStateInValidEmail {
  const _$OtpStateInValidEmail(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OtpState.invalidEmail(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateInValidEmail &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$OtpStateInValidEmailCopyWith<_$OtpStateInValidEmail> get copyWith =>
      __$$OtpStateInValidEmailCopyWithImpl<_$OtpStateInValidEmail>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return invalidEmail(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return invalidEmail?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return invalidEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return invalidEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail(this);
    }
    return orElse();
  }
}

abstract class OtpStateInValidEmail implements OtpState {
  const factory OtpStateInValidEmail(final String error) =
      _$OtpStateInValidEmail;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$OtpStateInValidEmailCopyWith<_$OtpStateInValidEmail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpStateValidPhoneCopyWith<$Res> {
  factory _$$OtpStateValidPhoneCopyWith(_$OtpStateValidPhone value,
          $Res Function(_$OtpStateValidPhone) then) =
      __$$OtpStateValidPhoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpStateValidPhoneCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateValidPhoneCopyWith<$Res> {
  __$$OtpStateValidPhoneCopyWithImpl(
      _$OtpStateValidPhone _value, $Res Function(_$OtpStateValidPhone) _then)
      : super(_value, (v) => _then(v as _$OtpStateValidPhone));

  @override
  _$OtpStateValidPhone get _value => super._value as _$OtpStateValidPhone;
}

/// @nodoc

class _$OtpStateValidPhone implements OtpStateValidPhone {
  const _$OtpStateValidPhone();

  @override
  String toString() {
    return 'OtpState.validPhone()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpStateValidPhone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return validPhone();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return validPhone?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (validPhone != null) {
      return validPhone();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return validPhone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return validPhone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (validPhone != null) {
      return validPhone(this);
    }
    return orElse();
  }
}

abstract class OtpStateValidPhone implements OtpState {
  const factory OtpStateValidPhone() = _$OtpStateValidPhone;
}

/// @nodoc
abstract class _$$OtpStateInValidPhoneCopyWith<$Res> {
  factory _$$OtpStateInValidPhoneCopyWith(_$OtpStateInValidPhone value,
          $Res Function(_$OtpStateInValidPhone) then) =
      __$$OtpStateInValidPhoneCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$OtpStateInValidPhoneCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res>
    implements _$$OtpStateInValidPhoneCopyWith<$Res> {
  __$$OtpStateInValidPhoneCopyWithImpl(_$OtpStateInValidPhone _value,
      $Res Function(_$OtpStateInValidPhone) _then)
      : super(_value, (v) => _then(v as _$OtpStateInValidPhone));

  @override
  _$OtpStateInValidPhone get _value => super._value as _$OtpStateInValidPhone;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$OtpStateInValidPhone(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpStateInValidPhone implements OtpStateInValidPhone {
  const _$OtpStateInValidPhone(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OtpState.invalidPhone(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateInValidPhone &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$OtpStateInValidPhoneCopyWith<_$OtpStateInValidPhone> get copyWith =>
      __$$OtpStateInValidPhoneCopyWithImpl<_$OtpStateInValidPhone>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) sendFailed,
    required TResult Function(String error) verifyFailed,
    required TResult Function() sendSuccess,
    required TResult Function() verifySuccess,
    required TResult Function(String error) registerFailed,
    required TResult Function() registerSuccess,
    required TResult Function() validEmail,
    required TResult Function(String error) invalidEmail,
    required TResult Function() validPhone,
    required TResult Function(String error) invalidPhone,
  }) {
    return invalidPhone(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
  }) {
    return invalidPhone?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? sendFailed,
    TResult Function(String error)? verifyFailed,
    TResult Function()? sendSuccess,
    TResult Function()? verifySuccess,
    TResult Function(String error)? registerFailed,
    TResult Function()? registerSuccess,
    TResult Function()? validEmail,
    TResult Function(String error)? invalidEmail,
    TResult Function()? validPhone,
    TResult Function(String error)? invalidPhone,
    required TResult orElse(),
  }) {
    if (invalidPhone != null) {
      return invalidPhone(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpStateLoading value) loading,
    required TResult Function(OtpStateSendFailed value) sendFailed,
    required TResult Function(OtpStateVerifyFailed value) verifyFailed,
    required TResult Function(OtpStateSendSuccess value) sendSuccess,
    required TResult Function(OtpStateVerifySuccess value) verifySuccess,
    required TResult Function(OtpStateRegisterFailed value) registerFailed,
    required TResult Function(OtpStateRegisterSuccess value) registerSuccess,
    required TResult Function(OtpStateValidEmail value) validEmail,
    required TResult Function(OtpStateInValidEmail value) invalidEmail,
    required TResult Function(OtpStateValidPhone value) validPhone,
    required TResult Function(OtpStateInValidPhone value) invalidPhone,
  }) {
    return invalidPhone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
  }) {
    return invalidPhone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpStateLoading value)? loading,
    TResult Function(OtpStateSendFailed value)? sendFailed,
    TResult Function(OtpStateVerifyFailed value)? verifyFailed,
    TResult Function(OtpStateSendSuccess value)? sendSuccess,
    TResult Function(OtpStateVerifySuccess value)? verifySuccess,
    TResult Function(OtpStateRegisterFailed value)? registerFailed,
    TResult Function(OtpStateRegisterSuccess value)? registerSuccess,
    TResult Function(OtpStateValidEmail value)? validEmail,
    TResult Function(OtpStateInValidEmail value)? invalidEmail,
    TResult Function(OtpStateValidPhone value)? validPhone,
    TResult Function(OtpStateInValidPhone value)? invalidPhone,
    required TResult orElse(),
  }) {
    if (invalidPhone != null) {
      return invalidPhone(this);
    }
    return orElse();
  }
}

abstract class OtpStateInValidPhone implements OtpState {
  const factory OtpStateInValidPhone(final String error) =
      _$OtpStateInValidPhone;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$OtpStateInValidPhoneCopyWith<_$OtpStateInValidPhone> get copyWith =>
      throw _privateConstructorUsedError;
}
