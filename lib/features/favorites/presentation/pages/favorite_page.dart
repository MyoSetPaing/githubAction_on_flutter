import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_event.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorite_state.dart';
import '../widgets/favorite_list_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteStatus) {
            context.read<FavoriteBloc>().add(LoadFavorites());
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesLoaded) {
            if (state.recipes.isEmpty) {
              return const Center(
                child: Text('You have no favorite recipes yet.'),
              );
            }
            return ListView.builder(
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                final recipe = state.recipes[index];
                return FavoriteListItem(
                  recipe: recipe,
                );
              },
            );
          }
          if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
            child: Text('Your favorite recipes will appear here.'),
          );
        },
      ),
    );
  }
}
