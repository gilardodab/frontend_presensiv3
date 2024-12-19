// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unplankunjungan_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UnplanKunjunganEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String latitude, String longitude, String base64Image)
        unplan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image)?
        unplan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image)?
        unplan,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Unplan value) unplan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Unplan value)? unplan,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Unplan value)? unplan,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnplanKunjunganEventCopyWith<$Res> {
  factory $UnplanKunjunganEventCopyWith(UnplanKunjunganEvent value,
          $Res Function(UnplanKunjunganEvent) then) =
      _$UnplanKunjunganEventCopyWithImpl<$Res, UnplanKunjunganEvent>;
}

/// @nodoc
class _$UnplanKunjunganEventCopyWithImpl<$Res,
        $Val extends UnplanKunjunganEvent>
    implements $UnplanKunjunganEventCopyWith<$Res> {
  _$UnplanKunjunganEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$UnplanKunjunganEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'UnplanKunjunganEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String latitude, String longitude, String base64Image)
        unplan,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image)?
        unplan,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image)?
        unplan,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Unplan value) unplan,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Unplan value)? unplan,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Unplan value)? unplan,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements UnplanKunjunganEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$UnplanImplCopyWith<$Res> {
  factory _$$UnplanImplCopyWith(
          _$UnplanImpl value, $Res Function(_$UnplanImpl) then) =
      __$$UnplanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String latitude, String longitude, String base64Image});
}

/// @nodoc
class __$$UnplanImplCopyWithImpl<$Res>
    extends _$UnplanKunjunganEventCopyWithImpl<$Res, _$UnplanImpl>
    implements _$$UnplanImplCopyWith<$Res> {
  __$$UnplanImplCopyWithImpl(
      _$UnplanImpl _value, $Res Function(_$UnplanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? base64Image = null,
  }) {
    return _then(_$UnplanImpl(
      null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      null == base64Image
          ? _value.base64Image
          : base64Image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnplanImpl implements _Unplan {
  const _$UnplanImpl(this.latitude, this.longitude, this.base64Image);

  @override
  final String latitude;
  @override
  final String longitude;
  @override
  final String base64Image;

  @override
  String toString() {
    return 'UnplanKunjunganEvent.unplan(latitude: $latitude, longitude: $longitude, base64Image: $base64Image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnplanImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.base64Image, base64Image) ||
                other.base64Image == base64Image));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, base64Image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnplanImplCopyWith<_$UnplanImpl> get copyWith =>
      __$$UnplanImplCopyWithImpl<_$UnplanImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String latitude, String longitude, String base64Image)
        unplan,
  }) {
    return unplan(latitude, longitude, base64Image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image)?
        unplan,
  }) {
    return unplan?.call(latitude, longitude, base64Image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image)?
        unplan,
    required TResult orElse(),
  }) {
    if (unplan != null) {
      return unplan(latitude, longitude, base64Image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Unplan value) unplan,
  }) {
    return unplan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Unplan value)? unplan,
  }) {
    return unplan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Unplan value)? unplan,
    required TResult orElse(),
  }) {
    if (unplan != null) {
      return unplan(this);
    }
    return orElse();
  }
}

abstract class _Unplan implements UnplanKunjunganEvent {
  const factory _Unplan(final String latitude, final String longitude,
      final String base64Image) = _$UnplanImpl;

  String get latitude;
  String get longitude;
  String get base64Image;
  @JsonKey(ignore: true)
  _$$UnplanImplCopyWith<_$UnplanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
