import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/common/widgets/i_dropdown.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/common/widgets/app_bar_core.dart';
import '../../../../core/common/widgets/i_fields.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/utils/core_utils.dart';
import '../../domain/entities/product.dart';
import '../bloc/provisioning_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

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
    fillData();
  }

  // fill with dummy data
//   {
//   "categoryName": "Cemilan",
//   "sku": "MHZVTK",
//   "name": "Ciki ciki",
//   "description": "Ciki ciki yang super enak, hanya di toko klontong kami",
//   "weight": 500,
//   "width": 5,
//   "length": 5,
//   "height": 5,
//   "image": "https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b",
//   "harga": 30000
// }

  void fillData() {
    _categoryNameController.text = 'Makanan';
    _skuController.text = 'MHZVTK';
    _nameController.text = 'Indomie';
    _descriptionController.text =
        'Ciki ciki yang super enak, hanya di toko klontong kami';
    _weightController.text = '500';
    _widthController.text = '5';
    _lengthController.text = '5';
    _heightController.text = '5';
    _imageController.text =
        'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b';
    _priceController.text = '30000';
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
                  child: Form(
                    key: productKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Category Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IDropdown(
                                      controller: _categoryNameController,
                                      items: List<
                                          DropdownMenuItem<String>>.generate(
                                        productProvider.categories.length,
                                        (index) {
                                          return DropdownMenuItem(
                                            value: productProvider
                                                .categories[index],
                                            child: Text(
                                              productProvider.categories[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SKU',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IFields(
                                      controller: _skuController,
                                      hintText: 'SKU',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryColour,
                            ),
                          ),
                          IFields(
                            controller: _nameController,
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryColour,
                            ),
                          ),
                          IFields(
                            controller: _descriptionController,
                            hintText: 'Description',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Weight',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IFields(
                                      controller: _weightController,
                                      hintText: 'Weight',
                                      keyboardType: TextInputType.number,
                                      suffixIcon: const Text(
                                        'Kg',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colours.primaryColour,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Width',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IFields(
                                      controller: _widthController,
                                      hintText: 'Width',
                                      keyboardType: TextInputType.number,
                                      suffixIcon: const Text(
                                        'cm',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colours.primaryColour,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Length',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IFields(
                                      controller: _lengthController,
                                      hintText: 'Length',
                                      keyboardType: TextInputType.number,
                                      suffixIcon: const Text(
                                        'cm',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colours.primaryColour,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Height',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.primaryColour,
                                      ),
                                    ),
                                    IFields(
                                      controller: _heightController,
                                      hintText: 'Height',
                                      keyboardType: TextInputType.number,
                                      suffixIcon: const Text(
                                        'cm',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colours.primaryColour,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Image URL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryColour,
                            ),
                          ),
                          IFields(
                            controller: _imageController,
                            hintText: 'Image URL',
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Harga',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryColour,
                            ),
                          ),
                          IFields(
                            controller: _priceController,
                            hintText: 'Harga',
                            keyboardType: TextInputType.number,
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
                                              id: '',
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
