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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$AmityUploadInProgressCopyWith<T, $Res> {
  factory _$$AmityUploadInProgressCopyWith(_$AmityUploadInProgress<T> value,
          $Res Function(_$AmityUploadInProgress<T>) then) =
      __$$AmityUploadInProgressCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AmityUploadInfo uploadInfo, CancelToken cancelToken});
}

/// @nodoc
class __$$AmityUploadInProgressCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadInProgress<T>>
    implements _$$AmityUploadInProgressCopyWith<T, $Res> {
  __$$AmityUploadInProgressCopyWithImpl(_$AmityUploadInProgress<T> _value,
      $Res Function(_$AmityUploadInProgress<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadInfo = null,
    Object? cancelToken = null,
  }) {
    return _then(_$AmityUploadInProgress<T>(
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

class _$AmityUploadInProgress<T> implements AmityUploadInProgress<T> {
  const _$AmityUploadInProgress(this.uploadInfo, this.cancelToken);

  @override
  final AmityUploadInfo uploadInfo;
  @override
  final CancelToken cancelToken;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.progress(uploadInfo: $uploadInfo, cancelToken: $cancelToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadInProgress<T> &&
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
  _$$AmityUploadInProgressCopyWith<T, _$AmityUploadInProgress<T>>
      get copyWith =>
          __$$AmityUploadInProgressCopyWithImpl<T, _$AmityUploadInProgress<T>>(
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
      _$AmityUploadInProgress<T>;

  AmityUploadInfo get uploadInfo;
  CancelToken get cancelToken;
  @JsonKey(ignore: true)
  _$$AmityUploadInProgressCopyWith<T, _$AmityUploadInProgress<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadCompleteCopyWith<T, $Res> {
  factory _$$AmityUploadCompleteCopyWith(_$AmityUploadComplete<T> value,
          $Res Function(_$AmityUploadComplete<T>) then) =
      __$$AmityUploadCompleteCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T file});
}

/// @nodoc
class __$$AmityUploadCompleteCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadComplete<T>>
    implements _$$AmityUploadCompleteCopyWith<T, $Res> {
  __$$AmityUploadCompleteCopyWithImpl(_$AmityUploadComplete<T> _value,
      $Res Function(_$AmityUploadComplete<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_$AmityUploadComplete<T>(
      freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$AmityUploadComplete<T> implements AmityUploadComplete<T> {
  const _$AmityUploadComplete(this.file);

  @override
  final T file;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.complete(file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadComplete<T> &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmityUploadCompleteCopyWith<T, _$AmityUploadComplete<T>> get copyWith =>
      __$$AmityUploadCompleteCopyWithImpl<T, _$AmityUploadComplete<T>>(
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
  const factory AmityUploadComplete(final T file) = _$AmityUploadComplete<T>;

  T get file;
  @JsonKey(ignore: true)
  _$$AmityUploadCompleteCopyWith<T, _$AmityUploadComplete<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadErrorCopyWith<T, $Res> {
  factory _$$AmityUploadErrorCopyWith(_$AmityUploadError<T> value,
          $Res Function(_$AmityUploadError<T>) then) =
      __$$AmityUploadErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AmityException error});
}

/// @nodoc
class __$$AmityUploadErrorCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadError<T>>
    implements _$$AmityUploadErrorCopyWith<T, $Res> {
  __$$AmityUploadErrorCopyWithImpl(
      _$AmityUploadError<T> _value, $Res Function(_$AmityUploadError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$AmityUploadError<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AmityException,
    ));
  }
}

/// @nodoc

class _$AmityUploadError<T> implements AmityUploadError<T> {
  const _$AmityUploadError(this.error);

  @override
  final AmityException error;

  @override
  String toString() {
    return 'AmityUploadResult<$T>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmityUploadError<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmityUploadErrorCopyWith<T, _$AmityUploadError<T>> get copyWith =>
      __$$AmityUploadErrorCopyWithImpl<T, _$AmityUploadError<T>>(
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
      _$AmityUploadError<T>;

  AmityException get error;
  @JsonKey(ignore: true)
  _$$AmityUploadErrorCopyWith<T, _$AmityUploadError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmityUploadCancelCopyWith<T, $Res> {
  factory _$$AmityUploadCancelCopyWith(_$AmityUploadCancel<T> value,
          $Res Function(_$AmityUploadCancel<T>) then) =
      __$$AmityUploadCancelCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AmityUploadCancelCopyWithImpl<T, $Res>
    extends _$AmityUploadResultCopyWithImpl<T, $Res, _$AmityUploadCancel<T>>
    implements _$$AmityUploadCancelCopyWith<T, $Res> {
  __$$AmityUploadCancelCopyWithImpl(_$AmityUploadCancel<T> _value,
      $Res Function(_$AmityUploadCancel<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AmityUploadCancel<T> implements AmityUploadCancel<T> {
  const _$AmityUploadCancel();

  @override
  String toString() {
    return 'AmityUploadResult<$T>.cancel()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AmityUploadCancel<T>);
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
  const factory AmityUploadCancel() = _$AmityUploadCancel<T>;
}
