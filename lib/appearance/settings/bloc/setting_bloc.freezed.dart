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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Init value)?  init,TResult Function( _SetColor value)?  setColor,TResult Function( _SetFont value)?  setFont,TResult Function( _ChangeLocale value)?  changeLocale,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Init() when init != null:
return init(_that);case _SetColor() when setColor != null:
return setColor(_that);case _SetFont() when setFont != null:
return setFont(_that);case _ChangeLocale() when changeLocale != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Init value)  init,required TResult Function( _SetColor value)  setColor,required TResult Function( _SetFont value)  setFont,required TResult Function( _ChangeLocale value)  changeLocale,}){
final _that = this;
switch (_that) {
case _Init():
return init(_that);case _SetColor():
return setColor(_that);case _SetFont():
return setFont(_that);case _ChangeLocale():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Init value)?  init,TResult? Function( _SetColor value)?  setColor,TResult? Function( _SetFont value)?  setFont,TResult? Function( _ChangeLocale value)?  changeLocale,}){
final _that = this;
switch (_that) {
case _Init() when init != null:
return init(_that);case _SetColor() when setColor != null:
return setColor(_that);case _SetFont() when setFont != null:
return setFont(_that);case _ChangeLocale() when changeLocale != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function( Color color,  Color secondary)?  setColor,TResult Function( String font)?  setFont,TResult Function( BuildContext ctx,  String code)?  changeLocale,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Init() when init != null:
return init();case _SetColor() when setColor != null:
return setColor(_that.color,_that.secondary);case _SetFont() when setFont != null:
return setFont(_that.font);case _ChangeLocale() when changeLocale != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function( Color color,  Color secondary)  setColor,required TResult Function( String font)  setFont,required TResult Function( BuildContext ctx,  String code)  changeLocale,}) {final _that = this;
switch (_that) {
case _Init():
return init();case _SetColor():
return setColor(_that.color,_that.secondary);case _SetFont():
return setFont(_that.font);case _ChangeLocale():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function( Color color,  Color secondary)?  setColor,TResult? Function( String font)?  setFont,TResult? Function( BuildContext ctx,  String code)?  changeLocale,}) {final _that = this;
switch (_that) {
case _Init() when init != null:
return init();case _SetColor() when setColor != null:
return setColor(_that.color,_that.secondary);case _SetFont() when setFont != null:
return setFont(_that.font);case _ChangeLocale() when changeLocale != null:
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


class _SetColor implements SettingEvent {
  const _SetColor({required this.color, required this.secondary});
  

 final  Color color;
 final  Color secondary;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetColorCopyWith<_SetColor> get copyWith => __$SetColorCopyWithImpl<_SetColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetColor&&(identical(other.color, color) || other.color == color)&&(identical(other.secondary, secondary) || other.secondary == secondary));
}


@override
int get hashCode => Object.hash(runtimeType,color,secondary);

@override
String toString() {
  return 'SettingEvent.setColor(color: $color, secondary: $secondary)';
}


}

/// @nodoc
abstract mixin class _$SetColorCopyWith<$Res> implements $SettingEventCopyWith<$Res> {
  factory _$SetColorCopyWith(_SetColor value, $Res Function(_SetColor) _then) = __$SetColorCopyWithImpl;
@useResult
$Res call({
 Color color, Color secondary
});




}
/// @nodoc
class __$SetColorCopyWithImpl<$Res>
    implements _$SetColorCopyWith<$Res> {
  __$SetColorCopyWithImpl(this._self, this._then);

  final _SetColor _self;
  final $Res Function(_SetColor) _then;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? color = null,Object? secondary = null,}) {
  return _then(_SetColor(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc


class _SetFont implements SettingEvent {
  const _SetFont({required this.font});
  

 final  String font;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetFontCopyWith<_SetFont> get copyWith => __$SetFontCopyWithImpl<_SetFont>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetFont&&(identical(other.font, font) || other.font == font));
}


@override
int get hashCode => Object.hash(runtimeType,font);

@override
String toString() {
  return 'SettingEvent.setFont(font: $font)';
}


}

/// @nodoc
abstract mixin class _$SetFontCopyWith<$Res> implements $SettingEventCopyWith<$Res> {
  factory _$SetFontCopyWith(_SetFont value, $Res Function(_SetFont) _then) = __$SetFontCopyWithImpl;
@useResult
$Res call({
 String font
});




}
/// @nodoc
class __$SetFontCopyWithImpl<$Res>
    implements _$SetFontCopyWith<$Res> {
  __$SetFontCopyWithImpl(this._self, this._then);

  final _SetFont _self;
  final $Res Function(_SetFont) _then;

/// Create a copy of SettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? font = null,}) {
  return _then(_SetFont(
font: null == font ? _self.font : font // ignore: cast_nullable_to_non_nullable
as String,
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
