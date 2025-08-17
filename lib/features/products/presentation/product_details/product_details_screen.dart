import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/core/themeing/app_colors.dart';
import 'package:valu_task/features/products/presentation/product_details/product_details_bloc.dart';
import 'package:valu_task/features/products/presentation/product_details/product_details_event.dart';
import 'package:valu_task/features/products/presentation/product_details/product_details_states.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsBloc bloc = getIt<ProductDetailsBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(FetchProductDetails(widget.productId));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.productDetailsTitle)),
        body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            return switch (state.product.status) {
              Status.initial => Center(child: Text(l10n.initializing)),
              Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              Status.success => SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((state.product.data?.image ?? "").isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          state.product.data?.image ?? "",
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.product.data?.title ?? "",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            (state.product.data?.isSaved ?? false)
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            size: 40,
                            color:
                                (state.product.data?.isSaved ?? false)
                                    ? Colors.red
                                    : null,
                          ),
                          onPressed: () {
                            bloc.add(
                              UpdateProductSaved(
                                widget.productId,
                                !(state.product.data?.isSaved ?? false),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.brandLabel}: ${state.product.data?.brand}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.priceLabel}: \$${state.product.data?.price}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.green),
                    ),
                    if ((state.product.data?.originalPrice ?? 0) >
                        (state.product.data?.price ?? 0))
                      Text(
                        '${l10n.originalPriceLabel}: \$${state.product.data?.originalPrice}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.stockLabel}: ${state.product.data?.stock}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    if ((state.product.data?.badges ?? []).isNotEmpty)
                      Wrap(
                        spacing: 8,
                        children:
                            state.product.data!.badges
                                .map((badge) => Chip(label: Text(badge)))
                                .toList(),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.ratingLabel}: ${state.product.data?.rating}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    (state.product.data?.isInCart ?? false)
                        ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.orange.withAlpha(60),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed:
                                          (state.product.data?.orderQuantity ??
                                                      0) >
                                                  0
                                              ? () {
                                                bloc.add(
                                                  UpdateProductOrderQuantity(
                                                    widget.productId,
                                                    (state
                                                                .product
                                                                .data
                                                                ?.orderQuantity ??
                                                            0) -
                                                        1,
                                                  ),
                                                );
                                              }
                                              : null,
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.orange,
                                        // Darker orange
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(4),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          '${state.product.data?.orderQuantity ?? 0}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed:
                                          (state.product.data?.stock ?? 0) >
                                                  (state
                                                          .product
                                                          .data
                                                          ?.orderQuantity ??
                                                      0)
                                              ? () {
                                                bloc.add(
                                                  UpdateProductOrderQuantity(
                                                    widget.productId,
                                                    (state
                                                                .product
                                                                .data
                                                                ?.orderQuantity ??
                                                            0) +
                                                        1,
                                                  ),
                                                );
                                              }
                                              : null,
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.orange,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${((state.product.data?.price ?? 0.0) * (state.product.data?.orderQuantity ?? 0.0)).toStringAsFixed(2)}\$',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        )
                        : FilledButton(
                          onPressed: () {
                            bloc.add(UpdateProductCart(widget.productId, true));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.addToCart,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
              Status.error => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/404 error with a landscape-rafiki.png"),
                      state.product.error!.errorMessage.toText(),
                    ],
                  ),
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}
