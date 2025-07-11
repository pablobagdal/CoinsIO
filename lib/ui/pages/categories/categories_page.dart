import 'package:coinio_app/core/utils/di.dart';
import 'package:coinio_app/data/repositories/mock_repositories/mock_category_repository.dart';
import 'package:coinio_app/data/models/category/category_model.dart';
import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_bloc.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_event.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CategoryBloc>(
    create:
        (final context) => CategoryBloc(
          getCategoriesUsecase: getIt<GetCategoriesUsecase>(),
          getCategoryByIdUsecase: getIt<GetCategoryByIdUsecase>(),
          getCategoriesByTypeUsecase: getIt<GetCategoriesByTypeUsecase>(),
        )..add(LoadCategories()),
    child: _CategoriesPageView(),
  );
}

class _CategoriesPageView extends StatefulWidget {
  @override
  State<_CategoriesPageView> createState() => _CategoriesPageViewState();
}

class _CategoriesPageViewState extends State<_CategoriesPageView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  // List<Category> allCategories = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final state = context.read<CategoryBloc>().state;
  //   if (state is CategoriesLoaded) {
  //     allCategories = state.categories;
  //     print(allCategories);
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final state = context.read<CategoryBloc>().state;
  //   if (state is CategoriesLoaded) {
  //     allCategories = state.categories;
  //     print(allCategories);
  //   }
  // }

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
            // onChanged: (final query) {
            //   // TODO: реализовать фильтрацию списка по запросу
            //   setState(() {
            //     if (query == '') {
            //       context.read<CategoryBloc>().add(LoadCategories());
            //     } else {
            //       context.read<CategoryBloc>().add(
            //         SearchCategoriesByName(
            //           categories: allCategories,
            //           query: query.trim().toLowerCase(),
            //         ),
            //       );
            //     }
            //   });
            // },
            onChanged: (value) {
              setState(() {
                _query = value.trim().toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (final context, final state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                // allCategories = state.categories;
                final categories = state.categories;
                if (categories.isEmpty) {
                  return const Center(child: Text('Нет категорий'));
                }
                final filtered =
                    _query == ''
                        ? categories
                        : categories
                            .where(
                              (c) =>
                                  c.name.toLowerCase().contains(_query) ||
                                  ratio(c.name.toLowerCase(), _query) > 70,
                            )
                            .toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (final context, final index) {
                    final category = filtered[index];
                    return ListTile(
                      title: Text(category.name),
                      subtitle:
                          category.name != null ? Text(category.name!) : null,
                      leading:
                          category.emoji != null ? Text(category.emoji) : null,
                    );
                  },
                );
              } else if (state is CategoryError) {
                return Center(child: Text('Ошибка: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    ),
  );
}
