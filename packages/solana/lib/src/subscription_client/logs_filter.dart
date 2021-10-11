import 'package:freezed_annotation/freezed_annotation.dart';

part 'logs_filter.freezed.dart';

@freezed
class LogsFilter with _$LogsFilter {
  const factory LogsFilter.all() = _LogsFilterAll;

  const factory LogsFilter.allWithVotes() = _LosgFilterAllWithVotes;

  const factory LogsFilter.mentions(List<String> pubKeys) = _LogsFilterMentions;
}
