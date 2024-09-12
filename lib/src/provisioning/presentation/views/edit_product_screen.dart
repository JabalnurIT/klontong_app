import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app/providers/product_provider.dart';
import '../../../../core/common/widgets/nested_back_button.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/utils/core_utils.dart';
import '../../domain/entities/product.dart';
import '../bloc/provisioning_bloc.dart';
import '../widgets/product_form.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Product _product = const Product.empty();
  final productKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initController(context.productProvider.product!);
    initListener;
  }

  void initController(Product product) {
    _product = product;
    _categoryNameController.text = product.categoryName;
    _skuController.text = product.sku;
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _weightController.text = product.weight.toString();
    _widthController.text = product.width.toString();
    _lengthController.text = product.length.toString();
    _heightController.text = product.height.toString();
    _imageController.text = product.image!;
    _priceController.text = product.price.toString();
    setState(() {});
  }

  void get initListener {
    _categoryNameController.addListener(() => setState(() {}));
    _skuController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
    _weightController.addListener(() => setState(() {}));
    _widthController.addListener(() => setState(() {}));
    _lengthController.addListener(() => setState(() {}));
    _heightController.addListener(() => setState(() {}));
    _imageController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
  }

  bool get categoryNameChanged =>
      _product.categoryName != _categoryNameController.text.trim();

  bool get skuChanged => _product.sku != _skuController.text.trim();

  bool get nameChanged => _product.name != _nameController.text.trim();

  bool get descriptionChanged =>
      _product.description != _descriptionController.text.trim();

  bool get weightChanged =>
      _product.weight != int.parse(_weightController.text);

  bool get widthChanged => _product.width != int.parse(_widthController.text);

  bool get lengthChanged =>
      _product.length != int.parse(_lengthController.text);

  bool get heightChanged =>
      _product.height != int.parse(_heightController.text);

  bool get imageChanged => _product.image != _imageController.text.trim();

  bool get priceChanged => _product.price != int.parse(_priceController.text);

  bool get nothingChanged =>
      !categoryNameChanged &&
      !skuChanged &&
      !nameChanged &&
      !descriptionChanged &&
      !weightChanged &&
      !widthChanged &&
      !lengthChanged &&
      !heightChanged &&
      !imageChanged &&
      !priceChanged;

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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colours.primaryColour,
        leading: const NestedBackButton(),
        title: const Text(
          "Edit Product",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ProvisioningBloc, ProvisioningState>(
        listener: (_, state) {
          if (state is ProvisioningError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ProductUpdated) {
            context.productProvider.product = state.product;
            initController(state.product);
            CoreUtils.showSnackBar(
              context,
              'Product added successfully',
            );
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
                            ignoring:
                                nothingChanged || state is ProvisioningLoading,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: nothingChanged
                                    ? Colours.secondaryColour.withOpacity(0.5)
                                    : Colours.secondaryColour,
                              ),
                              onPressed: () {
                                if (productKey.currentState!.validate()) {
                                  context.read<ProvisioningBloc>().add(
                                        UpdateProductEvent(
                                          product: Product(
                                            id: productProvider.product!.id,
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
                                          : const Text('Update Product')),
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
