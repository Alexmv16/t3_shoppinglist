import 'package:flutter/material.dart';
import 'package:t3_shoppinglist/models/product.dart';
import 'package:t3_shoppinglist/providers/products_data.dart';
import 'package:t3_shoppinglist/screens/product_detail.dart';
import 'package:t3_shoppinglist/screens/shopping_cart.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> selectedProducts = [];
  OrderBy _currentOrderBy = OrderBy.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(selectedProducts: selectedProducts),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ProductsData.loadJson(context, 'assets/json/products.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return _ProductsListView(
              ProductsData.fromJson(snapshot.data!, orderBy: _currentOrderBy),
              selectedProducts,
              onSort: (field) {
                _sortProducts(field);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _sortProducts(String field) {
    setState(() {
      _currentOrderBy = _orderByField(field);
    });
  }

  OrderBy _orderByField(String field) {
    switch (field) {
      case 'id':
        return OrderBy.id;
      case 'name':
        return OrderBy.name;
      case 'category':
        return OrderBy.category;
      case 'price':
        return OrderBy.price;
      case 'iva':
        return OrderBy.iva;
      default:
        return OrderBy.name;
    }
  }
}

class _ProductsListView extends StatelessWidget {
  final ProductsData _productsData;
  final List<Product> selectedProducts;
  final Function(String) onSort;

  _ProductsListView(this._productsData, this.selectedProducts, {required this.onSort});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSortingBar(),
        Expanded(
          child: ListView.builder(
            itemCount: _productsData.getSize(),
            itemBuilder: (context, index) =>
                _listItem(context, _productsData.getProduct(index)),
          ),
        ),
      ],
    );
  }

  Widget _buildSortingBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSortButton("ID", () => onSort('id')),
          _buildSortButton("Name", () => onSort('name')),
          _buildSortButton("Category", () => onSort('category')),
          _buildSortButton("Price", () => onSort('price')),
          _buildSortButton("IVA", () => onSort('iva')),
          // Add buttons for other fields as needed
        ],
      ),
    );
  }

  Widget _buildSortButton(String fieldName, Function onPressed) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(fieldName),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product.id, product.name, product.description),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
        ),
        trailing: _ShoppingBagIcon(product: product, selectedProducts: selectedProducts),
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
  final List<Product> selectedProducts;

  const _ShoppingBagIcon({required this.product, required this.selectedProducts});

  @override
  _ShoppingBagIconState createState() => _ShoppingBagIconState();
}
class _ShoppingBagIconState extends State<_ShoppingBagIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_bag),
      color: widget.product.isSelected ? Colors.green : null,
      onPressed: () {
        setState(() {
          widget.product.isSelected = !widget.product.isSelected;

          if (widget.product.isSelected) {
            widget.selectedProducts.add(widget.product);
          } else {
            widget.selectedProducts.remove(widget.product);
          }
        });
      },
    );
  }
}
