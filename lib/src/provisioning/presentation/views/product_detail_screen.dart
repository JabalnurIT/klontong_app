import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/common/widgets/dialog_confirmation.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:klontong_app/src/provisioning/presentation/views/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/common/widgets/nested_back_button.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/services/injection_container.dart';
import '../bloc/provisioning_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (_, productProvider, __) {
        return BlocConsumer<ProvisioningBloc, ProvisioningState>(
          listener: (context, state) {
            if (state is ProvisioningError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colours.errorColour,
                ),
              );
            } else if (state is ProductLoaded) {
              productProvider.initProductById(state.product);
            } else if (state is ProductDeleted) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Product Deleted"),
                  backgroundColor: Colours.primaryColour,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Colours.primaryColour,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.push(BlocProvider(
                              create: (_) => sl<ProvisioningBloc>(),
                              child: const EditProductScreen(),
                            ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return DialogConfirmation(
                                  title: "Delete Product?",
                                  icon: IconButton(
                                    onPressed: () {
                                      context.read<ProvisioningBloc>().add(
                                            DeleteProductEvent(
                                              id: productProvider.product!.id,
                                            ),
                                          );
                                      Navigator.pop(context);
                                      context.pop();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colours.errorColour,
                                      size: 120,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                leading: const NestedBackButton(),
                title: Text(
                  productProvider.product!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProvisioningBloc>().add(
                      GetProductByIdEvent(id: productProvider.product!.id));
                },
                child: state is ProvisioningLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colours.primaryColour,
                        ),
                      )
                    : ListView(
                        children: [
                          Container(
                            height: 280,
                            width: double.infinity,
                            color: Colors.grey,
                            child: Image.network(
                              productProvider.product!.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Text(
                              productProvider.product!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 16),
                            child: Text(
                              productProvider.product!.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "SKU",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Dimension",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp${productProvider.product!.price.toString()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      productProvider.product!.sku.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      productProvider.product!.categoryName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${productProvider.product!.weight.toString()} kg",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${productProvider.product!.width.toString()} cm x "
                                      "${productProvider.product!.height.toString()} cm x "
                                      "${productProvider.product!.length.toString()} cm",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
