// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatorEvent()';
}


}

/// @nodoc
class $CreatorEventCopyWith<$Res>  {
$CreatorEventCopyWith(CreatorEvent _, $Res Function(CreatorEvent) __);
}


/// Adds pattern-matching-related methods to [CreatorEvent].
extension CreatorEventPatterns on CreatorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _UpdateData value)?  updateData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UpdateData() when updateData != null:
return updateData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _UpdateData value)  updateData,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _UpdateData():
return updateData(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _UpdateData value)?  updateData,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UpdateData() when updateData != null:
return updateData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( RemindModel data)?  updateData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UpdateData() when updateData != null:
return updateData(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( RemindModel data)  updateData,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _UpdateData():
return updateData(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( RemindModel data)?  updateData,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UpdateData() when updateData != null:
return updateData(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CreatorEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatorEvent.started()';
}


}




/// @nodoc


class _UpdateData implements CreatorEvent {
  const _UpdateData({required this.data});
  

 final  RemindModel data;

/// Create a copy of CreatorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDataCopyWith<_UpdateData> get copyWith => __$UpdateDataCopyWithImpl<_UpdateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateData&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CreatorEvent.updateData(data: $data)';
}


}

/// @nodoc
abstract mixin class _$UpdateDataCopyWith<$Res> implements $CreatorEventCopyWith<$Res> {
  factory _$UpdateDataCopyWith(_UpdateData value, $Res Function(_UpdateData) _then) = __$UpdateDataCopyWithImpl;
@useResult
$Res call({
 RemindModel data
});




}
/// @nodoc
class __$UpdateDataCopyWithImpl<$Res>
    implements _$UpdateDataCopyWith<$Res> {
  __$UpdateDataCopyWithImpl(this._self, this._then);

  final _UpdateData _self;
  final $Res Function(_UpdateData) _then;

/// Create a copy of CreatorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_UpdateData(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RemindModel,
  ));
}


}

// dart format on
