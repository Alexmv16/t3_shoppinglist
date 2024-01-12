class Product {
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;
  bool isSelected = false;

  Product(this.id, this.name, this.price, this.category, this.image, this.description);


  factory Product.fromMap(Map<String, dynamic> map) => Product(
    map['id'],
    map['name'],
    map['price'],
    map['category'],
    map['image'],
    map['description']);
}