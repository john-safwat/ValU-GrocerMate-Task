import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/status.dart';
import 'package:valu_task/features/products/presentation/home/home_bloc.dart';
import 'package:valu_task/features/products/presentation/home/home_events.dart';
import 'package:valu_task/features/products/presentation/home/home_state.dart';
import 'package:valu_task/features/products/presentation/widget/product_card.dart';

class SavedItemsListWidget extends StatefulWidget {
  final HomeBloc bloc;

  const SavedItemsListWidget({required this.bloc, super.key});

  @override
  State<SavedItemsListWidget> createState() => _SavedItemsListWidgetState();
}

class _SavedItemsListWidgetState extends State<SavedItemsListWidget> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetSavedItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {},
              builder:
                  (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      if (state.savedItems?.status == Status.loading ||
                          state.savedItems?.status == null)
                        const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      if (state.savedItems?.status == Status.error)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Image.asset("assets/images/Empty-pana.png"),
                          ),
                        ),
                      if (state.savedItems?.status == Status.success)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder:
                                (context, index) => ProductCard(
                                  product: state.savedItems!.data![index],
                                  bloc: widget.bloc,
                                ),
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 8),
                            itemCount: (state.savedItems?.data ?? []).length,
                          ),
                        ),
                      FilledButton(
                        onPressed: () {
                          widget.bloc.add(AddAllToCartEvent());
                        },
                        child: Text(AppLocalizations.of(context)!.addAllToCart),
                      ),
                    ],
                  ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
