import 'package:coinio_app/data/repositories/mock_category_repository.dart';
import 'package:coinio_app/domain/usecases/categories/get_categories_usecase.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_bloc.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CategoriesBloc>(
    create:
        (final context) => CategoriesBloc(
          getCategoriesUsecase: GetCategoriesUsecase(
            repository: MockCategoryRepository(),
          ),
        ),
    child: _CategoriesPageView(),
  );
}

class _CategoriesPageView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Категории')),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Поиск',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (final query) {
              // TODO: реализовать фильтрацию списка по запросу
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (final context, final state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                final categories = state.categories;
                if (categories.isEmpty) {
                  return const Center(child: Text('Нет категорий'));
                }
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (final context, final index) {
                    final category = categories[index];
                    return ListTile(
                      title: Text(category.name),
                      subtitle:
                          category.name != null ? Text(category.name!) : null,
                      leading:
                          category.emoji != null ? Text(category.emoji) : null,
                    );
                  },
                );
              } else if (state is CategoriesError) {
                return Center(child: Text('Ошибка: ${state.error}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    ),
  );
}
