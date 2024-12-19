// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cuti_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CutiEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CutiEventCopyWith<$Res> {
  factory $CutiEventCopyWith(CutiEvent value, $Res Function(CutiEvent) then) =
      _$CutiEventCopyWithImpl<$Res, CutiEvent>;
}

/// @nodoc
class _$CutiEventCopyWithImpl<$Res, $Val extends CutiEvent>
    implements $CutiEventCopyWith<$Res> {
  _$CutiEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchCutiEventImplCopyWith<$Res> {
  factory _$$FetchCutiEventImplCopyWith(_$FetchCutiEventImpl value,
          $Res Function(_$FetchCutiEventImpl) then) =
      __$$FetchCutiEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fromDate, String toDate});
}

/// @nodoc
class __$$FetchCutiEventImplCopyWithImpl<$Res>
    extends _$CutiEventCopyWithImpl<$Res, _$FetchCutiEventImpl>
    implements _$$FetchCutiEventImplCopyWith<$Res> {
  __$$FetchCutiEventImplCopyWithImpl(
      _$FetchCutiEventImpl _value, $Res Function(_$FetchCutiEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(_$FetchCutiEventImpl(
      null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchCutiEventImpl implements FetchCutiEvent {
  const _$FetchCutiEventImpl(this.fromDate, this.toDate);

  @override
  final String fromDate;
  @override
  final String toDate;

  @override
  String toString() {
    return 'CutiEvent.fetchCutiEvent(fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCutiEventImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromDate, toDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCutiEventImplCopyWith<_$FetchCutiEventImpl> get copyWith =>
      __$$FetchCutiEventImplCopyWithImpl<_$FetchCutiEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) {
    return fetchCutiEvent(fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) {
    return fetchCutiEvent?.call(fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (fetchCutiEvent != null) {
      return fetchCutiEvent(fromDate, toDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) {
    return fetchCutiEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) {
    return fetchCutiEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (fetchCutiEvent != null) {
      return fetchCutiEvent(this);
    }
    return orElse();
  }
}

abstract class FetchCutiEvent implements CutiEvent {
  const factory FetchCutiEvent(final String fromDate, final String toDate) =
      _$FetchCutiEventImpl;

  String get fromDate;
  String get toDate;
  @JsonKey(ignore: true)
  _$$FetchCutiEventImplCopyWith<_$FetchCutiEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchCutiEventBulanImplCopyWith<$Res> {
  factory _$$FetchCutiEventBulanImplCopyWith(_$FetchCutiEventBulanImpl value,
          $Res Function(_$FetchCutiEventBulanImpl) then) =
      __$$FetchCutiEventBulanImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchCutiEventBulanImplCopyWithImpl<$Res>
    extends _$CutiEventCopyWithImpl<$Res, _$FetchCutiEventBulanImpl>
    implements _$$FetchCutiEventBulanImplCopyWith<$Res> {
  __$$FetchCutiEventBulanImplCopyWithImpl(_$FetchCutiEventBulanImpl _value,
      $Res Function(_$FetchCutiEventBulanImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchCutiEventBulanImpl implements FetchCutiEventBulan {
  const _$FetchCutiEventBulanImpl();

  @override
  String toString() {
    return 'CutiEvent.fetchCutiEventBulan()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCutiEventBulanImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) {
    return fetchCutiEventBulan();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) {
    return fetchCutiEventBulan?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (fetchCutiEventBulan != null) {
      return fetchCutiEventBulan();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) {
    return fetchCutiEventBulan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) {
    return fetchCutiEventBulan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (fetchCutiEventBulan != null) {
      return fetchCutiEventBulan(this);
    }
    return orElse();
  }
}

abstract class FetchCutiEventBulan implements CutiEvent {
  const factory FetchCutiEventBulan() = _$FetchCutiEventBulanImpl;
}

/// @nodoc
abstract class _$$AddCutiEventImplCopyWith<$Res> {
  factory _$$AddCutiEventImplCopyWith(
          _$AddCutiEventImpl value, $Res Function(_$AddCutiEventImpl) then) =
      __$$AddCutiEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Cuti cuti});
}

/// @nodoc
class __$$AddCutiEventImplCopyWithImpl<$Res>
    extends _$CutiEventCopyWithImpl<$Res, _$AddCutiEventImpl>
    implements _$$AddCutiEventImplCopyWith<$Res> {
  __$$AddCutiEventImplCopyWithImpl(
      _$AddCutiEventImpl _value, $Res Function(_$AddCutiEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuti = null,
  }) {
    return _then(_$AddCutiEventImpl(
      null == cuti
          ? _value.cuti
          : cuti // ignore: cast_nullable_to_non_nullable
              as Cuti,
    ));
  }
}

/// @nodoc

class _$AddCutiEventImpl implements AddCutiEvent {
  const _$AddCutiEventImpl(this.cuti);

  @override
  final Cuti cuti;

  @override
  String toString() {
    return 'CutiEvent.addCutiEvent(cuti: $cuti)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCutiEventImpl &&
            (identical(other.cuti, cuti) || other.cuti == cuti));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cuti);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCutiEventImplCopyWith<_$AddCutiEventImpl> get copyWith =>
      __$$AddCutiEventImplCopyWithImpl<_$AddCutiEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) {
    return addCutiEvent(cuti);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) {
    return addCutiEvent?.call(cuti);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (addCutiEvent != null) {
      return addCutiEvent(cuti);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) {
    return addCutiEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) {
    return addCutiEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (addCutiEvent != null) {
      return addCutiEvent(this);
    }
    return orElse();
  }
}

abstract class AddCutiEvent implements CutiEvent {
  const factory AddCutiEvent(final Cuti cuti) = _$AddCutiEventImpl;

  Cuti get cuti;
  @JsonKey(ignore: true)
  _$$AddCutiEventImplCopyWith<_$AddCutiEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditCutiEventImplCopyWith<$Res> {
  factory _$$EditCutiEventImplCopyWith(
          _$EditCutiEventImpl value, $Res Function(_$EditCutiEventImpl) then) =
      __$$EditCutiEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Cuti cuti});
}

/// @nodoc
class __$$EditCutiEventImplCopyWithImpl<$Res>
    extends _$CutiEventCopyWithImpl<$Res, _$EditCutiEventImpl>
    implements _$$EditCutiEventImplCopyWith<$Res> {
  __$$EditCutiEventImplCopyWithImpl(
      _$EditCutiEventImpl _value, $Res Function(_$EditCutiEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuti = null,
  }) {
    return _then(_$EditCutiEventImpl(
      null == cuti
          ? _value.cuti
          : cuti // ignore: cast_nullable_to_non_nullable
              as Cuti,
    ));
  }
}

/// @nodoc

class _$EditCutiEventImpl implements EditCutiEvent {
  const _$EditCutiEventImpl(this.cuti);

  @override
  final Cuti cuti;

  @override
  String toString() {
    return 'CutiEvent.editCutiEvent(cuti: $cuti)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditCutiEventImpl &&
            (identical(other.cuti, cuti) || other.cuti == cuti));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cuti);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditCutiEventImplCopyWith<_$EditCutiEventImpl> get copyWith =>
      __$$EditCutiEventImplCopyWithImpl<_$EditCutiEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) {
    return editCutiEvent(cuti);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) {
    return editCutiEvent?.call(cuti);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (editCutiEvent != null) {
      return editCutiEvent(cuti);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) {
    return editCutiEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) {
    return editCutiEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (editCutiEvent != null) {
      return editCutiEvent(this);
    }
    return orElse();
  }
}

abstract class EditCutiEvent implements CutiEvent {
  const factory EditCutiEvent(final Cuti cuti) = _$EditCutiEventImpl;

  Cuti get cuti;
  @JsonKey(ignore: true)
  _$$EditCutiEventImplCopyWith<_$EditCutiEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCutiEventImplCopyWith<$Res> {
  factory _$$DeleteCutiEventImplCopyWith(_$DeleteCutiEventImpl value,
          $Res Function(_$DeleteCutiEventImpl) then) =
      __$$DeleteCutiEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Cuti cuti});
}

/// @nodoc
class __$$DeleteCutiEventImplCopyWithImpl<$Res>
    extends _$CutiEventCopyWithImpl<$Res, _$DeleteCutiEventImpl>
    implements _$$DeleteCutiEventImplCopyWith<$Res> {
  __$$DeleteCutiEventImplCopyWithImpl(
      _$DeleteCutiEventImpl _value, $Res Function(_$DeleteCutiEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuti = null,
  }) {
    return _then(_$DeleteCutiEventImpl(
      null == cuti
          ? _value.cuti
          : cuti // ignore: cast_nullable_to_non_nullable
              as Cuti,
    ));
  }
}

/// @nodoc

class _$DeleteCutiEventImpl implements DeleteCutiEvent {
  const _$DeleteCutiEventImpl(this.cuti);

  @override
  final Cuti cuti;

  @override
  String toString() {
    return 'CutiEvent.deleteCutiEvent(cuti: $cuti)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCutiEventImpl &&
            (identical(other.cuti, cuti) || other.cuti == cuti));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cuti);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCutiEventImplCopyWith<_$DeleteCutiEventImpl> get copyWith =>
      __$$DeleteCutiEventImplCopyWithImpl<_$DeleteCutiEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fromDate, String toDate) fetchCutiEvent,
    required TResult Function() fetchCutiEventBulan,
    required TResult Function(Cuti cuti) addCutiEvent,
    required TResult Function(Cuti cuti) editCutiEvent,
    required TResult Function(Cuti cuti) deleteCutiEvent,
  }) {
    return deleteCutiEvent(cuti);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult? Function()? fetchCutiEventBulan,
    TResult? Function(Cuti cuti)? addCutiEvent,
    TResult? Function(Cuti cuti)? editCutiEvent,
    TResult? Function(Cuti cuti)? deleteCutiEvent,
  }) {
    return deleteCutiEvent?.call(cuti);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fromDate, String toDate)? fetchCutiEvent,
    TResult Function()? fetchCutiEventBulan,
    TResult Function(Cuti cuti)? addCutiEvent,
    TResult Function(Cuti cuti)? editCutiEvent,
    TResult Function(Cuti cuti)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (deleteCutiEvent != null) {
      return deleteCutiEvent(cuti);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCutiEvent value) fetchCutiEvent,
    required TResult Function(FetchCutiEventBulan value) fetchCutiEventBulan,
    required TResult Function(AddCutiEvent value) addCutiEvent,
    required TResult Function(EditCutiEvent value) editCutiEvent,
    required TResult Function(DeleteCutiEvent value) deleteCutiEvent,
  }) {
    return deleteCutiEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult? Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult? Function(AddCutiEvent value)? addCutiEvent,
    TResult? Function(EditCutiEvent value)? editCutiEvent,
    TResult? Function(DeleteCutiEvent value)? deleteCutiEvent,
  }) {
    return deleteCutiEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCutiEvent value)? fetchCutiEvent,
    TResult Function(FetchCutiEventBulan value)? fetchCutiEventBulan,
    TResult Function(AddCutiEvent value)? addCutiEvent,
    TResult Function(EditCutiEvent value)? editCutiEvent,
    TResult Function(DeleteCutiEvent value)? deleteCutiEvent,
    required TResult orElse(),
  }) {
    if (deleteCutiEvent != null) {
      return deleteCutiEvent(this);
    }
    return orElse();
  }
}

