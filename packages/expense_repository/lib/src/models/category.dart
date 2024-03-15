class Category {
  final String id;
  final String name;
  final String icon;
  final int color;
  final int totalExpense;
  const Category(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required this.totalExpense});

  static final empty =
      Category(id: '', name: '', totalExpense: 0, icon: '', color: 0);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalExpense': totalExpense,
      'icon': icon,
      'color': color
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        icon: map['icon'],
        color: map['color'],
        totalExpense: map['totalExpense']);
  }
}
