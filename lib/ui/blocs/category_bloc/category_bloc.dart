import 'dart:async';

import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_event.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetCategoryByIdUsecase getCategoryByIdUsecase;
  final GetCategoryByTypeUsecase getCategoryByTypeUsecase;
  CategoryBloc({
    required this.getCategoriesUsecase,
    required this.getCategoryByIdUsecase,
    required this.getCategoryByTypeUsecase,
  }) : super(CategoryInitial()) {
    on<LoadCategory>(_onLoadCategory);
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategory(
    final LoadCategory event,
    final Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    try {
      final category = await getCategoryByIdUsecase(id: event.id);
      emit(CategoryLoaded(category: category));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    try {
      final isIncome = event.isIncome;

      final categories =
          isIncome != null
              ? await getCategoryByTypeUsecase(isIncome: isIncome)
              : await getCategoriesUsecase();

      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
