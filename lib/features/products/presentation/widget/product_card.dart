import 'package:flutter/material.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/routing/app_routes.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/presentation/home/home_bloc.dart';
import 'package:valu_task/features/products/presentation/home/home_events.dart';

class ProductCard extends StatelessWidget {
  final HomeBloc bloc;
  final Product product;

  const ProductCard({required this.product, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDiscounted = product.price < product.originalPrice;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetails,
          arguments: product.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(10),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Save Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          product.isSaved
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color: product.isSaved ? Colors.red : null,
                        ),
                        onPressed: () {
                          bloc.add(
                            UpdateProductSavedEvent(
                              product.id,
                              !product.isSaved,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Brand
                  Text(
                    product.brand,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isDiscounted) ...[
                        const SizedBox(width: 8),
                        Text(
                          '\$${product.originalPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Stock Status
                  Text(
                    product.stock > 0
                        ? AppLocalizations.of(context)!.inStock
                        : AppLocalizations.of(context)!.outOfStock,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: product.stock > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Badges
                  if (product.badges.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      children:
                          product.badges
                              .map(
                                (badge) => Chip(
                                  label: Text(
                                    badge,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: theme.colorScheme.secondary
                                      .withAlpha(10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  const SizedBox(height: 8),
                  // Cart Button
                  product.isInCart
                      ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed:
                                product.orderQuantity > 1
                                    ? () {
                                      bloc.add(
                                        UpdateProductOrderQuantityEvent(
                                          product.id,
                                          product.orderQuantity - 1,
                                        ),
                                      );
                                    }
                                    : null,
                          ),
                          Text('${product.orderQuantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed:
                                product.stock > product.orderQuantity
                                    ? () {
                                      bloc.add(
                                        UpdateProductOrderQuantityEvent(
                                          product.id,
                                          product.orderQuantity + 1,
                                        ),
                                      );
                                    }
                                    : null,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              bloc.add(
                                UpdateProductCartEvent(product.id, false),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.remove),
                          ),
                        ],
                      )
                      : FilledButton.icon(
                        icon: const Icon(Icons.add_shopping_cart),
                        label: Text(AppLocalizations.of(context)!.addToCart),
                        onPressed:
                            product.stock > 0
                                ? () {
                                  bloc.add(
                                    UpdateProductCartEvent(product.id, true),
                                  );
                                }
                                : null,
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
