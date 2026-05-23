import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(loc.translate('noOrders')));
        }
        final orders = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final data = orders[index].data() as Map<String, dynamic>;
            final items = (data['items'] as List<dynamic>? ?? []);
            final status = data['status'] ?? 'pending';
            final total = (data['total'] as num?)?.toDouble() ?? 0;
            final name = data['customer_name'] ?? '';
            final phone = data['customer_phone'] ?? '';
            final address = data['customer_address'] ?? '';
            final createdAt = data['createdAt'] as Timestamp?;
            final date = createdAt != null
                ? '${createdAt.toDate().day}/${createdAt.toDate().month}/${createdAt.toDate().year} ${createdAt.toDate().hour}:${createdAt.toDate().minute.toString().padLeft(2, '0')}'
                : '';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: status == 'pending'
                      ? Colors.orange.withValues(alpha: 0.15)
                      : Colors.green.withValues(alpha: 0.15),
                  child: Icon(
                    status == 'pending'
                        ? Icons.hourglass_empty
                        : Icons.check_circle,
                    color: status == 'pending' ? Colors.orange : Colors.green,
                  ),
                ),
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('${total.toStringAsFixed(0)} MRU — $date'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(loc.translate('confirmDeleteTitle')),
                        content: Text(loc.translate('confirmDeleteBody')),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(loc.translate('close')),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(loc.translate('yesDelete')),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orders[index].id)
                          .delete();
                    }
                  },
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        _infoRow(Icons.phone, phone),
                        _infoRow(Icons.location_on_outlined, address),
                        const SizedBox(height: 8),
                        Text(
                          loc.translate('products'),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        ...items.map((item) {
                          final i = item as Map<String, dynamic>;
                          return Text(
                            '• ${i['product_title']} x${i['quantity']} — ${(i['unit_price'] as num?)?.toStringAsFixed(0)} MRU',
                          );
                        }),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('${loc.translate('status')} : '),
                            DropdownButton<String>(
                              value: status,
                              items: [
                                DropdownMenuItem(
                                  value: 'pending',
                                  child: Text(loc.translate('pending')),
                                ),
                                DropdownMenuItem(
                                  value: 'confirmed',
                                  child: Text(loc.translate('confirmed')),
                                ),
                                DropdownMenuItem(
                                  value: 'delivered',
                                  child: Text(loc.translate('delivered')),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(orders[index].id)
                                      .update({'status': val});
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
