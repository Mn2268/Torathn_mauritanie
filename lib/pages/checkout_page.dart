import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/cart_item.dart';
import 'user_login_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.items,
    required this.totalPrice,
    required this.onPlaceOrder,
  });

  final List<CartItem> items;
  final double totalPrice;
  final Future<String> Function({
    required String name,
    required String phone,
    required String address,
  })
  onPlaceOrder;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final message = await widget.onPlaceOrder(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    if (widget.items.isEmpty) {
      return Center(child: Text(loc.translate('checkoutEmpty')));
    }

    // إذا المستخدم غير مسجل الدخول — اعرض صفحة تسجيل الدخول
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return UserLoginPage(onSuccess: () => setState(() {}));
    }

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        // معلومات المستخدم المسجل
        Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(user.email ?? ''),
            trailing: TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                setState(() {});
              },
              child: Text(loc.translate('logoutAdmin')),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.translate('summary')),
                const SizedBox(height: 8),
                ...widget.items.map(
                  (item) => Text(
                    '- ${item.product.title} x${item.quantity} '
                    '(${item.linePrice.toStringAsFixed(0)} MRU)',
                  ),
                ),
                const Divider(),
                Text(
                  '${loc.translate('totalToPay')}: ${widget.totalPrice.toStringAsFixed(0)} MRU',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: loc.translate('fullName')),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(labelText: loc.translate('phone')),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _addressController,
          decoration: InputDecoration(labelText: loc.translate('address')),
          minLines: 2,
          maxLines: 3,
        ),
        const SizedBox(height: 14),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: Text(
            _submitting
                ? loc.translate('sending')
                : loc.translate('confirmOrder'),
          ),
        ),
      ],
    );
  }
}
