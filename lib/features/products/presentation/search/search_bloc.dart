import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';
import 'package:valu_task/features/products/domain/use_case/search_products_use_case.dart';
import 'package:valu_task/features/products/presentation/search/search_event.dart';
import 'package:valu_task/features/products/presentation/search/search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase searchProductsUseCase;
  final Duration _debounceDelay = Duration(
    milliseconds:
        (getIt<AppConfigProvider>().appConfiguration.searchDebounceMs ?? 1000)
            .toInt(),
  );
  String? _lastQuery;

  SearchBloc(this.searchProductsUseCase) : super(SearchState()) {
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      _lastQuery = null;
      emit(state.copyWith(products: const Results.initial()));
      return;
    }
    _lastQuery = event.query;
    await Future.delayed(_debounceDelay);
    if (_lastQuery == event.query && !emit.isDone) {
      emit(state.copyWith(products: const Results.loading()));
      final result = await searchProductsUseCase(event.query);
      if (!emit.isDone) {
        emit(state.copyWith(products: result));
      }
    }
  }
}
