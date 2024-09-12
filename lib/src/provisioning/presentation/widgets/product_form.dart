import 'package:flutter/material.dart';
import 'package:klontong_app/core/extensions/context_extensions.dart';

import '../../../../core/common/widgets/i_dropdown.dart';
import '../../../../core/common/widgets/i_fields.dart';
import '../../../../core/res/colours.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({
    super.key,
    required this.productKey,
    required TextEditingController categoryNameController,
    required TextEditingController skuController,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required TextEditingController weightController,
    required TextEditingController widthController,
    required TextEditingController lengthController,
    required TextEditingController heightController,
    required TextEditingController imageController,
    required TextEditingController priceController,
    required List<String> categories,
  })  : _categoryNameController = categoryNameController,
        _skuController = skuController,
        _nameController = nameController,
        _descriptionController = descriptionController,
        _weightController = weightController,
        _widthController = widthController,
        _lengthController = lengthController,
        _heightController = heightController,
        _imageController = imageController,
        _priceController = priceController,
        _categories = categories;

  final GlobalKey<FormState> productKey;
  final TextEditingController _categoryNameController;
  final TextEditingController _skuController;
  final TextEditingController _nameController;
  final TextEditingController _descriptionController;
  final TextEditingController _weightController;
  final TextEditingController _widthController;
  final TextEditingController _lengthController;
  final TextEditingController _heightController;
  final TextEditingController _imageController;
  final TextEditingController _priceController;
  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                        items: List<DropdownMenuItem<String>>.generate(
                          _categories.length,
                          (index) {
                            return DropdownMenuItem(
                              value: _categories[index],
                              child: Text(
                                _categories[index],
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
          ],
        ),
      ),
    );
  }
}
