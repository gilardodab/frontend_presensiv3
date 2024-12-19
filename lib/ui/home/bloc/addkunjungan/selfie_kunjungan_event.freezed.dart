// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selfie_kunjungan_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelfieKunjunganEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String latitude, String longitude,
            String base64Image, String kunjunganId)
        checkin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Checkin value) checkin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Checkin value)? checkin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Checkin value)? checkin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfieKunjunganEventCopyWith<$Res> {
  factory $SelfieKunjunganEventCopyWith(SelfieKunjunganEvent value,
          $Res Function(SelfieKunjunganEvent) then) =
      _$SelfieKunjunganEventCopyWithImpl<$Res, SelfieKunjunganEvent>;
}

/// @nodoc
class _$SelfieKunjunganEventCopyWithImpl<$Res,
        $Val extends SelfieKunjunganEvent>
    implements $SelfieKunjunganEventCopyWith<$Res> {
  _$SelfieKunjunganEventCopyWithImpl(this._value, this._then);

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
    extends _$SelfieKunjunganEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'SelfieKunjunganEvent.started()';
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
    required TResult Function(String latitude, String longitude,
            String base64Image, String kunjunganId)
        checkin,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
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
    required TResult Function(_Checkin value) checkin,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Checkin value)? checkin,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Checkin value)? checkin,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements SelfieKunjunganEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$CheckinImplCopyWith<$Res> {
  factory _$$CheckinImplCopyWith(
          _$CheckinImpl value, $Res Function(_$CheckinImpl) then) =
      __$$CheckinImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String latitude,
      String longitude,
      String base64Image,
      String kunjunganId});
}

/// @nodoc
class __$$CheckinImplCopyWithImpl<$Res>
    extends _$SelfieKunjunganEventCopyWithImpl<$Res, _$CheckinImpl>
    implements _$$CheckinImplCopyWith<$Res> {
  __$$CheckinImplCopyWithImpl(
      _$CheckinImpl _value, $Res Function(_$CheckinImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? base64Image = null,
    Object? kunjunganId = null,
  }) {
    return _then(_$CheckinImpl(
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
      null == kunjunganId
          ? _value.kunjunganId
          : kunjunganId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckinImpl implements _Checkin {
  const _$CheckinImpl(
      this.latitude, this.longitude, this.base64Image, this.kunjunganId);

  @override
  final String latitude;
  @override
  final String longitude;
  @override
  final String base64Image;
  @override
  final String kunjunganId;

  @override
  String toString() {
    return 'SelfieKunjunganEvent.checkin(latitude: $latitude, longitude: $longitude, base64Image: $base64Image, kunjunganId: $kunjunganId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckinImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.base64Image, base64Image) ||
                other.base64Image == base64Image) &&
            (identical(other.kunjunganId, kunjunganId) ||
                other.kunjunganId == kunjunganId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, base64Image, kunjunganId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckinImplCopyWith<_$CheckinImpl> get copyWith =>
      __$$CheckinImplCopyWithImpl<_$CheckinImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String latitude, String longitude,
            String base64Image, String kunjunganId)
        checkin,
  }) {
    return checkin(latitude, longitude, base64Image, kunjunganId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
  }) {
    return checkin?.call(latitude, longitude, base64Image, kunjunganId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String latitude, String longitude, String base64Image,
            String kunjunganId)?
        checkin,
    required TResult orElse(),
  }) {
    if (checkin != null) {
      return checkin(latitude, longitude, base64Image, kunjunganId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Checkin value) checkin,
  }) {
    return checkin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Checkin value)? checkin,
  }) {
    return checkin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Checkin value)? checkin,
    required TResult orElse(),
  }) {
    if (checkin != null) {
      return checkin(this);
    }
    return orElse();
  }
}

abstract class _Checkin implements SelfieKunjunganEvent {
  const factory _Checkin(final String latitude, final String longitude,
      final String base64Image, final String kunjunganId) = _$CheckinImpl;

  String get latitude;
  String get longitude;
  String get base64Image;
  String get kunjunganId;
  @JsonKey(ignore: true)
  _$$CheckinImplCopyWith<_$CheckinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
