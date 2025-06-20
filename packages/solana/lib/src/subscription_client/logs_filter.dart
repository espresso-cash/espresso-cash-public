import 'package:freezed_annotation/freezed_annotation.dart';

part 'logs_filter.freezed.dart';

@freezed
sealed class LogsFilter with _$LogsFilter {
  const factory LogsFilter.all() = LogsFilterAll;

  const factory LogsFilter.allWithVotes() = LogsFilterAllWithVotes;

  const factory LogsFilter.mentions(List<String> pubKeys) = LogsFilterMentions;
}
