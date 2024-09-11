import '../../../../core/utils/typedef.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.categoryName,
    required super.sku,
    required super.name,
    required super.description,
    super.weight,
    super.width,
    super.length,
    super.height,
    super.image,
    required super.price,
  });

  const ProductModel.empty({String? id})
      : this(
          id: id ?? '1',
          categoryName: 'Cemilan',
          sku: 'MHZVTK',
          name: 'Ciki ciki',
          description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
          weight: 500,
          width: 5,
          length: 5,
          height: 5,
          image:
              'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
          price: 30000,
        );

  ProductModel copyWith({
    String? id,
    String? categoryName,
    String? sku,
    String? name,
    String? description,
    int? weight,
    int? width,
    int? length,
    int? height,
    String? image,
    int? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  ProductModel.fromMap(DataMap map)
      : super(
          id: map['_id'] as String,
          categoryName: map['categoryName'] as String,
          sku: map['sku'] as String,
          name: map['name'] as String,
          description: map['description'] as String,
          weight: map['weight'] as int?,
          width: map['width'] as int?,
          length: map['length'] as int?,
          height: map['height'] as int?,
          image: map['image'] as String?,
          price: map['harga'] as int,
        );

  ProductModel.fromEntity(Product product)
      : super(
          id: product.id,
          categoryName: product.categoryName,
          sku: product.sku,
          name: product.name,
          description: product.description,
          weight: product.weight,
          width: product.width,
          length: product.length,
          height: product.height,
          image: product.image,
          price: product.price,
        );

  DataMap toMap() {
    return {
      '_id': id,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'harga': price,
    };
  }
}
