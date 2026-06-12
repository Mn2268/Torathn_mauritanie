import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  final _hTitleController = TextEditingController();
  final _hTitleArController = TextEditingController();
  final _hBodyController = TextEditingController();
  final _hBodyArController = TextEditingController();
  final _hImageUrlController = TextEditingController();
  bool _hSubmitting = false;
  bool _hUploadingImage = false;
  String? _hImagePreviewUrl;
  String? _hEditingDocId;

  String _selectedSection = 'fashion';

  final _sections = const [
    {'key': 'fashion', 'labelAr': 'الأزياء التقليدية', 'labelFr': 'Mode'},
    {'key': 'handmade', 'labelAr': 'الصناعة اليدوية', 'labelFr': 'Artisanat'},
    {
      'key': 'traditions',
      'labelAr': 'العادات الموريتانية',
      'labelFr': 'Traditions',
    },
    {'key': 'oral', 'labelAr': 'التراث الشفهي', 'labelFr': 'Patrimoine oral'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    _hTitleController.dispose();
    _hTitleArController.dispose();
    _hBodyController.dispose();
    _hBodyArController.dispose();
    _hImageUrlController.dispose();
    super.dispose();
  }

  Widget _buildPreviewImage(ThemeData theme) {
    final image = _imageUrlController.text.trim();
    if (image.isEmpty)
      return const Center(child: Icon(Icons.image_outlined, size: 36));
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
      errorBuilder: (_, __, ___) =>
          const Center(child: Icon(Icons.broken_image_outlined, size: 36)),
    );
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

  Future<void> _pickHeritageImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxWidth: 800,
    );
    if (picked == null) return;
    setState(() => _hUploadingImage = true);
    try {
      final bytes = await picked.readAsBytes();
      final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      _hImageUrlController.text = base64Image;
      setState(() => _hImagePreviewUrl = null);
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Image chargée / تم تحميل الصورة')),
        );
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Erreur : $e')));
    }
    if (mounted) setState(() => _hUploadingImage = false);
  }

  Future<void> _submitHeritage(bool isAr) async {
    if (_hTitleController.text.isEmpty || _hBodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isAr
                ? 'يرجى ملء العنوان والمحتوى'
                : 'Veuillez remplir le titre et le contenu',
          ),
        ),
      );
      return;
    }
    setState(() => _hSubmitting = true);
    try {
      final data = {
        'titleFr': _hTitleController.text.trim(),
        'titleAr': _hTitleArController.text.trim(),
        'bodyFr': _hBodyController.text.trim(),
        'bodyAr': _hBodyArController.text.trim(),
        'imageUrl': _hImageUrlController.text.trim(),
        'section': _selectedSection,
        'createdAt': FieldValue.serverTimestamp(),
      };
      if (_hEditingDocId == null) {
        await FirebaseFirestore.instance.collection('heritage_items').add(data);
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isAr ? '✅ تمت الإضافة بنجاح' : '✅ Contenu ajouté avec succès',
              ),
            ),
          );
      } else {
        await FirebaseFirestore.instance
            .collection('heritage_items')
            .doc(_hEditingDocId)
            .update(data);
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isAr
                    ? '✅ تم التحديث بنجاح'
                    : '✅ Contenu mis à jour avec succès',
              ),
            ),
          );
      }
      _resetHeritageForm();
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ ${isAr ? 'خطأ' : 'Erreur'} : $e')),
        );
    }
    if (mounted) setState(() => _hSubmitting = false);
  }

  void _resetHeritageForm() {
    _hTitleController.clear();
    _hTitleArController.clear();
    _hBodyController.clear();
    _hBodyArController.clear();
    _hImageUrlController.clear();
    _hEditingDocId = null;
    _hImagePreviewUrl = null;
    setState(() {});
  }

  void _startEditHeritage(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    _hEditingDocId = doc.id;
    _hTitleController.text = data['titleFr'] ?? '';
    _hTitleArController.text = data['titleAr'] ?? '';
    _hBodyController.text = data['bodyFr'] ?? '';
    _hBodyArController.text = data['bodyAr'] ?? '';
    _hImageUrlController.text = data['imageUrl'] ?? '';
    _hImagePreviewUrl = (data['imageUrl'] ?? '').isNotEmpty
        ? data['imageUrl']
        : null;
    _selectedSection = data['section'] ?? 'fashion';
    setState(() {});
  }

  Future<void> _deleteHeritage(String docId, bool isAr) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isAr ? 'حذف العنصر' : 'Supprimer l\'élément'),
        content: Text(
          isAr
              ? 'هل أنت متأكد من حذف هذا العنصر؟'
              : 'Êtes-vous sûr de vouloir supprimer cet élément ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(isAr ? 'إلغاء' : 'Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(isAr ? 'حذف' : 'Supprimer'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await FirebaseFirestore.instance
        .collection('heritage_items')
        .doc(docId)
        .delete();
    if (mounted)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isAr ? '✅ تم الحذف' : '✅ Élément supprimé')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final enteredPrice = double.tryParse(_priceController.text.trim()) ?? 0;
    final enteredDiscount = _enableDiscount
        ? (int.tryParse(_discountController.text.trim()) ?? 0).clamp(0, 90)
        : 0;
    final previewFinalPrice = enteredPrice * (1 - enteredDiscount / 100);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
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
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.inventory_2_outlined),
              text: isAr ? 'المنتجات' : 'Produits',
            ),
            Tab(
              icon: const Icon(Icons.auto_stories_outlined),
              text: isAr ? 'التراث' : 'Patrimoine',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // ══ تاب المنتجات ══
              ListView(
                padding: const EdgeInsets.all(14),
                children: [
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
                              labelText:
                                  '${loc.translate('productTitle')} (عربي)',
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
                              color: theme.colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.5),
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
                              labelText:
                                  '${loc.translate('productDescription')} (عربي)',
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
                                      title: Text(
                                        loc.translate('enableDiscount'),
                                      ),
                                      onChanged: (value) => setState(() {
                                        _enableDiscount = value;
                                        if (!value)
                                          _discountController.text = '0';
                                      }),
                                    ),
                                    TextField(
                                      controller: _discountController,
                                      enabled: _enableDiscount,
                                      decoration: InputDecoration(
                                        labelText:
                                            '${loc.translate('discount')} %',
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
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.08,
                                ),
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
                                        tooltip: loc.translate(
                                          'deleteProductButton',
                                        ),
                                        onPressed: () =>
                                            _deleteProduct(product.id),
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
              ),

              // ══ تاب التراث ══
              ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _hEditingDocId == null
                                ? (isAr
                                      ? 'إضافة محتوى تراثي'
                                      : 'Ajouter un contenu patrimonial')
                                : (isAr
                                      ? 'تعديل المحتوى'
                                      : 'Modifier le contenu'),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // ── Dropdown مصلح ──
                          DropdownButtonFormField<String>(
                            value: _selectedSection,
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: isAr ? 'القسم' : 'Section',
                            ),
                            items: _sections
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s['key'],
                                    child: Text(
                                      isAr ? s['labelAr']! : s['labelFr']!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedSection = val!),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _hTitleController,
                            decoration: InputDecoration(
                              labelText: isAr
                                  ? 'العنوان (Français)'
                                  : 'Titre (Français)',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _hTitleArController,
                            decoration: InputDecoration(
                              labelText: isAr
                                  ? 'العنوان (عربي)'
                                  : 'Titre (Arabe)',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _hBodyController,
                            decoration: InputDecoration(
                              labelText: isAr
                                  ? 'المحتوى (Français)'
                                  : 'Contenu (Français)',
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _hBodyArController,
                            decoration: InputDecoration(
                              labelText: isAr
                                  ? 'المحتوى (عربي)'
                                  : 'Contenu (Arabe)',
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _hImageUrlController,
                            decoration: InputDecoration(
                              labelText: isAr
                                  ? 'رابط الصورة (اختياري)'
                                  : 'Lien image (optionnel)',
                              hintText: 'https://...',
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _hUploadingImage
                                  ? null
                                  : _pickHeritageImage,
                              icon: _hUploadingImage
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.photo_library_outlined),
                              label: Text(
                                _hUploadingImage
                                    ? (isAr
                                          ? 'جاري التحميل...'
                                          : 'Chargement...')
                                    : (isAr
                                          ? 'اختر صورة من الهاتف'
                                          : 'Choisir une photo'),
                              ),
                            ),
                          ),
                          if (_hImagePreviewUrl != null) ...[
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                _hImagePreviewUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                          ],
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _hSubmitting
                                  ? null
                                  : () => _submitHeritage(isAr),
                              icon: const Icon(Icons.save_outlined),
                              label: Text(
                                _hSubmitting
                                    ? '...'
                                    : _hEditingDocId == null
                                    ? (isAr ? 'إضافة' : 'Ajouter')
                                    : (isAr ? 'تحديث' : 'Mettre à jour'),
                              ),
                            ),
                          ),
                          if (_hEditingDocId != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: OutlinedButton(
                                onPressed: _resetHeritageForm,
                                child: Text(isAr ? 'إلغاء التعديل' : 'Annuler'),
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
                            isAr
                                ? 'المحتوى التراثي المضاف'
                                : 'Contenu patrimonial ajouté',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('heritage_items')
                                .orderBy('createdAt', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final docs = snapshot.data?.docs ?? [];
                              if (docs.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    isAr
                                        ? 'لا يوجد محتوى مضاف بعد'
                                        : 'Aucun contenu ajouté pour l\'instant',
                                  ),
                                );
                              }
                              return Column(
                                children: docs.map((doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  final section = _sections.firstWhere(
                                    (s) => s['key'] == data['section'],
                                    orElse: () => {
                                      'labelAr': '',
                                      'labelFr': data['section'] ?? '',
                                    },
                                  );
                                  final bodyText = isAr
                                      ? (data['bodyAr']?.toString() ?? '')
                                      : (data['bodyFr']?.toString() ?? '');
                                  final preview = bodyText.length > 40
                                      ? '${bodyText.substring(0, 40)}...'
                                      : bodyText;
                                  final titleText = isAr
                                      ? (data['titleAr'] ?? '')
                                      : (data['titleFr'] ?? '');
                                  final sectionLabel = isAr
                                      ? section['labelAr']
                                      : section['labelFr'];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color(
                                          0xFF8E4A24,
                                        ).withValues(alpha: 0.12),
                                        child: const Icon(
                                          Icons.auto_stories_outlined,
                                          color: Color(0xFF8E4A24),
                                        ),
                                      ),
                                      title: Text(titleText),
                                      subtitle: Text(
                                        '$sectionLabel — $preview',
                                      ),
                                      trailing: Wrap(
                                        spacing: 6,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                            onPressed: () =>
                                                _startEditHeritage(doc),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                            onPressed: () =>
                                                _deleteHeritage(doc.id, isAr),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
