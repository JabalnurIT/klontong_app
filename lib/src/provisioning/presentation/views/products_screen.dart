import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:klontong_app/src/provisioning/presentation/bloc/provisioning_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/utils/core_utils.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    context.read<ProvisioningBloc>().add(const GetAllProductsEvent());
    _searchController = TextEditingController();
    super.initState();
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
          return state is ProvisioningLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Colours.primaryColour,
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Consumer<ProductProvider>(
                    builder: (_, productProvider, __) {
                      return productProvider.products.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: NumberPagination(
                                      onPageChanged: (int pageNumber) {
                                        productProvider
                                            .changePage(pageNumber - 1);
                                      },
                                      visiblePagesCount: 7,
                                      totalPages: productProvider.page,
                                      currentPage:
                                          productProvider.indexPage + 1,
                                      selectedButtonColor:
                                          Colours.secondaryColour,
                                      buttonRadius: 8,
                                      sectionSpacing: 4,
                                    ),
                                  ),
                                  // SearchBar
                                  Container(
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
                                              productProvider
                                                  .searchProduct(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: productProvider
                                            .productsOnPage.isNotEmpty
                                        ? GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8.0,
                                            ),
                                            padding: const EdgeInsets.all(16.0),
                                            itemCount: productProvider
                                                .productsOnPage.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(3, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // image
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        productProvider
                                                            .productsOnPage[
                                                                index]!
                                                            .image!,
                                                        width: 90,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      productProvider
                                                          .productsOnPage[
                                                              index]!
                                                          .name,
                                                      style: const TextStyle(
                                                        color: Colours
                                                            .primaryColour,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rp. ${productProvider.productsOnPage[index]!.price}',
                                                      style: const TextStyle(
                                                        color: Colours
                                                            .primaryColour,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
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
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('No data found'),
                                ),
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