abstract class DeleteCutiEvent implements CutiEvent {
  const factory DeleteCutiEvent(final Cuti cuti) = _$DeleteCutiEventImpl;

  Cuti get cuti;
  @JsonKey(ignore: true)
  _$$DeleteCutiEventImplCopyWith<_$DeleteCutiEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CutiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CutiStateCopyWith<$Res> {
  factory $CutiStateCopyWith(CutiState value, $Res Function(CutiState) then) =
      _$CutiStateCopyWithImpl<$Res, CutiState>;
}

/// @nodoc
class _$CutiStateCopyWithImpl<$Res, $Val extends CutiState>
    implements $CutiStateCopyWith<$Res> {
  _$CutiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CutiState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CutiState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CutiState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CutiState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Cuti> cuti});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuti = null,
  }) {
    return _then(_$LoadedImpl(
      null == cuti
          ? _value._cuti
          : cuti // ignore: cast_nullable_to_non_nullable
              as List<Cuti>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Cuti> cuti) : _cuti = cuti;

  final List<Cuti> _cuti;
  @override
  List<Cuti> get cuti {
    if (_cuti is EqualUnmodifiableListView) return _cuti;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cuti);
  }

  @override
  String toString() {
    return 'CutiState.loaded(cuti: $cuti)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._cuti, _cuti));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cuti));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return loaded(cuti);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return loaded?.call(cuti);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cuti);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements CutiState {
  const factory _Loaded(final List<Cuti> cuti) = _$LoadedImpl;

  List<Cuti> get cuti;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CutiState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CutiState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmptyImplCopyWith<$Res> {
  factory _$$EmptyImplCopyWith(
          _$EmptyImpl value, $Res Function(_$EmptyImpl) then) =
      __$$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EmptyImpl implements _Empty {
  const _$EmptyImpl();

  @override
  String toString() {
    return 'CutiState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements CutiState {
  const factory _Empty() = _$EmptyImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CutiState.success(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CutiState {
  const factory _Success(final String message) = _$SuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddedImplCopyWith<$Res> {
  factory _$$AddedImplCopyWith(
          _$AddedImpl value, $Res Function(_$AddedImpl) then) =
      __$$AddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddedImplCopyWithImpl<$Res>
    extends _$CutiStateCopyWithImpl<$Res, _$AddedImpl>
    implements _$$AddedImplCopyWith<$Res> {
  __$$AddedImplCopyWithImpl(
      _$AddedImpl _value, $Res Function(_$AddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddedImpl implements _Added {
  const _$AddedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CutiState.added(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddedImplCopyWith<_$AddedImpl> get copyWith =>
      __$$AddedImplCopyWithImpl<_$AddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Cuti> cuti) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
    required TResult Function(String message) success,
    required TResult Function(String message) added,
  }) {
    return added(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Cuti> cuti)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
    TResult? Function(String message)? success,
    TResult? Function(String message)? added,
  }) {
    return added?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Cuti> cuti)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    TResult Function(String message)? success,
    TResult Function(String message)? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Success value) success,
    required TResult Function(_Added value) added,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Success value)? success,
    TResult? Function(_Added value)? added,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Empty value)? empty,
    TResult Function(_Success value)? success,
    TResult Function(_Added value)? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class _Added implements CutiState {
  const factory _Added(final String message) = _$AddedImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AddedImplCopyWith<_$AddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
