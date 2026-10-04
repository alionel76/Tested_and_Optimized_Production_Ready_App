/// Modèle de domaine représentant un article du catalogue dans l'application.
class Item {
  /// Identifiant unique de l'article.
  final String id;

  /// Nom de l'article.
  final String name;

  /// Description détaillée de l'article.
  final String description;

  /// Prix unitaire de l'article.
  final double price;

  /// Catégorie à laquelle appartient l'article.
  final String category;

  /// URL de l'image d'illustration de l'article.
  final String imageUrl;

  /// Indique si l'article est marqué comme favori par l'utilisateur.
  final bool isFavorite;

  /// Constructeur constant pour créer un [Item].
  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
  });

  /// Crée une copie de cet [Item] en modifiant uniquement les champs spécifiés.
  Item copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Sérialise cet [Item] sous forme de Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  /// Désérialise un objet JSON pour instancier un [Item].
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          category == other.category &&
          imageUrl == other.imageUrl &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      category.hashCode ^
      imageUrl.hashCode ^
      isFavorite.hashCode;
}
