// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'switch_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SwitchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Gender> list, String item) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SwitchStateLoading value) loading,
    required TResult Function(SwitchStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwitchStateCopyWith<$Res> {
  factory $SwitchStateCopyWith(
          SwitchState value, $Res Function(SwitchState) then) =
      _$SwitchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SwitchStateCopyWithImpl<$Res> implements $SwitchStateCopyWith<$Res> {
  _$SwitchStateCopyWithImpl(this._value, this._then);

  final SwitchState _value;
  // ignore: unused_field
  final $Res Function(SwitchState) _then;
}

/// @nodoc
abstract class _$$SwitchStateLoadingCopyWith<$Res> {
  factory _$$SwitchStateLoadingCopyWith(_$SwitchStateLoading value,
          $Res Function(_$SwitchStateLoading) then) =
      __$$SwitchStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SwitchStateLoadingCopyWithImpl<$Res>
    extends _$SwitchStateCopyWithImpl<$Res>
    implements _$$SwitchStateLoadingCopyWith<$Res> {
  __$$SwitchStateLoadingCopyWithImpl(
      _$SwitchStateLoading _value, $Res Function(_$SwitchStateLoading) _then)
      : super(_value, (v) => _then(v as _$SwitchStateLoading));

  @override
  _$SwitchStateLoading get _value => super._value as _$SwitchStateLoading;
}

/// @nodoc

class _$SwitchStateLoading implements SwitchStateLoading {
  const _$SwitchStateLoading();

  @override
  String toString() {
    return 'SwitchState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SwitchStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Gender> list, String item) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
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
    required TResult Function(SwitchStateLoading value) loading,
    required TResult Function(SwitchStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SwitchStateLoading implements SwitchState {
  const factory SwitchStateLoading() = _$SwitchStateLoading;
}

/// @nodoc
abstract class _$$SwitchStateLoadedCopyWith<$Res> {
  factory _$$SwitchStateLoadedCopyWith(
          _$SwitchStateLoaded value, $Res Function(_$SwitchStateLoaded) then) =
      __$$SwitchStateLoadedCopyWithImpl<$Res>;
  $Res call({List<Gender> list, String item});
}

/// @nodoc
class __$$SwitchStateLoadedCopyWithImpl<$Res>
    extends _$SwitchStateCopyWithImpl<$Res>
    implements _$$SwitchStateLoadedCopyWith<$Res> {
  __$$SwitchStateLoadedCopyWithImpl(
      _$SwitchStateLoaded _value, $Res Function(_$SwitchStateLoaded) _then)
      : super(_value, (v) => _then(v as _$SwitchStateLoaded));

  @override
  _$SwitchStateLoaded get _value => super._value as _$SwitchStateLoaded;

  @override
  $Res call({
    Object? list = freezed,
    Object? item = freezed,
  }) {
    return _then(_$SwitchStateLoaded(
      list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Gender>,
      item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SwitchStateLoaded implements SwitchStateLoaded {
  const _$SwitchStateLoaded(final List<Gender> list, this.item) : _list = list;

  final List<Gender> _list;
  @override
  List<Gender> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final String item;

  @override
  String toString() {
    return 'SwitchState.loaded(list: $list, item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwitchStateLoaded &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  _$$SwitchStateLoadedCopyWith<_$SwitchStateLoaded> get copyWith =>
      __$$SwitchStateLoadedCopyWithImpl<_$SwitchStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Gender> list, String item) loaded,
  }) {
    return loaded(list, item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
  }) {
    return loaded?.call(list, item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Gender> list, String item)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list, item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SwitchStateLoading value) loading,
    required TResult Function(SwitchStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SwitchStateLoading value)? loading,
    TResult Function(SwitchStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SwitchStateLoaded implements SwitchState {
  const factory SwitchStateLoaded(final List<Gender> list, final String item) =
      _$SwitchStateLoaded;

  List<Gender> get list => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SwitchStateLoadedCopyWith<_$SwitchStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
