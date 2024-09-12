import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/common/widgets/app_bar_core.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/utils/core_utils.dart';
import '../../domain/entities/product.dart';
import '../bloc/provisioning_bloc.dart';
import '../widgets/product_form.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _categoryNameController;
  late TextEditingController _skuController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _weightController;
  late TextEditingController _widthController;
  late TextEditingController _lengthController;
  late TextEditingController _heightController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  final productKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController();
    _skuController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _weightController = TextEditingController();
    _widthController = TextEditingController();
    _lengthController = TextEditingController();
    _heightController = TextEditingController();
    _imageController = TextEditingController();
    _priceController = TextEditingController();
  }

  void clearData() {
    _skuController.clear();
    _nameController.clear();
    _descriptionController.clear();
    _weightController.clear();
    _widthController.clear();
    _lengthController.clear();
    _heightController.clear();
    _imageController.clear();
    _priceController.clear();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _skuController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _weightController.dispose();
    _widthController.dispose();
    _lengthController.dispose();
    _heightController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCore(
        title: 'Add Product',
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ProvisioningBloc, ProvisioningState>(
        listener: (_, state) {
          if (state is ProvisioningError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ProductAdded) {
            CoreUtils.showSnackBar(
              context,
              'Product added successfully',
            );
            clearData();
          }
        },
        builder: (context, state) {
          return Consumer<ProductProvider>(
            builder: (_, productProvider, __) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductForm(
                          productKey: productKey,
                          categoryNameController: _categoryNameController,
                          skuController: _skuController,
                          nameController: _nameController,
                          descriptionController: _descriptionController,
                          weightController: _weightController,
                          widthController: _widthController,
                          lengthController: _lengthController,
                          heightController: _heightController,
                          imageController: _imageController,
                          priceController: _priceController,
                          categories: productProvider.categories,
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: IgnorePointer(
                            ignoring: state is ProvisioningLoading,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colours.secondaryColour),
                              onPressed: () {
                                if (productKey.currentState!.validate()) {
                                  context.read<ProvisioningBloc>().add(
                                        AddProductEvent(
                                          product: Product(
                                            id: "",
                                            categoryName:
                                                _categoryNameController.text,
                                            sku: _skuController.text,
                                            name: _nameController.text,
                                            description:
                                                _descriptionController.text,
                                            weight: int.parse(
                                                _weightController.text),
                                            width: int.parse(
                                                _widthController.text),
                                            length: int.parse(
                                                _lengthController.text),
                                            height: int.parse(
                                                _heightController.text),
                                            image: _imageController.text,
                                            price: int.parse(
                                                _priceController.text),
                                          ),
                                        ),
                                      );
                                }
                              },
                              child: SizedBox(
                                width: context.width * 0.3,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: state is ProvisioningLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text('Add Product')),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
