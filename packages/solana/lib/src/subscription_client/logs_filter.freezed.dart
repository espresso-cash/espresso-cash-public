// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogsFilter {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsFilter);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsFilter()';
}


}

/// @nodoc
class $LogsFilterCopyWith<$Res>  {
$LogsFilterCopyWith(LogsFilter _, $Res Function(LogsFilter) __);
}


/// Adds pattern-matching-related methods to [LogsFilter].
extension LogsFilterPatterns on LogsFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LogsFilterAll value)?  all,TResult Function( LosgFilterAllWithVotes value)?  allWithVotes,TResult Function( LogsFilterMentions value)?  mentions,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LogsFilterAll() when all != null:
return all(_that);case LosgFilterAllWithVotes() when allWithVotes != null:
return allWithVotes(_that);case LogsFilterMentions() when mentions != null:
return mentions(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LogsFilterAll value)  all,required TResult Function( LosgFilterAllWithVotes value)  allWithVotes,required TResult Function( LogsFilterMentions value)  mentions,}){
final _that = this;
switch (_that) {
case LogsFilterAll():
return all(_that);case LosgFilterAllWithVotes():
return allWithVotes(_that);case LogsFilterMentions():
return mentions(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LogsFilterAll value)?  all,TResult? Function( LosgFilterAllWithVotes value)?  allWithVotes,TResult? Function( LogsFilterMentions value)?  mentions,}){
final _that = this;
switch (_that) {
case LogsFilterAll() when all != null:
return all(_that);case LosgFilterAllWithVotes() when allWithVotes != null:
return allWithVotes(_that);case LogsFilterMentions() when mentions != null:
return mentions(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  all,TResult Function()?  allWithVotes,TResult Function( List<String> pubKeys)?  mentions,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LogsFilterAll() when all != null:
return all();case LosgFilterAllWithVotes() when allWithVotes != null:
return allWithVotes();case LogsFilterMentions() when mentions != null:
return mentions(_that.pubKeys);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  all,required TResult Function()  allWithVotes,required TResult Function( List<String> pubKeys)  mentions,}) {final _that = this;
switch (_that) {
case LogsFilterAll():
return all();case LosgFilterAllWithVotes():
return allWithVotes();case LogsFilterMentions():
return mentions(_that.pubKeys);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  all,TResult? Function()?  allWithVotes,TResult? Function( List<String> pubKeys)?  mentions,}) {final _that = this;
switch (_that) {
case LogsFilterAll() when all != null:
return all();case LosgFilterAllWithVotes() when allWithVotes != null:
return allWithVotes();case LogsFilterMentions() when mentions != null:
return mentions(_that.pubKeys);case _:
  return null;

}
}

}

/// @nodoc


class LogsFilterAll implements LogsFilter {
  const LogsFilterAll();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsFilterAll);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsFilter.all()';
}


}




/// @nodoc


class LosgFilterAllWithVotes implements LogsFilter {
  const LosgFilterAllWithVotes();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LosgFilterAllWithVotes);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsFilter.allWithVotes()';
}


}




/// @nodoc


class LogsFilterMentions implements LogsFilter {
  const LogsFilterMentions(final  List<String> pubKeys): _pubKeys = pubKeys;
  

 final  List<String> _pubKeys;
 List<String> get pubKeys {
  if (_pubKeys is EqualUnmodifiableListView) return _pubKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pubKeys);
}


/// Create a copy of LogsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogsFilterMentionsCopyWith<LogsFilterMentions> get copyWith => _$LogsFilterMentionsCopyWithImpl<LogsFilterMentions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsFilterMentions&&const DeepCollectionEquality().equals(other._pubKeys, _pubKeys));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pubKeys));

@override
String toString() {
  return 'LogsFilter.mentions(pubKeys: $pubKeys)';
}


}

/// @nodoc
abstract mixin class $LogsFilterMentionsCopyWith<$Res> implements $LogsFilterCopyWith<$Res> {
  factory $LogsFilterMentionsCopyWith(LogsFilterMentions value, $Res Function(LogsFilterMentions) _then) = _$LogsFilterMentionsCopyWithImpl;
@useResult
$Res call({
 List<String> pubKeys
});




}
/// @nodoc
class _$LogsFilterMentionsCopyWithImpl<$Res>
    implements $LogsFilterMentionsCopyWith<$Res> {
  _$LogsFilterMentionsCopyWithImpl(this._self, this._then);

  final LogsFilterMentions _self;
  final $Res Function(LogsFilterMentions) _then;

/// Create a copy of LogsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pubKeys = null,}) {
  return _then(LogsFilterMentions(
null == pubKeys ? _self._pubKeys : pubKeys // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
