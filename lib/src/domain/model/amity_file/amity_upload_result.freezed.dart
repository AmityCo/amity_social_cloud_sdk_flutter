// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amity_upload_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AmityUploadResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AmityUploadInfo uploadInfo, CancelToken cancelToken)
        progress,
    required TResult Function(T file) complete,
    required TResult Function(AmityException error) error,
    required TResult Function() cancel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult? Function(T file)? complete,
    TResult? Function(AmityException error)? error,
    TResult? Function()? cancel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult Function(T file)? complete,
    TResult Function(AmityException error)? error,
    TResult Function()? cancel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmityUploadInProgress<T> value) progress,
    required TResult Function(AmityUploadComplete<T> value) complete,
    required TResult Function(AmityUploadError<T> value) error,
    required TResult Function(AmityUploadCancel<T> value) cancel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInProgress<T> value)? progress,
    TResult? Function(AmityUploadComplete<T> value)? complete,
    TResult? Function(AmityUploadError<T> value)? error,
    TResult? Function(AmityUploadCancel<T> value)? cancel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmityUploadInProgress<T> value)? progress,
    TResult Function(AmityUploadComplete<T> value)? complete,
    TResult Function(AmityUploadError<T> value)? error,
    TResult Function(AmityUploadCancel<T> value)? cancel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmityUploadResultCopyWith<T, $Res> {
  factory $AmityUploadResultCopyWith(AmityUploadResult<T> value,
          $Res Function(AmityUploadResult<T>) then) =
      _$AmityUploadResultCopyWithImpl<T, $Res, AmityUploadResult<T>>;
}

/// @nodoc
class _$AmityUploadResultCopyWithImpl<T, $Res,
        $Val extends AmityUploadResult<T>>
    implements $AmityUploadResultCopyWith<T, $Res> {
  _$AmityUploadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AmityUploadInProgressImplCopyWith<T, $Res> {
  factory _$$AmityUploadInProgressImplCopyWith(
          _$AmityUploadInProgressImpl<T> value,
          $Res Function(_$AmityUploadInProgressImpl<T>) then) =
      __$$AmityUploadInProgressImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AmityUploadInfo uploadInfo, CancelToken cancelToken});
}

/// @nodoc
class __$$AmityUploadInProgressImplCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res,
        _$AmityUploadInProgressImpl<T>>
    implements _$$AmityUploadInProgressImplCopyWith<T, $Res> {
  __$$AmityUploadInProgressImplCopyWithImpl(
      _$AmityUploadInProgressImpl<T> _value,
      $Res Function(_$AmityUploadInProgressImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadInfo = null,
    Object? cancelToken = null,
  }) {
    return _then(_$AmityUploadInProgressImpl<T>(
      null == uploadInfo
          ? _value.uploadInfo
          : uploadInfo // ignore: cast_nullable_to_non_nullable
              as AmityUploadInfo,
      null == cancelToken
          ? _value.cancelToken
          : cancelToken // ignore: cast_nullable_to_non_nullable
              as CancelToken,
    ));
  }
}

/// @nodoc

class _$AmityUploadInProgressImpl<T> implements AmityUploadInProgress<T> {
  const _$AmityUploadInProgressImpl(this.uploadInfo, this.cancelToken);

  @override
  final AmityUploadInfo uploadInfo;
  @override
  final CancelToken cancelToken;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.progress(uploadInfo: $uploadInfo, cancelToken: $cancelToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadInProgressImpl<T> &&
            (identical(other.uploadInfo, uploadInfo) ||
                other.uploadInfo == uploadInfo) &&
            (identical(other.cancelToken, cancelToken) ||
                other.cancelToken == cancelToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uploadInfo, cancelToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmityUploadInProgressImplCopyWith<T, _$AmityUploadInProgressImpl<T>>
      get copyWith => __$$AmityUploadInProgressImplCopyWithImpl<T,
          _$AmityUploadInProgressImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AmityUploadInfo uploadInfo, CancelToken cancelToken)
        progress,
    required TResult Function(T file) complete,
    required TResult Function(AmityException error) error,
    required TResult Function() cancel,
  }) {
    return progress(uploadInfo, cancelToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult? Function(T file)? complete,
    TResult? Function(AmityException error)? error,
    TResult? Function()? cancel,
  }) {
    return progress?.call(uploadInfo, cancelToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult Function(T file)? complete,
    TResult Function(AmityException error)? error,
    TResult Function()? cancel,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(uploadInfo, cancelToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmityUploadInProgress<T> value) progress,
    required TResult Function(AmityUploadComplete<T> value) complete,
    required TResult Function(AmityUploadError<T> value) error,
    required TResult Function(AmityUploadCancel<T> value) cancel,
  }) {
    return progress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInProgress<T> value)? progress,
    TResult? Function(AmityUploadComplete<T> value)? complete,
    TResult? Function(AmityUploadError<T> value)? error,
    TResult? Function(AmityUploadCancel<T> value)? cancel,
  }) {
    return progress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmityUploadInProgress<T> value)? progress,
    TResult Function(AmityUploadComplete<T> value)? complete,
    TResult Function(AmityUploadError<T> value)? error,
    TResult Function(AmityUploadCancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(this);
    }
    return orElse();
  }
}

