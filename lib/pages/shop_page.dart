import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({
    super.key,
    required this.products,
    required this.onAddToCart,
    this.errorMessage,
  });

  final List<Product> products;
  final void Function(Product product) onAddToCart;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final columns = width < 650 ? 2 : 3;
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inventory_2_outlined, size: 44),
              const SizedBox(height: 12),
              Text(
                loc.translate('shopEmpty'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  loc.translate('shopApiUnavailable'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: width < 650 ? 0.56 : 0.52,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 280 + (index * 40).clamp(0, 420)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 18),
                child: child,
              ),
            );
          },
          child: _TouchLift(
            onTap: () => onAddToCart(product),
            child: ProductCard(
              product: product,
              onAdd: () => onAddToCart(product),
            ),
          ),
        );
      },
    );
  }
}

class _TouchLift extends StatefulWidget {
  const _TouchLift({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_TouchLift> createState() => _TouchLiftState();
}

class _TouchLiftState extends State<_TouchLift> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _pressed ? const Offset(0, 0.012) : Offset.zero,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
