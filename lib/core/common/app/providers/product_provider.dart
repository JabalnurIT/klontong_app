import 'package:flutter/cupertino.dart';

import '../../../../src/provisioning/domain/entities/product.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;

  Product? get product => _product;

  void initProductById(Product product) {
    if (_product != product) _product = product;
  }

  set product(Product? product) {
    if (_product != product) {
      _product = product;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  List<Product?> _productsOnPage = [];

  List<Product?> get productsOnPage => _productsOnPage;

  void initProductsOnPage(
    List<Product?> products,
    int itemsPerPage,
  ) {
    final List<Product?> result = _products
        .where(
          (element) =>
              element!.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.categoryName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.id.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    _page = (result.length / itemsPerPage).ceil();
    final int start = indexPage * itemsPerPage;
    final int end = (indexPage + 1) * itemsPerPage > result.length
        ? result.length
        : (indexPage + 1) * itemsPerPage;
    _productsOnPage = result.sublist(start, end);
    notifyListeners();
  }

  // set productsOnPage(List<List<Product?>> productsOnPage) {
  //   if (_productsOnPage != productsOnPage) {
  //     _productsOnPage = productsOnPage;
  //     Future.delayed(Duration.zero, notifyListeners);
  //   }
  // }

  List<Product?> _products = [];

  int maxItemsPerPage = 6;

  List<Product?> get products => _products;

  void initProduct(List<Product> products) {
    if (_products != products) {
      _products = products;
      _page = (_products.length / maxItemsPerPage).ceil();
      initProductsOnPage(products, maxItemsPerPage);
    }
  }

  set products(List<Product?> products) {
    if (_products != products) {
      _products = products;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  int indexPage = 0;

  int _page = 0;

  int get page => _page;

  void nextPage() {
    if (indexPage < _page - 1) {
      indexPage++;
      initProductsOnPage(_products, maxItemsPerPage);
      notifyListeners();
    }
  }

  void previousPage() {
    if (indexPage > 0) {
      indexPage--;
      initProductsOnPage(_products, maxItemsPerPage);
      notifyListeners();
    }
  }

  void changePage(int index) {
    indexPage = index;
    initProductsOnPage(_products, maxItemsPerPage);
    notifyListeners();
  }

  String _searchQuery = '';

  void searchProduct(String query) {
    _searchQuery = query;
    indexPage = 0;

    initProductsOnPage(_products, maxItemsPerPage);
    notifyListeners();
  }
}
