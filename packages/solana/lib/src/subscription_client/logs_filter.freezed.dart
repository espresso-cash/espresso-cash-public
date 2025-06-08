// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LogsFilter {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is LogsFilter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LogsFilter()';
  }
}

/// @nodoc
class $LogsFilterCopyWith<$Res> {
  $LogsFilterCopyWith(LogsFilter _, $Res Function(LogsFilter) __);
}

/// @nodoc

class LogsFilterAll implements LogsFilter {
  const LogsFilterAll();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is LogsFilterAll);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LogsFilter.all()';
  }
}

/// @nodoc

class LogsFilterAllWithVotes implements LogsFilter {
  const LogsFilterAllWithVotes();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LogsFilterAllWithVotes);
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
  const LogsFilterMentions(final List<String> pubKeys) : _pubKeys = pubKeys;

  final List<String> _pubKeys;
  List<String> get pubKeys {
    if (_pubKeys is EqualUnmodifiableListView) return _pubKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pubKeys);
  }

  /// Create a copy of LogsFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LogsFilterMentionsCopyWith<LogsFilterMentions> get copyWith =>
      _$LogsFilterMentionsCopyWithImpl<LogsFilterMentions>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogsFilterMentions &&
            const DeepCollectionEquality().equals(other._pubKeys, _pubKeys));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_pubKeys));

  @override
  String toString() {
    return 'LogsFilter.mentions(pubKeys: $pubKeys)';
  }
}

/// @nodoc
abstract mixin class $LogsFilterMentionsCopyWith<$Res> implements $LogsFilterCopyWith<$Res> {
  factory $LogsFilterMentionsCopyWith(
    LogsFilterMentions value,
    $Res Function(LogsFilterMentions) _then,
  ) = _$LogsFilterMentionsCopyWithImpl;
  @useResult
  $Res call({List<String> pubKeys});
}

/// @nodoc
class _$LogsFilterMentionsCopyWithImpl<$Res> implements $LogsFilterMentionsCopyWith<$Res> {
  _$LogsFilterMentionsCopyWithImpl(this._self, this._then);

  final LogsFilterMentions _self;
  final $Res Function(LogsFilterMentions) _then;

  /// Create a copy of LogsFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? pubKeys = null}) {
    return _then(
      LogsFilterMentions(
        null == pubKeys
            ? _self._pubKeys
            : pubKeys // ignore: cast_nullable_to_non_nullable
                as List<String>,
      ),
    );
  }
}
