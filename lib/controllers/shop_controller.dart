import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class ShopController extends ChangeNotifier {
  ShopController() {
    _subscribeToProducts();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Product> _products = <Product>[];
  final Map<String, int> _cart = <String, int>{};
  bool _isLoading = true;
  String? _lastError;
  bool _isAdminLoggedIn = false;

  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get lastError => _lastError;
  bool get isAdminLoggedIn => _isAdminLoggedIn;

  int get cartCount => _cart.values.fold(0, (s, q) => s + q);

  List<CartItem> get cartItems => _products
      .where((p) => (_cart[p.firestoreId] ?? 0) > 0)
      .map((p) => CartItem(product: p, quantity: _cart[p.firestoreId]!))
      .toList();

  double get totalPrice => cartItems.fold(0, (s, item) => s + item.linePrice);

  void _subscribeToProducts() {
    _db
        .collection('products')
        .snapshots()
        .listen(
          (snap) {
            _products = snap.docs
                .map((doc) => Product.fromFirestore(doc.id, doc.data()))
                .toList();
            _isLoading = false;
            _lastError = null;
            notifyListeners();
          },
          onError: (e) {
            _lastError = e.toString();
            _isLoading = false;
            notifyListeners();
          },
        );
  }

  Future<void> loadProducts() async {}

  String addToCart(Product product) {
    final current = _cart[product.firestoreId] ?? 0;
    if (current >= product.stock) {
      return 'Stock insuffisant pour ${product.title}.';
    }
    _cart[product.firestoreId] = current + 1;
    notifyListeners();
    return '${product.title} ajouté au panier.';
  }

  void updateQuantity(Product product, int quantity) {
    final safeQty = quantity.clamp(0, product.stock);
    if (safeQty == 0) {
      _cart.remove(product.firestoreId);
    } else {
      _cart[product.firestoreId] = safeQty;
    }
    notifyListeners();
  }

  Future<String> placeOrder({
    required String name,
    required String phone,
    required String address,
  }) async {
    if (cartItems.isEmpty) return 'Votre panier est vide.';
    if (name.trim().isEmpty || phone.trim().isEmpty || address.trim().isEmpty) {
      return 'Veuillez remplir tous les champs.';
    }
    try {
      await _db.collection('orders').add({
        'customer_name': name.trim(),
        'customer_phone': phone.trim(),
        'customer_address': address.trim(),
        'user_id': FirebaseAuth.instance.currentUser?.uid ?? '',
        'status': 'pending',
        'total': totalPrice,
        'items': cartItems
            .map(
              (i) => {
                'product_id': i.product.firestoreId,
                'product_title': i.product.title,
                'quantity': i.quantity,
                'unit_price': i.product.finalPrice,
              },
            )
            .toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      _cart.clear();
      notifyListeners();
      return 'Commande enregistrée avec succès !';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addProduct({
    required String title,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String imageUrl,
    required double price,
    required int discountPercent,
    required int stock,
    required String category,
    required String categoryAr,
  }) async {
    if (title.trim().isEmpty || description.trim().isEmpty) {
      return 'Titre et description obligatoires.';
    }
    if (price <= 0 ||
        stock < 0 ||
        discountPercent < 0 ||
        discountPercent > 90) {
      return 'Valeurs invalides.';
    }
    try {
      await _db.collection('products').add({
        'title': title.trim(),
        'title_ar': titleAr.trim().isEmpty ? title.trim() : titleAr.trim(),
        'description': description.trim(),
        'description_ar': descriptionAr.trim().isEmpty
            ? description.trim()
            : descriptionAr.trim(),
        'image_url': imageUrl.trim(),
        'price': price,
        'discount_percent': discountPercent,
        'stock': stock,
        'category': category.trim().isEmpty ? 'Artisanat' : category.trim(),
        'category_ar': categoryAr.trim().isEmpty
            ? 'حرفة يدوية'
            : categoryAr.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return 'Produit ajouté avec succès.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateProduct({
    required int id,
    required String title,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String imageUrl,
    required double price,
    required int discountPercent,
    required int stock,
    required String category,
    required String categoryAr,
  }) async {
    if (title.trim().isEmpty || description.trim().isEmpty) {
      return 'Titre et description obligatoires.';
    }
    if (price <= 0 ||
        stock < 0 ||
        discountPercent < 0 ||
        discountPercent > 90) {
      return 'Valeurs invalides.';
    }
    final product = _products.where((p) => p.id == id).firstOrNull;
    if (product == null) return 'Produit introuvable.';
    try {
      await _db.collection('products').doc(product.firestoreId).update({
        'title': title.trim(),
        'title_ar': titleAr.trim().isEmpty ? title.trim() : titleAr.trim(),
        'description': description.trim(),
        'description_ar': descriptionAr.trim().isEmpty
            ? description.trim()
            : descriptionAr.trim(),
        'image_url': imageUrl.trim(),
        'price': price,
        'discount_percent': discountPercent,
        'stock': stock,
        'category': category.trim().isEmpty ? 'Artisanat' : category.trim(),
        'category_ar': categoryAr.trim().isEmpty
            ? 'حرفة يدوية'
            : categoryAr.trim(),
      });
      return 'Produit mis à jour.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProduct(int productId) async {
    final product = _products.where((p) => p.id == productId).firstOrNull;
    if (product == null) return 'Produit introuvable.';
    try {
      await _db.collection('products').doc(product.firestoreId).delete();
      _cart.remove(product.firestoreId);
      notifyListeners();
      return 'Produit supprimé.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> loginAdmin(String username, String password) async {
    if (username.trim() == 'admin' && password.trim() == '1234') {
      _isAdminLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logoutAdmin() {
    _isAdminLoggedIn = false;
    notifyListeners();
  }
}
