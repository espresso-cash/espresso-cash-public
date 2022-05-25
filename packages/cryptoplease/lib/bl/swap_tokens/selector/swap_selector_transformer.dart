part of 'swap_selector_bloc.dart';

EventTransformer<SwapSelectorEvent> debounceAmountOnly() => (events, mapper) {
      final nonDebounceStream = events.where(
        (e) => e.maybeMap(
          amountUpdated: (_) => false,
          orElse: () => true,
        ),
      );
      final debounceStream = events
          .where(
            (e) => e.maybeMap(
              amountUpdated: (_) => true,
              orElse: () => false,
            ),
          )
          .debounceTime(const Duration(milliseconds: 300));

      return MergeStream(
        [nonDebounceStream, debounceStream],
      ).asyncExpand(mapper);
    };
