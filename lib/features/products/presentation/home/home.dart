import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/features/products/domain/entity/category.dart';
import 'package:valu_task/features/products/domain/entity/products_response.dart';
import 'package:valu_task/features/products/presentation/home/home_bloc.dart';
import 'package:valu_task/features/products/presentation/home/home_events.dart';
import 'package:valu_task/features/products/presentation/home/home_state.dart';
import 'package:valu_task/features/products/presentation/widget/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc bloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(GetCategoriesEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocSelector<
                HomeBloc,
                HomeState,
                Results<List<Category>>?
              >(
                selector: (HomeState state) => state.categories,
                builder: (
                  BuildContext context,
                  Results<List<Category>>? state,
                ) {
                  List<Category> categories =
                      state?.data ??
                      List.filled(10, Category(id: "10", name: "test"));
                  return Skeletonizer(
                    enabled:
                        state?.status == Status.loading ||
                        state?.status == Status.initial,
                    child: DefaultTabController(
                      length: categories.length,
                      child: TabBar(
                        onTap: (index) {
                          bloc.add(
                            ChangeSelectedCategoryEvent(categories[index]),
                          );
                        },
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        padding: const EdgeInsets.all(8),
                        tabs: categories.map((e) => Tab(text: e.name)).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: BlocSelector<HomeBloc, HomeState, Results<List<String>>?>(
                selector: (HomeState state) => state.brands,
                builder: (BuildContext context, Results<List<String>>? state) {
                  List<String> brands = state?.data ?? List.filled(10, "test");
                  if (state?.status == Status.error) {
                    return const SizedBox();
                  }
                  return Skeletonizer(
                    enabled:
                        state?.status == Status.loading ||
                        state?.status == Status.initial,
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondary.withAlpha(50),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(brands[index]),
                            ),
                        itemCount: brands.length,
                        separatorBuilder:
                            (BuildContext context, int index) =>
                                const SizedBox(width: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            BlocSelector<HomeBloc, HomeState, Results<ProductsResponse>?>(
              selector: (HomeState state) => state.products,
              builder: (
                BuildContext context,
                Results<ProductsResponse>? state,
              ) {
                List<Product> products =
                    state?.data?.products ?? List.filled(10, Product());
                if (state?.status == Status.error) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        children: [
                          const Text("Error"),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () {
                              bloc.add(
                                GetProductsEvent(
                                  category:
                                      bloc.state.selectedCategory?.id ?? "",
                                  page: 1,
                                ),
                              );
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state?.status == Status.loading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (products.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Image.asset("assets/images/Empty-pana.png"),
                          ),
                          Text(AppLocalizations.of(context)!.noProductsFound),
                        ],
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == products.length && bloc.state.hasMorePages) {
                        bloc.add(
                          GetProductsEvent(
                            category: bloc.state.selectedCategory?.id ?? "",
                            page: bloc.state.currentPage + 1,
                          ),
                        );
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ProductCard(product: products[index], bloc: bloc);
                    },
                    childCount:
                        bloc.state.hasMorePages
                            ? products.length + 1
                            : products.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
