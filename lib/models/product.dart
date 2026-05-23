class Product {
  Product({
    required this.firestoreId,
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
    required this.imageUrl,
    required this.price,
    required this.discountPercent,
    required this.stock,
    this.category = 'Artisanat',
    this.categoryAr = 'حرفة يدوية',
  });

  final String firestoreId;
  final int id;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final String imageUrl;
  final double price;
  final int discountPercent;
  final int stock;

  final String category;
  final String categoryAr;

  double get finalPrice => price * (1 - discountPercent / 100);

  String getLocalizedTitle(String languageCode) =>
      languageCode == 'ar' ? titleAr : title;

  String getLocalizedDescription(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : description;

  String getLocalizedCategory(String languageCode) =>
      languageCode == 'ar' ? categoryAr : category;

  factory Product.fromFirestore(String docId, Map<String, dynamic> data) {
    return Product(
      firestoreId: docId,
      id: docId.hashCode.abs(),
      title: (data['title'] ?? '').toString(),
      titleAr: (data['title_ar'] ?? data['title'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      descriptionAr: (data['description_ar'] ?? data['description'] ?? '')
          .toString(),
      imageUrl: (data['image_url'] ?? '').toString(),
      price: (data['price'] as num?)?.toDouble() ?? 0,
      discountPercent: (data['discount_percent'] as num?)?.toInt() ?? 0,
      stock: (data['stock'] as num?)?.toInt() ?? 0,
      category: (data['category'] ?? 'Artisanat').toString(),
      categoryAr: (data['category_ar'] ?? 'حرفة يدوية').toString(),
    );
  }
}
