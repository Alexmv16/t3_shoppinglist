import 'package:flutter/material.dart';
import 'package:t3_shoppinglist/models/product.dart';

class ShoppingCartScreen extends StatelessWidget {
  final List<Product> selectedProducts;

  const ShoppingCartScreen({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Center(
        child: Text('Tu pedido del carrito se encuentra aqui'),
      ),
    );
  }
}


class _CartItemWidget extends StatefulWidget {
  final Product product;

  const _CartItemWidget({required this.product});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<_CartItemWidget> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        widget.product.image,
        width: 50.0,
        height: 50.0,
      ),
      title: Text(widget.product.name),
      subtitle: Text('${widget.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity--;
                });
              }
            },
          ),
          Text('$_quantity'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}
