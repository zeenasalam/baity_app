import 'package:baity/models/realestate.dart';
import 'package:baity/repository/realestate_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RealestatePaginationScreen extends StatefulHookWidget {
  const RealestatePaginationScreen({super.key});

  @override
  State<RealestatePaginationScreen> createState() =>
      _RealestatePaginationScreenState();
}

class _RealestatePaginationScreenState
    extends State<RealestatePaginationScreen> {
  final PagingController<int, RealEstateModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context
          .read<RealEstateRepository>()
          .fetchRealEstates(pageNumber: pageKey);
      final nextPageKey = pageKey++;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('data'),
        ),
        body: PagedListView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<RealEstateModel>(
                itemBuilder: (context, item, index) => ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          item.ownerImageUrl,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                      title: Text(item.id),
                      subtitle: Text(item.title),
                    ))));
  }
}
