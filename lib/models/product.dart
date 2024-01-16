class Product {
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;
  bool isSelected = false;
  int quantity = 1;
  double discount;
  double iva;
  int calories;
  String practicalInfo;
  String recipe;

  Product(
      this.id,
      this.name,
      this.price,
      this.category,
      this.image,
      this.description,
      this.quantity,
      this.discount,
      this.iva,
      this.calories,
      this.practicalInfo,
      this.recipe,
      );

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    map['id'],
    map['name'],
    map['price'],
    map['category'],
    map['image'],
    map['description'],
    1,
    map['discount'] ?? 0.0,
    map['iva'] ?? 0.0,
    map['calories'] ?? 0,
    map['practicalInfo'] ?? '',
    map['recipe'] ?? '',
  );
}
