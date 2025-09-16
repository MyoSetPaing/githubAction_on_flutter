import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/features/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_finder/features/recipe_search/domain/entities/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final Widget? trailing;

  const RecipeListItem({
    super.key,
    required this.recipe,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipeDetailPage(recipeId: recipe.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (recipe.usedIngredientCount > 0)
                    Row(
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'Used: ${recipe.usedIngredientCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  if (recipe.missedIngredientCount > 0)
                    const SizedBox(height: 4),
                  if (recipe.missedIngredientCount > 0)
                    Row(
                      children: [
                        const Icon(Icons.remove_circle, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          'Missing: ${recipe.missedIngredientCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  if (trailing != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: trailing!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
