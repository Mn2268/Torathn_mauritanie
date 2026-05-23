import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../l10n/app_localizations.dart';
import '../models/product.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    super.key,
    required this.products,
    required this.onAddProduct,
    required this.onUpdateProduct,
    required this.onDeleteProduct,
  });

  final List<Product> products;

  final Future<String> Function({
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
  })
  onAddProduct;

  final Future<String> Function({
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
  })
  onUpdateProduct;

  final Future<String> Function(int productId) onDeleteProduct;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _titleArController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _descriptionArController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController(text: '0');
  final _stockController = TextEditingController(text: '1');
  final _categoryController = TextEditingController();
  final _categoryArController = TextEditingController();
  bool _enableDiscount = false;
  bool _submitting = false;
  int? _editingProductId;

  Widget _buildPreviewImage(ThemeData theme) {
    final image = _imageUrlController.text.trim();
    if (image.isEmpty) {
      return const Center(child: Icon(Icons.image_outlined, size: 36));
    }
    if (image.startsWith('data:image') && image.contains(',')) {
      try {
        final raw = image.split(',').last;
        return Image.memory(base64Decode(raw), fit: BoxFit.cover);
      } catch (_) {
        return const Center(child: Icon(Icons.broken_image_outlined, size: 36));
      }
    }
    return Image.network(
      image,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) =>
          const Center(child: Icon(Icons.broken_image_outlined, size: 36)),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleArController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _categoryArController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) return;
    final file = picked.files.first;
    if (file.bytes == null) return;
    final ext = (file.extension ?? 'png').toLowerCase();
    final data = base64Encode(file.bytes!);
    _imageUrlController.text = 'data:image/$ext;base64,$data';
    setState(() {});
  }

  Future<void> _submit() async {
    final price = double.tryParse(_priceController.text.trim()) ?? -1;
    final discount = _enableDiscount
        ? int.tryParse(_discountController.text.trim()) ?? -1
        : 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? -1;

    setState(() => _submitting = true);
    final message = _editingProductId == null
        ? await widget.onAddProduct(
            imageUrl: _imageUrlController.text,
            title: _titleController.text,
            titleAr: _titleArController.text,
            description: _descriptionController.text,
            descriptionAr: _descriptionArController.text,
            price: price,
            discountPercent: discount,
            stock: stock,
            category: _categoryController.text.isEmpty
                ? 'Artisanat'
                : _categoryController.text,
            categoryAr: _categoryArController.text.isEmpty
                ? 'حرفة يدوية'
                : _categoryArController.text,
          )
        : await widget.onUpdateProduct(
            id: _editingProductId!,
            imageUrl: _imageUrlController.text,
            title: _titleController.text,
            titleAr: _titleArController.text,
            description: _descriptionController.text,
            descriptionAr: _descriptionArController.text,
            price: price,
            discountPercent: discount,
            stock: stock,
            category: _categoryController.text.isEmpty
                ? 'Artisanat'
                : _categoryController.text,
            categoryAr: _categoryArController.text.isEmpty
                ? 'حرفة يدوية'
                : _categoryArController.text,
          );
    if (!mounted) return;
    setState(() => _submitting = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    if (message.isNotEmpty) _resetForm();
  }

  void _resetForm() {
    _titleController.clear();
    _titleArController.clear();
    _imageUrlController.clear();
    _descriptionController.clear();
    _descriptionArController.clear();
    _priceController.clear();
    _discountController.text = '0';
    _stockController.text = '1';
    _categoryController.clear();
    _categoryArController.clear();
    _enableDiscount = false;
    _editingProductId = null;
    setState(() {});
  }

  void _startEdit(Product product) {
    _editingProductId = product.id;
    _titleController.text = product.title;
    _titleArController.text = product.titleAr;
    _imageUrlController.text = product.imageUrl;
    _descriptionController.text = product.description;
    _descriptionArController.text = product.descriptionAr;
    _priceController.text = product.price.toStringAsFixed(0);
    _discountController.text = product.discountPercent.toString();
    _stockController.text = product.stock.toString();
    _categoryController.text = product.category;
    _categoryArController.text = product.categoryAr;
    _enableDiscount = product.discountPercent > 0;
    setState(() {});
  }

  Future<void> _deleteProduct(int productId) async {
    final loc = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.translate('confirmDeleteTitle')),
        content: Text(loc.translate('confirmDeleteBody')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(loc.translate('close')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(loc.translate('yesDelete')),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final message = await widget.onDeleteProduct(productId);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final enteredPrice = double.tryParse(_priceController.text.trim()) ?? 0;
    final enteredDiscount = _enableDiscount
        ? (int.tryParse(_discountController.text.trim()) ?? 0).clamp(0, 90)
        : 0;
    final previewFinalPrice = enteredPrice * (1 - enteredDiscount / 100);
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF6C4AB6), Color(0xFF8D72E1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            loc.translate('adminDashboard'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _editingProductId == null
                      ? loc.translate('addProductTitle')
                      : loc.translate('editProduct'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: loc.translate('productTitle'),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleArController,
                  decoration: InputDecoration(
                    labelText: '${loc.translate('productTitle')} (عربي)',
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload_file_outlined),
                    label: Text(loc.translate('pickImage')),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    height: 150,
                    width: double.infinity,
                    child: _buildPreviewImage(theme),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: loc.translate('productDescription'),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionArController,
                  decoration: InputDecoration(
                    labelText: '${loc.translate('productDescription')} (عربي)',
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: loc.translate('productPrice'),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            value: _enableDiscount,
                            title: Text(loc.translate('enableDiscount')),
                            onChanged: (value) {
                              setState(() {
                                _enableDiscount = value;
                                if (!value) _discountController.text = '0';
                              });
                            },
                          ),
                          TextField(
                            controller: _discountController,
                            enabled: _enableDiscount,
                            decoration: InputDecoration(
                              labelText: '${loc.translate('discount')} %',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _stockController,
                        decoration: InputDecoration(
                          labelText: loc.translate('stock'),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                if (enteredPrice > 0) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    ),
                    child: Text(
                      enteredDiscount > 0
                          ? '${loc.translate('originalPrice')}: ${enteredPrice.toStringAsFixed(0)} MRU   |   ${loc.translate('finalPrice')}: ${previewFinalPrice.toStringAsFixed(0)} MRU'
                          : '${loc.translate('finalPrice')}: ${enteredPrice.toStringAsFixed(0)} MRU',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _submitting ? null : _submit,
                    icon: const Icon(Icons.add_box_outlined),
                    label: Text(
                      _submitting
                          ? '...'
                          : _editingProductId == null
                          ? loc.translate('addProductButton')
                          : loc.translate('updateProductButton'),
                    ),
                  ),
                ),
                if (_editingProductId != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton(
                      onPressed: _resetForm,
                      child: Text(loc.translate('cancelEdit')),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.translate('manageProductsTitle'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                if (widget.products.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(loc.translate('noProducts')),
                  )
                else
                  ...widget.products.map(
                    (product) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        leading: const CircleAvatar(
                          child: Icon(Icons.inventory_2_outlined),
                        ),
                        title: Text(product.title),
                        subtitle: Text(
                          product.discountPercent > 0
                              ? '${loc.translate('originalPrice')}: ${product.price.toStringAsFixed(0)} MRU | ${loc.translate('finalPrice')}: ${product.finalPrice.toStringAsFixed(0)} MRU - ${loc.translate('stock')}: ${product.stock}'
                              : '${loc.translate('finalPrice')}: ${product.finalPrice.toStringAsFixed(0)} MRU - ${loc.translate('stock')}: ${product.stock}',
                        ),
                        trailing: Wrap(
                          spacing: 6,
                          children: [
                            IconButton(
                              tooltip: loc.translate('editProduct'),
                              onPressed: () => _startEdit(product),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              tooltip: loc.translate('deleteProductButton'),
                              onPressed: () => _deleteProduct(product.id),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
