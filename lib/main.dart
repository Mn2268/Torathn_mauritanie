import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/my_orders_page.dart';
import 'controllers/shop_controller.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'models/product.dart';
import 'pages/admin_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/orders_page.dart';
import 'pages/shop_page.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ShopController(),
      child: const PatrimoineApp(),
    ),
  );
}

class PatrimoineApp extends StatefulWidget {
  const PatrimoineApp({super.key});

  @override
  State<PatrimoineApp> createState() => _PatrimoineAppState();
}

class _PatrimoineAppState extends State<PatrimoineApp> {
  Locale _locale = const Locale('fr');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'fr'
          ? const Locale('ar')
          : const Locale('fr');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patrimoine Mauritanien',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr'), Locale('ar')],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E4A24),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F3EA),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF8F3EA),
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFFFFFBF5),
          indicatorColor: const Color(0xFFE4B07A).withValues(alpha: 0.35),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          color: const Color(0xFFFFFBF5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: ShopRootPage(locale: _locale, onToggleLocale: _toggleLocale),
    );
  }
}

class ShopRootPage extends StatefulWidget {
  const ShopRootPage({
    super.key,
    required this.locale,
    required this.onToggleLocale,
  });

  final Locale locale;
  final VoidCallback onToggleLocale;

  @override
  State<ShopRootPage> createState() => _ShopRootPageState();
}

class _ShopRootPageState extends State<ShopRootPage> {
  int _selectedTab = 0;
  String _userRole = 'guest'; // 'guest' | 'user' | 'admin'
  bool _loggedIn = false;

  ShopController get _controller =>
      Provider.of<ShopController>(context, listen: false);

  bool get _isAdmin => _userRole == 'admin';

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addToCart(Product product) {
    _showMessage(_controller.addToCart(product));
  }

  Future<String> _placeOrder({
    required String name,
    required String phone,
    required String address,
  }) async {
    final message = await _controller.placeOrder(
      name: name,
      phone: phone,
      address: address,
    );
    if (_controller.cartItems.isEmpty) {
      setState(() => _selectedTab = 1);
    }
    return message;
  }

  void _onLoginSuccess(String role) {
    setState(() {
      _userRole = role;
      _loggedIn = true;
      _selectedTab = 0;
    });
  }

  void _logout() async {
    await AuthService.logout();
    _controller.logoutAdmin();
    setState(() {
      _userRole = 'guest';
      _loggedIn = false;
      _selectedTab = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    // إذا غير مسجل — اعرض صفحة Login
    if (!_loggedIn) {
      return LoginPage(onSuccess: _onLoginSuccess);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // قائمة الصفحات حسب الدور
        final pages = <Widget>[
          HomePage(onOpenShop: () => setState(() => _selectedTab = 1)),
          ShopPage(
            products: _controller.products,
            onAddToCart: _addToCart,
            errorMessage: _controller.lastError,
          ),
          CartPage(
            items: _controller.cartItems,
            totalPrice: _controller.totalPrice,
            onUpdateQuantity: _controller.updateQuantity,
          ),
          CheckoutPage(
            items: _controller.cartItems,
            totalPrice: _controller.totalPrice,
            onPlaceOrder: _placeOrder,
          ),
          if (!_isAdmin) const MyOrdersPage(),
          if (_isAdmin)
            AdminPage(
              products: _controller.products,
              onAddProduct:
                  ({
                    required String imageUrl,
                    required String title,
                    required String titleAr,
                    required String description,
                    required String descriptionAr,
                    required double price,
                    required int discountPercent,
                    required int stock,
                    required String category,
                    required String categoryAr,
                  }) {
                    return _controller.addProduct(
                      imageUrl: imageUrl,
                      title: title,
                      titleAr: titleAr,
                      description: description,
                      descriptionAr: descriptionAr,
                      price: price,
                      discountPercent: discountPercent,
                      stock: stock,
                      category: category,
                      categoryAr: categoryAr,
                    );
                  },
              onUpdateProduct:
                  ({
                    required int id,
                    required String imageUrl,
                    required String title,
                    required String titleAr,
                    required String description,
                    required String descriptionAr,
                    required double price,
                    required int discountPercent,
                    required int stock,
                    required String category,
                    required String categoryAr,
                  }) {
                    return _controller.updateProduct(
                      id: id,
                      imageUrl: imageUrl,
                      title: title,
                      titleAr: titleAr,
                      description: description,
                      descriptionAr: descriptionAr,
                      price: price,
                      discountPercent: discountPercent,
                      stock: stock,
                      category: category,
                      categoryAr: categoryAr,
                    );
                  },
              onDeleteProduct: _controller.deleteProduct,
            ),
          if (_isAdmin) const OrdersPage(),
        ];

        // قائمة التنقل حسب الدور
        final destinations = <NavigationDestination>[
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: loc.translate('welcome'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.store),
            label: loc.translate('products'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.shopping_bag),
            label: loc.translate('cart'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.payment),
            label: loc.translate('checkout'),
          ),
          if (!_isAdmin)
            NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              label: loc.translate('myOrders'),
            ),
          if (_isAdmin)
            NavigationDestination(
              icon: const Icon(Icons.admin_panel_settings),
              label: loc.translate('admin'),
            ),
          if (_isAdmin)
            NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              label: loc.translate('ordersTitle'),
            ),
        ];

        // تأكد أن _selectedTab لا يتجاوز عدد الصفحات
        final safeTab = _selectedTab.clamp(0, pages.length - 1);

        return Scaffold(
          appBar: AppBar(
            title: Text(loc.translate('appTitle')),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Chip(
                  side: BorderSide.none,
                  backgroundColor: Colors.white,
                  label: Text(
                    '${loc.translate('cart')}: ${_controller.cartCount}',
                  ),
                  avatar: const Icon(Icons.shopping_cart_outlined, size: 18),
                ),
              ),
              IconButton(
                tooltip: loc.translate('language'),
                onPressed: widget.onToggleLocale,
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    widget.locale.languageCode.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              IconButton(
                tooltip: loc.translate('logoutAdmin'),
                onPressed: _logout,
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/home_bg.png', fit: BoxFit.cover),
              if (safeTab != 0)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: const Color(0xFFE8D8C5).withValues(alpha: 0.40),
                  ),
                ),
              _controller.isLoading && safeTab == 1
                  ? const Center(child: CircularProgressIndicator())
                  : pages[safeTab],
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: safeTab,
            onDestinationSelected: (index) =>
                setState(() => _selectedTab = index),
            destinations: destinations,
          ),
        );
      },
    );
  }
}
