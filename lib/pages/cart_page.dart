import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.items,
    required this.totalPrice,
    required this.onUpdateQuantity,
  });

  final List<CartItem> items;
  final double totalPrice;
  final void Function(Product product, int quantity) onUpdateQuantity;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    if (items.isEmpty) {
      return Center(child: Text(loc.translate('cartEmpty')));
    }

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        ...items.map((item) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.product.imageUrl.isEmpty
                    ? const Icon(Icons.inventory_2_outlined)
                    : item.product.imageUrl.startsWith('data:image')
                    ? Image.memory(
                        Uri.parse(item.product.imageUrl).data!.contentAsBytes(),
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : Image.network(
                        item.product.imageUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
              ),
              title: Text(item.product.title),
              subtitle: Text(
                '${item.product.finalPrice.toStringAsFixed(0)} MRU x '
                '${item.quantity} = ${item.linePrice.toStringAsFixed(0)} MRU',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () =>
                        onUpdateQuantity(item.product, item.quantity - 1),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('${item.quantity}'),
                  IconButton(
                    onPressed: () =>
                        onUpdateQuantity(item.product, item.quantity + 1),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        Text(
          '${loc.translate('total')}: ${totalPrice.toStringAsFixed(0)} MRU',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
