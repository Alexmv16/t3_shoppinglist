import 'package:flutter/material.dart';
import 'package:t3_shoppinglist/models/product.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  const ShoppingCartScreen({required this.selectedProducts});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    updateTotalAmount();
  }

  void updateTotalAmount() {
    double total = 0.0;
    for (Product product in widget.selectedProducts) {
      total += product.price * product.quantity;
    }
    setState(() {
      totalAmount = total;
    });
  }

  void removeFromCart(int index) {
    setState(() {
      widget.selectedProducts.removeAt(index);
    });
    updateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shopping Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: ${totalAmount.toStringAsFixed(2)}\€'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.selectedProducts.length,
        itemBuilder: (context, index) {
          return _CartItemWidget(
            product: widget.selectedProducts[index],
            onQuantityChange: (newQuantity) {
              if (newQuantity <= 0) {
                removeFromCart(index);
              } else {
                widget.selectedProducts[index].quantity = newQuantity;
                updateTotalAmount();
              }
            },
            updateTotal: updateTotalAmount,
          );
        },
      ),
    );
  }
}

class _CartItemWidget extends StatefulWidget {
  final Product product;
  final ValueChanged<int> onQuantityChange;
  final VoidCallback updateTotal;

  const _CartItemWidget({
    required this.product,
    required this.onQuantityChange,
    required this.updateTotal,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<_CartItemWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.product.quantity;
  }

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
          _QuantityButton(
            icon: Icons.remove,
            color: Colors.red,
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity--;
                  widget.onQuantityChange(_quantity);
                });
              } else {
                widget.onQuantityChange(0);
              }
              widget.updateTotal();
            },
          ),
          Text('$_quantity'),
          _QuantityButton(
            icon: Icons.add,
            color: Colors.green,
            onPressed: () {
              setState(() {
                _quantity++;
                widget.onQuantityChange(_quantity);
              });
              widget.updateTotal();
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
