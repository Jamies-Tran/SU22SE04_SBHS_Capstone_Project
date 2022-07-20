// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'register_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  final RegisterState _value;
  // ignore: unused_field
  final $Res Function(RegisterState) _then;
}

/// @nodoc
abstract class _$$RegisterStateLoadingCopyWith<$Res> {
  factory _$$RegisterStateLoadingCopyWith(_$RegisterStateLoading value,
          $Res Function(_$RegisterStateLoading) then) =
      __$$RegisterStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateLoadingCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$RegisterStateLoadingCopyWith<$Res> {
  __$$RegisterStateLoadingCopyWithImpl(_$RegisterStateLoading _value,
      $Res Function(_$RegisterStateLoading) _then)
      : super(_value, (v) => _then(v as _$RegisterStateLoading));

  @override
  _$RegisterStateLoading get _value => super._value as _$RegisterStateLoading;
}

/// @nodoc

class _$RegisterStateLoading implements RegisterStateLoading {
  const _$RegisterStateLoading();

  @override
  String toString() {
    return 'RegisterState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
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
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RegisterStateLoading implements RegisterState {
  const factory RegisterStateLoading() = _$RegisterStateLoading;
}

/// @nodoc
abstract class _$$RegisterStateFailureCopyWith<$Res> {
  factory _$$RegisterStateFailureCopyWith(_$RegisterStateFailure value,
          $Res Function(_$RegisterStateFailure) then) =
      __$$RegisterStateFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$RegisterStateFailureCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$RegisterStateFailureCopyWith<$Res> {
  __$$RegisterStateFailureCopyWithImpl(_$RegisterStateFailure _value,
      $Res Function(_$RegisterStateFailure) _then)
      : super(_value, (v) => _then(v as _$RegisterStateFailure));

  @override
  _$RegisterStateFailure get _value => super._value as _$RegisterStateFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$RegisterStateFailure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterStateFailure implements RegisterStateFailure {
  const _$RegisterStateFailure(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RegisterState.failure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$RegisterStateFailureCopyWith<_$RegisterStateFailure> get copyWith =>
      __$$RegisterStateFailureCopyWithImpl<_$RegisterStateFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class RegisterStateFailure implements RegisterState {
  const factory RegisterStateFailure(final String message) =
      _$RegisterStateFailure;

  String get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$RegisterStateFailureCopyWith<_$RegisterStateFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterStateSuccessfulCopyWith<$Res> {
  factory _$$RegisterStateSuccessfulCopyWith(_$RegisterStateSuccessful value,
          $Res Function(_$RegisterStateSuccessful) then) =
      __$$RegisterStateSuccessfulCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateSuccessfulCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$RegisterStateSuccessfulCopyWith<$Res> {
  __$$RegisterStateSuccessfulCopyWithImpl(_$RegisterStateSuccessful _value,
      $Res Function(_$RegisterStateSuccessful) _then)
      : super(_value, (v) => _then(v as _$RegisterStateSuccessful));

  @override
  _$RegisterStateSuccessful get _value =>
      super._value as _$RegisterStateSuccessful;
}

/// @nodoc

class _$RegisterStateSuccessful implements RegisterStateSuccessful {
  const _$RegisterStateSuccessful();

  @override
  String toString() {
    return 'RegisterState.successful()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateSuccessful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) {
    return successful();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) {
    return successful?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class RegisterStateSuccessful implements RegisterState {
  const factory RegisterStateSuccessful() = _$RegisterStateSuccessful;
}

/// @nodoc
abstract class _$$RegisterStateOtpCopyWith<$Res> {
  factory _$$RegisterStateOtpCopyWith(
          _$RegisterStateOtp value, $Res Function(_$RegisterStateOtp) then) =
      __$$RegisterStateOtpCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateOtpCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$RegisterStateOtpCopyWith<$Res> {
  __$$RegisterStateOtpCopyWithImpl(
      _$RegisterStateOtp _value, $Res Function(_$RegisterStateOtp) _then)
      : super(_value, (v) => _then(v as _$RegisterStateOtp));

  @override
  _$RegisterStateOtp get _value => super._value as _$RegisterStateOtp;
}

/// @nodoc

class _$RegisterStateOtp implements RegisterStateOtp {
  const _$RegisterStateOtp();

  @override
  String toString() {
    return 'RegisterState.otp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterStateOtp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) {
    return otp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) {
    return otp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (otp != null) {
      return otp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) {
    return otp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) {
    return otp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (otp != null) {
      return otp(this);
    }
    return orElse();
  }
}

abstract class RegisterStateOtp implements RegisterState {
  const factory RegisterStateOtp() = _$RegisterStateOtp;
}

/// @nodoc
abstract class _$$RegisterStateCompletedCopyWith<$Res> {
  factory _$$RegisterStateCompletedCopyWith(_$RegisterStateCompleted value,
          $Res Function(_$RegisterStateCompleted) then) =
      __$$RegisterStateCompletedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateCompletedCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$RegisterStateCompletedCopyWith<$Res> {
  __$$RegisterStateCompletedCopyWithImpl(_$RegisterStateCompleted _value,
      $Res Function(_$RegisterStateCompleted) _then)
      : super(_value, (v) => _then(v as _$RegisterStateCompleted));

  @override
  _$RegisterStateCompleted get _value =>
      super._value as _$RegisterStateCompleted;
}

/// @nodoc

class _$RegisterStateCompleted implements RegisterStateCompleted {
  const _$RegisterStateCompleted();

  @override
  String toString() {
    return 'RegisterState.completed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() otp,
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? otp,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateFailure value) failure,
    required TResult Function(RegisterStateSuccessful value) successful,
    required TResult Function(RegisterStateOtp value) otp,
    required TResult Function(RegisterStateCompleted value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateFailure value)? failure,
    TResult Function(RegisterStateSuccessful value)? successful,
    TResult Function(RegisterStateOtp value)? otp,
    TResult Function(RegisterStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class RegisterStateCompleted implements RegisterState {
  const factory RegisterStateCompleted() = _$RegisterStateCompleted;
}
