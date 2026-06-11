import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    this.isAdmin = false,
  });

  final Product product;
  final VoidCallback onAdd;
  final bool isAdmin;

  Widget _buildProductImage(ThemeData theme) {
    final image = product.imageUrl.trim();
    if (image.startsWith('data:image') && image.contains(',')) {
      try {
        final raw = image.split(',').last;
        return Image.memory(base64Decode(raw), fit: BoxFit.cover);
      } catch (_) {}
    }
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined),
      ),
      memCacheWidth: 400,
      memCacheHeight: 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final currentLocale = loc.locale.languageCode;

    final title = product.getLocalizedTitle(currentLocale);
    final description = product.getLocalizedDescription(currentLocale);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.42),
            const Color(0xFFF3E4D2).withValues(alpha: 0.30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withValues(alpha: 0.24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (product.discountPercent > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            '-${product.discountPercent}%',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 0.82,
                      child: _buildProductImage(theme),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 0.5),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 6,
                        height: 1,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (product.discountPercent > 0) ...[
                    Text(
                      '${product.price.toStringAsFixed(0)} MRU',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 7,
                        decoration: TextDecoration.lineThrough,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 0.5),
                  ],
                  Text(
                    '${product.finalPrice.toStringAsFixed(0)} MRU',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 9,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${loc.translate('stock')}: ${product.stock}',
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 6.5),
                  ),
                  const SizedBox(height: 3),
                  // ── زر Ajouter للمستخدم فقط ──
                  if (!isAdmin)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: product.stock > 0 ? onAdd : null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(22),
                          padding: EdgeInsets.zero,
                          textStyle: const TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Text(
                          product.stock > 0
                              ? loc.translate('add')
                              : loc.translate('outOfStock'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}