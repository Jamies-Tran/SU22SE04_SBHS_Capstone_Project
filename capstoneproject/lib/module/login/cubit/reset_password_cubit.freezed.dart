// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reset_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ResetPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) failed,
    required TResult Function() success,
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordStateLoading value) loading,
    required TResult Function(ResetPasswordStateFailed value) failed,
    required TResult Function(ResetPasswordStateSuccess value) success,
    required TResult Function(ResetPasswordStateCompleted value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordStateCopyWith(
          ResetPasswordState value, $Res Function(ResetPasswordState) then) =
      _$ResetPasswordStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ResetPasswordStateCopyWithImpl<$Res>
    implements $ResetPasswordStateCopyWith<$Res> {
  _$ResetPasswordStateCopyWithImpl(this._value, this._then);

  final ResetPasswordState _value;
  // ignore: unused_field
  final $Res Function(ResetPasswordState) _then;
}

/// @nodoc
abstract class _$$ResetPasswordStateLoadingCopyWith<$Res> {
  factory _$$ResetPasswordStateLoadingCopyWith(
          _$ResetPasswordStateLoading value,
          $Res Function(_$ResetPasswordStateLoading) then) =
      __$$ResetPasswordStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordStateLoadingCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res>
    implements _$$ResetPasswordStateLoadingCopyWith<$Res> {
  __$$ResetPasswordStateLoadingCopyWithImpl(_$ResetPasswordStateLoading _value,
      $Res Function(_$ResetPasswordStateLoading) _then)
      : super(_value, (v) => _then(v as _$ResetPasswordStateLoading));

  @override
  _$ResetPasswordStateLoading get _value =>
      super._value as _$ResetPasswordStateLoading;
}

/// @nodoc

class _$ResetPasswordStateLoading implements ResetPasswordStateLoading {
  const _$ResetPasswordStateLoading();

  @override
  String toString() {
    return 'ResetPasswordState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) failed,
    required TResult Function() success,
    required TResult Function() completed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
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
    required TResult Function(ResetPasswordStateLoading value) loading,
    required TResult Function(ResetPasswordStateFailed value) failed,
    required TResult Function(ResetPasswordStateSuccess value) success,
    required TResult Function(ResetPasswordStateCompleted value) completed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordStateLoading implements ResetPasswordState {
  const factory ResetPasswordStateLoading() = _$ResetPasswordStateLoading;
}

/// @nodoc
abstract class _$$ResetPasswordStateFailedCopyWith<$Res> {
  factory _$$ResetPasswordStateFailedCopyWith(_$ResetPasswordStateFailed value,
          $Res Function(_$ResetPasswordStateFailed) then) =
      __$$ResetPasswordStateFailedCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$ResetPasswordStateFailedCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res>
    implements _$$ResetPasswordStateFailedCopyWith<$Res> {
  __$$ResetPasswordStateFailedCopyWithImpl(_$ResetPasswordStateFailed _value,
      $Res Function(_$ResetPasswordStateFailed) _then)
      : super(_value, (v) => _then(v as _$ResetPasswordStateFailed));

  @override
  _$ResetPasswordStateFailed get _value =>
      super._value as _$ResetPasswordStateFailed;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$ResetPasswordStateFailed(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResetPasswordStateFailed implements ResetPasswordStateFailed {
  const _$ResetPasswordStateFailed(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ResetPasswordState.failed(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordStateFailed &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$ResetPasswordStateFailedCopyWith<_$ResetPasswordStateFailed>
      get copyWith =>
          __$$ResetPasswordStateFailedCopyWithImpl<_$ResetPasswordStateFailed>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) failed,
    required TResult Function() success,
    required TResult Function() completed,
  }) {
    return failed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
  }) {
    return failed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordStateLoading value) loading,
    required TResult Function(ResetPasswordStateFailed value) failed,
    required TResult Function(ResetPasswordStateSuccess value) success,
    required TResult Function(ResetPasswordStateCompleted value) completed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordStateFailed implements ResetPasswordState {
  const factory ResetPasswordStateFailed(final String error) =
      _$ResetPasswordStateFailed;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ResetPasswordStateFailedCopyWith<_$ResetPasswordStateFailed>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetPasswordStateSuccessCopyWith<$Res> {
  factory _$$ResetPasswordStateSuccessCopyWith(
          _$ResetPasswordStateSuccess value,
          $Res Function(_$ResetPasswordStateSuccess) then) =
      __$$ResetPasswordStateSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordStateSuccessCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res>
    implements _$$ResetPasswordStateSuccessCopyWith<$Res> {
  __$$ResetPasswordStateSuccessCopyWithImpl(_$ResetPasswordStateSuccess _value,
      $Res Function(_$ResetPasswordStateSuccess) _then)
      : super(_value, (v) => _then(v as _$ResetPasswordStateSuccess));

  @override
  _$ResetPasswordStateSuccess get _value =>
      super._value as _$ResetPasswordStateSuccess;
}

/// @nodoc

class _$ResetPasswordStateSuccess implements ResetPasswordStateSuccess {
  const _$ResetPasswordStateSuccess();

  @override
  String toString() {
    return 'ResetPasswordState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordStateSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) failed,
    required TResult Function() success,
    required TResult Function() completed,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordStateLoading value) loading,
    required TResult Function(ResetPasswordStateFailed value) failed,
    required TResult Function(ResetPasswordStateSuccess value) success,
    required TResult Function(ResetPasswordStateCompleted value) completed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordStateSuccess implements ResetPasswordState {
  const factory ResetPasswordStateSuccess() = _$ResetPasswordStateSuccess;
}

/// @nodoc
abstract class _$$ResetPasswordStateCompletedCopyWith<$Res> {
  factory _$$ResetPasswordStateCompletedCopyWith(
          _$ResetPasswordStateCompleted value,
          $Res Function(_$ResetPasswordStateCompleted) then) =
      __$$ResetPasswordStateCompletedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordStateCompletedCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res>
    implements _$$ResetPasswordStateCompletedCopyWith<$Res> {
  __$$ResetPasswordStateCompletedCopyWithImpl(
      _$ResetPasswordStateCompleted _value,
      $Res Function(_$ResetPasswordStateCompleted) _then)
      : super(_value, (v) => _then(v as _$ResetPasswordStateCompleted));

  @override
  _$ResetPasswordStateCompleted get _value =>
      super._value as _$ResetPasswordStateCompleted;
}

/// @nodoc

class _$ResetPasswordStateCompleted implements ResetPasswordStateCompleted {
  const _$ResetPasswordStateCompleted();

  @override
  String toString() {
    return 'ResetPasswordState.completed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) failed,
    required TResult Function() success,
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
    TResult Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? failed,
    TResult Function()? success,
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
    required TResult Function(ResetPasswordStateLoading value) loading,
    required TResult Function(ResetPasswordStateFailed value) failed,
    required TResult Function(ResetPasswordStateSuccess value) success,
    required TResult Function(ResetPasswordStateCompleted value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordStateLoading value)? loading,
    TResult Function(ResetPasswordStateFailed value)? failed,
    TResult Function(ResetPasswordStateSuccess value)? success,
    TResult Function(ResetPasswordStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordStateCompleted implements ResetPasswordState {
  const factory ResetPasswordStateCompleted() = _$ResetPasswordStateCompleted;
}
