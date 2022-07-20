// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? failure,
    TResult Function()? successful,
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateFailure value) failure,
    required TResult Function(BookingStateSuccessful value) successful,
    required TResult Function(BookingStateCompleted value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
          BookingState value, $Res Function(BookingState) then) =
      _$BookingStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res> implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  final BookingState _value;
  // ignore: unused_field
  final $Res Function(BookingState) _then;
}

/// @nodoc
abstract class _$$BookingStateLoadingCopyWith<$Res> {
  factory _$$BookingStateLoadingCopyWith(_$BookingStateLoading value,
          $Res Function(_$BookingStateLoading) then) =
      __$$BookingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingStateLoadingCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res>
    implements _$$BookingStateLoadingCopyWith<$Res> {
  __$$BookingStateLoadingCopyWithImpl(
      _$BookingStateLoading _value, $Res Function(_$BookingStateLoading) _then)
      : super(_value, (v) => _then(v as _$BookingStateLoading));

  @override
  _$BookingStateLoading get _value => super._value as _$BookingStateLoading;
}

/// @nodoc

class _$BookingStateLoading implements BookingStateLoading {
  const _$BookingStateLoading();

  @override
  String toString() {
    return 'BookingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateFailure value) failure,
    required TResult Function(BookingStateSuccessful value) successful,
    required TResult Function(BookingStateCompleted value) completed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookingStateLoading implements BookingState {
  const factory BookingStateLoading() = _$BookingStateLoading;
}

/// @nodoc
abstract class _$$BookingStateFailureCopyWith<$Res> {
  factory _$$BookingStateFailureCopyWith(_$BookingStateFailure value,
          $Res Function(_$BookingStateFailure) then) =
      __$$BookingStateFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$BookingStateFailureCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res>
    implements _$$BookingStateFailureCopyWith<$Res> {
  __$$BookingStateFailureCopyWithImpl(
      _$BookingStateFailure _value, $Res Function(_$BookingStateFailure) _then)
      : super(_value, (v) => _then(v as _$BookingStateFailure));

  @override
  _$BookingStateFailure get _value => super._value as _$BookingStateFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$BookingStateFailure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookingStateFailure implements BookingStateFailure {
  const _$BookingStateFailure(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BookingState.failure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$BookingStateFailureCopyWith<_$BookingStateFailure> get copyWith =>
      __$$BookingStateFailureCopyWithImpl<_$BookingStateFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateFailure value) failure,
    required TResult Function(BookingStateSuccessful value) successful,
    required TResult Function(BookingStateCompleted value) completed,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BookingStateFailure implements BookingState {
  const factory BookingStateFailure(final String message) =
      _$BookingStateFailure;

  String get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$BookingStateFailureCopyWith<_$BookingStateFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingStateSuccessfulCopyWith<$Res> {
  factory _$$BookingStateSuccessfulCopyWith(_$BookingStateSuccessful value,
          $Res Function(_$BookingStateSuccessful) then) =
      __$$BookingStateSuccessfulCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingStateSuccessfulCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res>
    implements _$$BookingStateSuccessfulCopyWith<$Res> {
  __$$BookingStateSuccessfulCopyWithImpl(_$BookingStateSuccessful _value,
      $Res Function(_$BookingStateSuccessful) _then)
      : super(_value, (v) => _then(v as _$BookingStateSuccessful));

  @override
  _$BookingStateSuccessful get _value =>
      super._value as _$BookingStateSuccessful;
}

/// @nodoc

class _$BookingStateSuccessful implements BookingStateSuccessful {
  const _$BookingStateSuccessful();

  @override
  String toString() {
    return 'BookingState.successful()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingStateSuccessful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateFailure value) failure,
    required TResult Function(BookingStateSuccessful value) successful,
    required TResult Function(BookingStateCompleted value) completed,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class BookingStateSuccessful implements BookingState {
  const factory BookingStateSuccessful() = _$BookingStateSuccessful;
}

/// @nodoc
abstract class _$$BookingStateCompletedCopyWith<$Res> {
  factory _$$BookingStateCompletedCopyWith(_$BookingStateCompleted value,
          $Res Function(_$BookingStateCompleted) then) =
      __$$BookingStateCompletedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingStateCompletedCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res>
    implements _$$BookingStateCompletedCopyWith<$Res> {
  __$$BookingStateCompletedCopyWithImpl(_$BookingStateCompleted _value,
      $Res Function(_$BookingStateCompleted) _then)
      : super(_value, (v) => _then(v as _$BookingStateCompleted));

  @override
  _$BookingStateCompleted get _value => super._value as _$BookingStateCompleted;
}

/// @nodoc

class _$BookingStateCompleted implements BookingStateCompleted {
  const _$BookingStateCompleted();

  @override
  String toString() {
    return 'BookingState.completed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) failure,
    required TResult Function() successful,
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateFailure value) failure,
    required TResult Function(BookingStateSuccessful value) successful,
    required TResult Function(BookingStateCompleted value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateFailure value)? failure,
    TResult Function(BookingStateSuccessful value)? successful,
    TResult Function(BookingStateCompleted value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class BookingStateCompleted implements BookingState {
  const factory BookingStateCompleted() = _$BookingStateCompleted;
}
