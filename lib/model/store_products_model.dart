class StoreProduct {
  final String id;
  final String storeId;
  final String catId;
  final String catName;
  final String title;
  final String img;
  final String description;
  final String status;

  StoreProduct({
    required this.id,
    required this.storeId,
    required this.catId,
    required this.catName,
    required this.title,
    required this.img,
    required this.description,
    required this.status,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) {
    return StoreProduct(
      id: json['id']?.toString() ?? '',
      storeId: json['store_id']?.toString() ?? '1',
      catId: json['cat_id']?.toString() ?? '',
      catName: json['cat_name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      img: json['img']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'cat_id': catId,
      'cat_name': catName,
      'title': title,
      'img': img,
      'description': description,
      'status': status,
    };
  }

  StoreProduct copyWith({
    String? id,
    String? storeId,
    String? catId,
    String? catName,
    String? title,
    String? img,
    String? description,
    String? status,
  }) {
    return StoreProduct(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      catId: catId ?? this.catId,
      catName: catName ?? this.catName,
      title: title ?? this.title,
      img: img ?? this.img,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'StoreProduct(id: $id, title: $title, img: $img)';
  }

  static List<StoreProduct> listFromJson(dynamic json) {
    if (json is List) {
      return json
          .map((e) => StoreProduct.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}
