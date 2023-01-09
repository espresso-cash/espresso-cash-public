import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import '../widgets/discover_header.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

typedef _Event = TokenSearchEvent;
typedef _State = TokenSearchState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) =>
    (events, mapper) => events.debounceTime(duration).switchMap(mapper);

@injectable
class TokenSearchBloc extends Bloc<_Event, _State> {
  TokenSearchBloc({
    required SearchRepository repository,
  })  : _repository = repository,
        super(const Flow.initial()) {
    on<_Event>(_eventHandler, transformer: debounce(_duration));
  }

  final SearchRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        textSearch: (event) => _onTextSearchRequested(event, emit),
        categorySearch: (event) => _onCategorySearchRequested(event, emit),
      );

  Future<void> _onTextSearchRequested(
    SearchTextRequest event,
    _Emitter emit,
  ) async {
    if (event.query.isEmpty) return emit(const Flow.initial());

    emit(const Flow.processing());

    final _State newState = await _repository
        .search(event.query)
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }

  Future<void> _onCategorySearchRequested(
    SearchCategoryRequest event,
    _Emitter emit,
  ) async {
    final category = event.category;

    if (category == null) return emit(const Flow.initial());

    emit(const Flow.processing());

    final _State newState = await _repository
        .category(category)
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }
}

@freezed
class TokenSearchEvent with _$TokenSearchEvent {
  const factory TokenSearchEvent.textSearch(String query) = SearchTextRequest;
  const factory TokenSearchEvent.categorySearch(CryptoCategories? category) =
      SearchCategoryRequest;
}

typedef TokenSearchState = Flow<Exception, IList<Token>>;
