import 'dart:async';

import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/usecases/categories/get_categories_usecase.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_event.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  CategoriesBloc({required this.getCategoriesUsecase})
    : super(CategoriesLoading(categories: [])) {
    on<LoadCategories>(_onLoadCategories);
    on<SearchCategoriesByName>(_onSearchCategoriesByName);
  }

  Future<void> _onSearchCategoriesByName(
    final SearchCategoriesByName event,
    final Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading(categories: []));

    final expectedRateLevel = 10;

    final allCategories = event.categories;
    // fuzzy wuzzy realization
    final filtered =
        allCategories
            .where((final c) => ratio(event.query, c.name) > expectedRateLevel)
            .toList();
    // final filtered = allCategories;
    emit(CategoriesLoaded(categories: filtered));
  }

  Future<void> _onLoadCategories(
    final LoadCategories event,
    final Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading(categories: []));

    try {
      final categories = await getCategoriesUsecase.repository.getCategories();
      // final categories = await getCategoriesUsecase();
      // TODO use call instead of prev way
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
