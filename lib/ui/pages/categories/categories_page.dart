import 'package:coinio_app/data/repositories/mock_category_repository.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/usecases/categories/get_categories_usecase.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_bloc.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_event.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CategoriesBloc>(
    create:
        (final context) => CategoriesBloc(
          getCategoriesUsecase: GetCategoriesUsecase(
            repository: MockCategoryRepository(),
          ),
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
  //   final state = context.read<CategoriesBloc>().state;
  //   if (state is CategoriesLoaded) {
  //     allCategories = state.categories;
  //     print(allCategories);
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final state = context.read<CategoriesBloc>().state;
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
            //       context.read<CategoriesBloc>().add(LoadCategories());
            //     } else {
            //       context.read<CategoriesBloc>().add(
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
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (final context, final state) {
              if (state is CategoriesLoading) {
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
                        : categories.where((c) {
                          return c.name.toLowerCase().contains(_query) ||
                              ratio(c.name.toLowerCase(), _query) > 70;
                        }).toList();

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
              } else if (state is CategoriesError) {
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
