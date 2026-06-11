import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class LocalStorageService {
  static const String _productsKey = 'cached_products';
  static const String _lastFetchKey = 'last_fetch_time';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Save products to local storage
  Future<bool> saveProducts(List<Product> products) async {
    try {
      final productsJson = products.map((p) => p.toJson()).toList();
      await _prefs.setString(_productsKey, jsonEncode(productsJson));
      await _prefs.setInt(_lastFetchKey, DateTime.now().millisecondsSinceEpoch);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Load products from local storage
  List<Product> loadProducts() {
    try {
      final productsString = _prefs.getString(_productsKey);
      if (productsString == null || productsString.isEmpty) {
        return [];
      }
      final List<dynamic> productsJson = jsonDecode(productsString);
      return productsJson.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  // Check if cache is still valid (24 hours)
  bool isCacheValid() {
    final lastFetch = _prefs.getInt(_lastFetchKey);
    if (lastFetch == null) return false;

    final lastFetchTime = DateTime.fromMillisecondsSinceEpoch(lastFetch);
    final now = DateTime.now();
    final difference = now.difference(lastFetchTime);

    // Cache valid for 24 hours
    return difference.inHours < 24;
  }

  // Clear all cached data
  Future<bool> clearCache() async {
    try {
      await _prefs.remove(_productsKey);
      await _prefs.remove(_lastFetchKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get last fetch time
  DateTime? getLastFetchTime() {
    final lastFetch = _prefs.getInt(_lastFetchKey);
    if (lastFetch == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(lastFetch);
  }
}
