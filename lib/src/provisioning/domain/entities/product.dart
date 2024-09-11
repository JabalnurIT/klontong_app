import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    this.weight,
    this.width,
    this.length,
    this.height,
    this.image,
    required this.price,
  });

  const Product.empty({String? id})
      : id = id ?? "1",
        categoryName = 'Cemilan',
        sku = 'MHZVTK',
        name = 'Ciki ciki',
        description = 'Ciki ciki yang super enak, hanya di toko klontong kami',
        weight = 500,
        width = 5,
        length = 5,
        height = 5,
        image = 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
        price = 30000;

  final String id;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final int? weight;
  final int? width;
  final int? length;
  final int? height;
  final String? image;
  final int price;

  @override
  List<Object?> get props => [
        id,
        categoryName,
        sku,
        name,
        description,
        weight,
        width,
        length,
        height,
        image,
        price
      ];

  @override
  String toString() {
    return 'Item{id: $id, categoryName: $categoryName, sku: $sku, '
        'name: $name, description: $description, weight: $weight, '
        'width: $width, length: $length, height: $height, '
        'image: $image, price: $price}';
  }
}