abstract class AmityUploadInProgress<T> implements AmityUploadResult<T> {
  const factory AmityUploadInProgress(
          final AmityUploadInfo uploadInfo, final CancelToken cancelToken) =
      _$AmityUploadInProgressImpl<T>;

  AmityUploadInfo get uploadInfo;
  CancelToken get cancelToken;
  @JsonKey(ignore: true)
  _$$AmityUploadInProgressImplCopyWith<T, _$AmityUploadInProgressImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadCompleteImplCopyWith<T, $Res> {
  factory _$$AmityUploadCompleteImplCopyWith(_$AmityUploadCompleteImpl<T> value,
          $Res Function(_$AmityUploadCompleteImpl<T>) then) =
      __$$AmityUploadCompleteImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T file});
}

/// @nodoc
class __$$AmityUploadCompleteImplCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res,
        _$AmityUploadCompleteImpl<T>>
    implements _$$AmityUploadCompleteImplCopyWith<T, $Res> {
  __$$AmityUploadCompleteImplCopyWithImpl(_$AmityUploadCompleteImpl<T> _value,
      $Res Function(_$AmityUploadCompleteImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_$AmityUploadCompleteImpl<T>(
      freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$AmityUploadCompleteImpl<T> implements AmityUploadComplete<T> {
  const _$AmityUploadCompleteImpl(this.file);

  @override
  final T file;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.complete(file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadCompleteImpl<T> &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmityUploadCompleteImplCopyWith<T, _$AmityUploadCompleteImpl<T>>
      get copyWith => __$$AmityUploadCompleteImplCopyWithImpl<T,
          _$AmityUploadCompleteImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AmityUploadInfo uploadInfo, CancelToken cancelToken)
        progress,
    required TResult Function(T file) complete,
    required TResult Function(AmityException error) error,
    required TResult Function() cancel,
  }) {
    return complete(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult? Function(T file)? complete,
    TResult? Function(AmityException error)? error,
    TResult? Function()? cancel,
  }) {
    return complete?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult Function(T file)? complete,
    TResult Function(AmityException error)? error,
    TResult Function()? cancel,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmityUploadInProgress<T> value) progress,
    required TResult Function(AmityUploadComplete<T> value) complete,
    required TResult Function(AmityUploadError<T> value) error,
    required TResult Function(AmityUploadCancel<T> value) cancel,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInProgress<T> value)? progress,
    TResult? Function(AmityUploadComplete<T> value)? complete,
    TResult? Function(AmityUploadError<T> value)? error,
    TResult? Function(AmityUploadCancel<T> value)? cancel,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmityUploadInProgress<T> value)? progress,
    TResult Function(AmityUploadComplete<T> value)? complete,
    TResult Function(AmityUploadError<T> value)? error,
    TResult Function(AmityUploadCancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class AmityUploadComplete<T> implements AmityUploadResult<T> {
  const factory AmityUploadComplete(final T file) =
      _$AmityUploadCompleteImpl<T>;

  T get file;
  @JsonKey(ignore: true)
  _$$AmityUploadCompleteImplCopyWith<T, _$AmityUploadCompleteImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadErrorImplCopyWith<T, $Res> {
  factory _$$AmityUploadErrorImplCopyWith(_$AmityUploadErrorImpl<T> value,
          $Res Function(_$AmityUploadErrorImpl<T>) then) =
      __$$AmityUploadErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AmityException error});
}

/// @nodoc
class __$$AmityUploadErrorImplCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadErrorImpl<T>>
    implements _$$AmityUploadErrorImplCopyWith<T, $Res> {
  __$$AmityUploadErrorImplCopyWithImpl(_$AmityUploadErrorImpl<T> _value,
      $Res Function(_$AmityUploadErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$AmityUploadErrorImpl<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AmityException,
    ));
  }
}

