import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:klontong_app/src/provisioning/presentation/bloc/provisioning_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/utils/core_utils.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    context.read<ProvisioningBloc>().add(const GetAllProductsEvent());
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<ProvisioningBloc, ProvisioningState>(
        listener: (_, state) {
          if (state is ProvisioningError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ProductsLoaded) {
            context.productProvider.initProduct(state.products);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Consumer<ProductProvider>(
              builder: (_, productProvider, __) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.86,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: NumberPagination(
                          onPageChanged: (int pageNumber) {
                            productProvider.changePage(pageNumber - 1);
                          },
                          visiblePagesCount: 7,
                          totalPages: productProvider.page,
                          currentPage: productProvider.indexPage + 1,
                          selectedButtonColor: Colours.secondaryColour,
                          buttonRadius: 8,
                          sectionSpacing: 4,
                        ),
                      ),
                      // SearchBar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: const InputDecoration(
                                        hintText: 'Search',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      cursorColor: Colors.white,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      onTapOutside: (_) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (value) {
                                        productProvider.searchProduct(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Refresh Page
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ProvisioningBloc>()
                                  .add(const GetAllProductsEvent());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(
                                  top: 16, bottom: 16, right: 20),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: state is ProvisioningLoading
                            ? const Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: Colours.primaryColour,
                                  ),
                                ),
                              )
                            : productProvider.productsOnPage.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: ScrollableTableView(
                                      headers:
                                          productProvider.headers.map((label) {
                                        return TableViewHeader(
                                          label: label,
                                          textStyle: const TextStyle(
                                            color: Colours.primaryColour,
                                            fontSize: 12,
                                          ),
                                        );
                                      }).toList(),
                                      rows: productProvider.productsOnPage
                                          .map((record) {
                                        return TableViewRow(height: 60, cells: [
                                          TableViewCell(
                                            child: Text(
                                              record!.categoryName,
                                              style: const TextStyle(
                                                color: Colours.primaryColour,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableViewCell(
                                            child: Text(
                                              record.sku,
                                              style: const TextStyle(
                                                color: Colours.primaryColour,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableViewCell(
                                            child: Text(
                                              record.name,
                                              style: const TextStyle(
                                                color: Colours.primaryColour,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableViewCell(
                                            child: Text(
                                              "Rp${record.price}",
                                              style: const TextStyle(
                                                color: Colours.primaryColour,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          TableViewCell(
                                            child: IconButton(
                                              onPressed: () {
                                                productProvider
                                                    .initProductById(record);
                                                context.push(BlocProvider(
                                                  create: (_) =>
                                                      sl<ProvisioningBloc>(),
                                                  child:
                                                      const ProductDetailScreen(),
                                                ));
                                              },
                                              icon: const Icon(
                                                Icons.edit_square,
                                                color: Colours.secondaryColour,
                                              ),
                                            ),
                                          ),
                                        ]);
                                      }).toList(),
                                    ),
                                  )
                                // GridView.builder(
                                //     gridDelegate:
                                //         const SliverGridDelegateWithFixedCrossAxisCount(
                                //       crossAxisCount: 2,
                                //       crossAxisSpacing: 8.0,
                                //     ),
                                //     padding: const EdgeInsets.all(16.0),
                                //     itemCount:
                                //         productProvider.productsOnPage.length,
                                //     itemBuilder: (context, index) {
                                //       return ProductsGrid(
                                //         onTap: () {
                                //           productProvider.initProductById(
                                //               productProvider
                                //                   .productsOnPage[index]!);
                                //           context.push(BlocProvider(
                                //             create: (_) =>
                                //                 sl<ProvisioningBloc>(),
                                //             child: const ProductDetailScreen(),
                                //           ));
                                //         },
                                //         products:
                                //             productProvider.productsOnPage,
                                //         index: index,
                                //       );
                                //     })
                                : const Center(
                                    child: Text(
                                      'No data found',
                                      style: TextStyle(
                                        color: Colours.primaryColour,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
