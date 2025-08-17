import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/core/themeing/app_colors.dart';
import 'package:valu_task/features/checkout/presentation/cart/cart_bloc.dart';
import 'package:valu_task/features/checkout/presentation/cart/cart_events.dart';
import 'package:valu_task/features/checkout/presentation/cart/cart_states.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc bloc = getIt<CartBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(const FetchCartProducts());
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
        appBar: AppBar(title: Text(l10n.cartTitle)),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state.purchase.status == Status.success) {
              Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.purchaseSuccess,
              );
            } else if (state.purchase.status == Status.error) {
              Fluttertoast.showToast(
                msg: state.purchase.error!.errorMessage.message,
              );
            }
          },
          builder: (context, state) {
            return switch (state.products.status) {
              Status.initial => Center(child: Text(l10n.initializing)),
              Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              Status.success =>
                state.products.data!.isEmpty
                    ? Center(child: Text(l10n.emptyCart))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: state.products.data!.length,
                      itemBuilder: (context, index) {
                        final product = state.products.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.image,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 80,
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${l10n.priceLabel}: \$${product.updatePrice ?? product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.green),
                                      ),
                                      Text(
                                        product.stock == 0
                                            ? l10n.outOfStock
                                            : '${l10n.stockLabel}: ${product.stock}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall!.copyWith(
                                          color:
                                              product.stock <
                                                      product.orderQuantity
                                                  ? AppColors.red
                                                  : AppColors.gray,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.orange.withAlpha(
                                                60,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                      product.orderQuantity > 0
                                                          ? () {
                                                            bloc.add(
                                                              UpdateCartProductQuantity(
                                                                product.id,
                                                                product.orderQuantity -
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
                                                    backgroundColor:
                                                        AppColors.orange,
                                                    shape: const CircleBorder(),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                      ),
                                                  child: Text(
                                                    '${product.orderQuantity}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed:
                                                      (product.stock) >
                                                              product
                                                                  .orderQuantity
                                                          ? () {
                                                            bloc.add(
                                                              UpdateCartProductQuantity(
                                                                product.id,
                                                                product.orderQuantity +
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
                                                    backgroundColor:
                                                        AppColors.orange,
                                                    shape: const CircleBorder(),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '\$${((product.updatePrice ?? product.price) * product.orderQuantity).toStringAsFixed(2)}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    bloc.add(RemoveProductFromCart(product.id));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              Status.error => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/404 error with a landscape-rafiki.png",
                      ),
                      state.products.error!.errorMessage.toText(),
                    ],
                  ),
                ),
              ),
            };
          },
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.products.status == Status.success &&
                state.products.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.subtotal}:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '\$${state.subtotal.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    if (state.discount > 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${l10n.discount}:',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.green),
                          ),
                          Text(
                            '-\$${state.discount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.tax}:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '\$${state.tax.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.deliveryFee}:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          state.subtotal >= bloc.freeDeliveryThreshold
                              ? l10n.free
                              : '\$${bloc.deliveryFee.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.total}:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '\$${state.total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            bloc.add(const SaveAllForLater());
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.orange),
                          ),
                          child: Text(
                            l10n.saveForLater,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: AppColors.orange,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            bloc.add(const CheckoutEvent());
                          },
                          child: Text(l10n.checkout),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
