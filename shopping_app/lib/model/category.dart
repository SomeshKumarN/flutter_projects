import 'dart:ui';

enum Categories {
  fruit,
  vegetables,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  final String name;
  final Color color;
  const Category(this.name, this.color);
}
