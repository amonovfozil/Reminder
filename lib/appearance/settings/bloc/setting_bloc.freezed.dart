// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingEvent()';
}


}

/// @nodoc
class $SettingEventCopyWith<$Res>  {
$SettingEventCopyWith(SettingEvent _, $Res Function(SettingEvent) __);
}


/// Adds pattern-matching-related methods to [SettingEvent].
extension SettingEventPatterns on SettingEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Init value)?  init,TResult Function( _ChangeMode value)?  changeMode,TResult Function( _ChangeLocale value)?  changeLocale,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Init() when init != null:
return init(_that);case _ChangeMode() when changeMode != null:
return changeMode(_that);case _ChangeLocale() when changeLocale != null:
return changeLocale(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Init value)  init,required TResult Function( _ChangeMode value)  changeMode,required TResult Function( _ChangeLocale value)  changeLocale,}){
final _that = this;
switch (_that) {
case _Init():
return init(_that);case _ChangeMode():
return changeMode(_that);case _ChangeLocale():
return changeLocale(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Init value)?  init,TResult? Function( _ChangeMode value)?  changeMode,TResult? Function( _ChangeLocale value)?  changeLocale,}){
final _that = this;
switch (_that) {
case _Init() when init != null:
return init(_that);case _ChangeMode() when changeMode != null:
return changeMode(_that);case _ChangeLocale() when changeLocale != null:
return changeLocale(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function( BuildContext ctx,  ThemeMode mode)?  changeMode,TResult Function( BuildContext ctx,  String code)?  changeLocale,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Init() when init != null:
return init();case _ChangeMode() when changeMode != null:
return changeMode(_that.ctx,_that.mode);case _ChangeLocale() when changeLocale != null:
return changeLocale(_that.ctx,_that.code);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function( BuildContext ctx,  ThemeMode mode)  changeMode,required TResult Function( BuildContext ctx,  String code)  changeLocale,}) {final _that = this;
switch (_that) {
case _Init():
return init();case _ChangeMode():
return changeMode(_that.ctx,_that.mode);case _ChangeLocale():
return changeLocale(_that.ctx,_that.code);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function( BuildContext ctx,  ThemeMode mode)?  changeMode,TResult? Function( BuildContext ctx,  String code)?  changeLocale,}) {final _that = this;
switch (_that) {
case _Init() when init != null:
return init();case _ChangeMode() when changeMode != null:
return changeMode(_that.ctx,_that.mode);case _ChangeLocale() when changeLocale != null:
return changeLocale(_that.ctx,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _Init implements SettingEvent {
  const _Init();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Init);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingEvent.init()';
}


}




/// @nodoc


class _ChangeMode implements SettingEvent {
  const _ChangeMode({required this.ctx, required this.mode});
  

 final  BuildContext ctx;
 final  ThemeMode mode;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeModeCopyWith<_ChangeMode> get copyWith => __$ChangeModeCopyWithImpl<_ChangeMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeMode&&(identical(other.ctx, ctx) || other.ctx == ctx)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,ctx,mode);

@override
String toString() {
  return 'SettingEvent.changeMode(ctx: $ctx, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ChangeModeCopyWith<$Res> implements $SettingEventCopyWith<$Res> {
  factory _$ChangeModeCopyWith(_ChangeMode value, $Res Function(_ChangeMode) _then) = __$ChangeModeCopyWithImpl;
@useResult
$Res call({
 BuildContext ctx, ThemeMode mode
});




}
/// @nodoc
class __$ChangeModeCopyWithImpl<$Res>
    implements _$ChangeModeCopyWith<$Res> {
  __$ChangeModeCopyWithImpl(this._self, this._then);

  final _ChangeMode _self;
  final $Res Function(_ChangeMode) _then;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ctx = null,Object? mode = null,}) {
  return _then(_ChangeMode(
ctx: null == ctx ? _self.ctx : ctx // ignore: cast_nullable_to_non_nullable
as BuildContext,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

/// @nodoc


class _ChangeLocale implements SettingEvent {
  const _ChangeLocale({required this.ctx, required this.code});
  

 final  BuildContext ctx;
 final  String code;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeLocaleCopyWith<_ChangeLocale> get copyWith => __$ChangeLocaleCopyWithImpl<_ChangeLocale>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeLocale&&(identical(other.ctx, ctx) || other.ctx == ctx)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,ctx,code);

@override
String toString() {
  return 'SettingEvent.changeLocale(ctx: $ctx, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ChangeLocaleCopyWith<$Res> implements $SettingEventCopyWith<$Res> {
  factory _$ChangeLocaleCopyWith(_ChangeLocale value, $Res Function(_ChangeLocale) _then) = __$ChangeLocaleCopyWithImpl;
@useResult
$Res call({
 BuildContext ctx, String code
});




}
/// @nodoc
class __$ChangeLocaleCopyWithImpl<$Res>
    implements _$ChangeLocaleCopyWith<$Res> {
  __$ChangeLocaleCopyWithImpl(this._self, this._then);

  final _ChangeLocale _self;
  final $Res Function(_ChangeLocale) _then;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ctx = null,Object? code = null,}) {
  return _then(_ChangeLocale(
ctx: null == ctx ? _self.ctx : ctx // ignore: cast_nullable_to_non_nullable
as BuildContext,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
