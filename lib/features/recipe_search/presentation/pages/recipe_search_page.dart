import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_finder/features/recipe_search/presentation/bloc/recipe_search_event.dart';
import 'package:recipe_finder/features/recipe_search/presentation/bloc/recipe_search_state.dart';
import 'package:recipe_finder/features/recipe_search/presentation/widgets/recipe_list_item.dart';

import '../bloc/recipe_bloc.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchTextField(textController: _textController),
          ),
          Expanded(
            child: BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
              builder: (context, state) {
                switch (state) {
                  case RecipeSearchInitial():
                    return const Center(
                      child: Text('Hello'),
                    );
                  case RecipeSearchLoading():
                    return const Center(child: CircularProgressIndicator());
                  case RecipeSearchFailure():
                    return Center(
                      child: Text(
                        'Failed to fetch recipes: ${state.errorMessage}',
                      ),
                    );
                  case RecipeSearchSuccess():
                    if (state.recipes.isEmpty) {
                      return const Center(child: Text('No recipes found.'));
                    }
                    return MasonryGridView.builder(
                      gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeListItem(recipe: state.recipes[index]);
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        labelText: 'Enter ingredients',
        hintText: 'e.g., chicken, rice, tomatoes',
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              context.read<RecipeSearchBloc>().add(
                SearchSubmitted(_textController.text),
              );
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide( width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          context.read<RecipeSearchBloc>().add(SearchSubmitted(value));
        }
      },
    );
  }
}
