import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinio_app/presentation/blocs/categories_cubit.dart';
import 'package:coinio_app/presentation/widgets/centered_error_text.dart';
import 'package:coinio_app/presentation/widgets/centered_progress_indicator.dart';
import 'package:coinio_app/presentation/widgets/emoji_avatar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    context.read<CategoriesCubit>().loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Мои статьи"), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged:
                (value) => context.read<CategoriesCubit>().fuzzySearch(value),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20.0,
              ),
              filled: true,
              fillColor: Color(0xffECE6F0),
              hintText: "Найти статью",
              hintStyle: TextStyle(color: Color(0xff49454F)),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: BlocBuilder<CategoriesCubit, CategoriesStateUI>(
              builder:
                  (context, state) => switch (state) {
                    InitialState() ||
                    LoadingState() => const CenteredProgressIndicator(),
                    ErrorState() => CenteredErrorText(message: state.message),
                    LoadedState() => ListView(
                      children: [
                        for (final category in state.categories)
                          ListTile(
                            leading: EmojiAvatar(emoji: category.emoji),
                            title: Text(category.name),
                          ),
                      ],
                    ),
                  },
            ),
          ),
        ],
      ),
    );
  }
}