/// @nodoc

class _$AmityUploadErrorImpl<T> implements AmityUploadError<T> {
  const _$AmityUploadErrorImpl(this.error);

  @override
  final AmityException error;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmityUploadErrorImplCopyWith<T, _$AmityUploadErrorImpl<T>> get copyWith =>
      __$$AmityUploadErrorImplCopyWithImpl<T, _$AmityUploadErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AmityUploadInfo uploadInfo, CancelToken cancelToken)
        progress,
    required TResult Function(T file) complete,
    required TResult Function(AmityException error) error,
    required TResult Function() cancel,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult? Function(T file)? complete,
    TResult? Function(AmityException error)? error,
    TResult? Function()? cancel,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult Function(T file)? complete,
    TResult Function(AmityException error)? error,
    TResult Function()? cancel,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmityUploadInProgress<T> value) progress,
    required TResult Function(AmityUploadComplete<T> value) complete,
    required TResult Function(AmityUploadError<T> value) error,
    required TResult Function(AmityUploadCancel<T> value) cancel,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInProgress<T> value)? progress,
    TResult? Function(AmityUploadComplete<T> value)? complete,
    TResult? Function(AmityUploadError<T> value)? error,
    TResult? Function(AmityUploadCancel<T> value)? cancel,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmityUploadInProgress<T> value)? progress,
    TResult Function(AmityUploadComplete<T> value)? complete,
    TResult Function(AmityUploadError<T> value)? error,
    TResult Function(AmityUploadCancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AmityUploadError<T> implements AmityUploadResult<T> {
  const factory AmityUploadError(final AmityException error) =
      _$AmityUploadErrorImpl<T>;

  AmityException get error;
  @JsonKey(ignore: true)
  _$$AmityUploadErrorImplCopyWith<T, _$AmityUploadErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadCancelImplCopyWith<T, $Res> {
  factory _$$AmityUploadCancelImplCopyWith(_$AmityUploadCancelImpl<T> value,
          $Res Function(_$AmityUploadCancelImpl<T>) then) =
      __$$AmityUploadCancelImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AmityUploadCancelImplCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadCancelImpl<T>>
    implements _$$AmityUploadCancelImplCopyWith<T, $Res> {
  __$$AmityUploadCancelImplCopyWithImpl(_$AmityUploadCancelImpl<T> _value,
      $Res Function(_$AmityUploadCancelImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AmityUploadCancelImpl<T> implements AmityUploadCancel<T> {
  const _$AmityUploadCancelImpl();

  @override
  String toString() {
    return 'AmityUploadResult<$T>.cancel()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadCancelImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AmityUploadInfo uploadInfo, CancelToken cancelToken)
        progress,
    required TResult Function(T file) complete,
    required TResult Function(AmityException error) error,
    required TResult Function() cancel,
  }) {
    return cancel();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult? Function(T file)? complete,
    TResult? Function(AmityException error)? error,
    TResult? Function()? cancel,
  }) {
    return cancel?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AmityUploadInfo uploadInfo, CancelToken cancelToken)?
        progress,
    TResult Function(T file)? complete,
    TResult Function(AmityException error)? error,
    TResult Function()? cancel,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmityUploadInProgress<T> value) progress,
    required TResult Function(AmityUploadComplete<T> value) complete,
    required TResult Function(AmityUploadError<T> value) error,
    required TResult Function(AmityUploadCancel<T> value) cancel,
  }) {
    return cancel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmityUploadInProgress<T> value)? progress,
    TResult? Function(AmityUploadComplete<T> value)? complete,
    TResult? Function(AmityUploadError<T> value)? error,
    TResult? Function(AmityUploadCancel<T> value)? cancel,
  }) {
    return cancel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmityUploadInProgress<T> value)? progress,
    TResult Function(AmityUploadComplete<T> value)? complete,
    TResult Function(AmityUploadError<T> value)? error,
    TResult Function(AmityUploadCancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(this);
    }
    return orElse();
  }
}

abstract class AmityUploadCancel<T> implements AmityUploadResult<T> {
  const factory AmityUploadCancel() = _$AmityUploadCancelImpl<T>;
}
