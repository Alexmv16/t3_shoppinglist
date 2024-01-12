import 'package:flutter/material.dart';
import 'package:t3_shoppinglist/models/product.dart';
import 'package:t3_shoppinglist/providers/products_data.dart';
import 'package:t3_shoppinglist/screens/product_detail.dart';
import 'package:t3_shoppinglist/screens/shopping_cart.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              List<Product> selectedProducts = _getSelectedProducts();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen(selectedProducts: selectedProducts)),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ProductsData.loadJson(context, 'assets/json/products.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return _ProductsListView(ProductsData.fromJson(snapshot.data!));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Product> _getSelectedProducts() {
    List<Product> selectedProducts = [];
    return selectedProducts;
  }
}

class _ProductsListView extends StatelessWidget {
  final ProductsData _productsData;

  _ProductsListView(this._productsData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _productsData.getSize(),
      itemBuilder: (context, index) =>
          _listItem(context, _productsData.getProduct(index)),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetail(product.id, product.name, product.description),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
        ),
        trailing: _ShoppingBagIcon(product: product),
        title: Text(product.name),
        subtitle: Text('${product.price}'),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class _ShoppingBagIcon extends StatefulWidget {
  final Product product;

  const _ShoppingBagIcon({required this.product});

  @override
  _ShoppingBagIconState createState() => _ShoppingBagIconState();
}

class _ShoppingBagIconState extends State<_ShoppingBagIcon> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_bag),
      color: _isSelected ? Colors.green : null,
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.product.isSelected = _isSelected;
        });
      },
    );
  }
}
