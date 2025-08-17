import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/core/routing/app_routes.dart';
import 'package:valu_task/features/products/presentation/search/search_bloc.dart';
import 'package:valu_task/features/products/presentation/search/search_event.dart';
import 'package:valu_task/features/products/presentation/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final SearchBloc bloc = getIt<SearchBloc>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  bloc.add(const SearchProducts(''));
                },
              ),
            ),
            onChanged: (value) {
              bloc.add(SearchProducts(value.trim()));
            },
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return switch (state.products.status) {
              Status.initial => Center(child: Text(l10n.searchInitial)),
              Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              Status.success =>
                state.products.data!.isEmpty
                    ? Center(child: Text(l10n.noResults))
                    : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: state.products.data!.length,
                      itemBuilder: (context, index) {
                        final product = state.products.data![index];
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.productDetails,
                              arguments: product.id,
                            );
                          },
                          leading:
                              product.image.isNotEmpty
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      product.image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                              ),
                                    ),
                                  )
                                  : const Icon(Icons.image, size: 50),
                          title: Text(product.title),
                          subtitle: Text(
                            '${l10n.brandLabel}: ${product.brand}',
                          ),
                          trailing: Text('\$${product.price}'),
                        );
                      },
                    ),
              Status.error => Center(
                child: state.products.error?.errorMessage.toText(),
              ),
            };
          },
        ),
      ),
    );
  }
}
