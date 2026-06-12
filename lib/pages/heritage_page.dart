import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class HeritagePage extends StatelessWidget {
  const HeritagePage({
    super.key,
    required this.titleAr,
    required this.titleFr,
    required this.subtitleAr,
    required this.subtitleFr,
    required this.icon,
    required this.color,
    required this.contentAr,
    required this.contentFr,
    required this.imageAssets,
    this.headerImageUrl,
    this.firestoreSection,
  });

  final String titleAr;
  final String titleFr;
  final String subtitleAr;
  final String subtitleFr;
  final IconData icon;
  final Color color;
  final List<Map<String, String>> contentAr;
  final List<Map<String, String>> contentFr;
  final List<String> imageAssets;
  final String? headerImageUrl;
  final String? firestoreSection;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final title = isAr ? titleAr : titleFr;
    final subtitle = isAr ? subtitleAr : subtitleFr;
    final content = isAr ? contentAr : contentFr;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800)),
              background: headerImageUrl != null && headerImageUrl!.isNotEmpty
                  ? Stack(fit: StackFit.expand, children: [
                      Image.network(headerImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: color)),
                      Container(color: color.withValues(alpha: 0.55)),
                    ])
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color, color.withValues(alpha: 0.7)],
                        ),
                      ),
                      child: Center(
                        child: Icon(icon,
                            size: 80,
                            color: Colors.white.withValues(alpha: 0.3)),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withValues(alpha: 0.2)),
                    ),
                    child: Text(subtitle,
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                            color: color.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 20),
                  // ── المحتوى الثابت ──
                  ...content.map((item) => _ContentCard(
                        title: item['title'] ?? '',
                        body: item['body'] ?? '',
                        imageUrl: item['imageUrl'],
                        color: color,
                      )),
                  // ── المحتوى من Firestore ──
                  if (firestoreSection != null)
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('heritage_items')
                          .where('section', isEqualTo: firestoreSection)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final docs = snapshot.data?.docs ?? [];
                        if (docs.isEmpty) return const SizedBox.shrink();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (content.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(children: [
                                  Expanded(
                                      child: Divider(
                                          color: color.withValues(alpha: 0.3))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      isAr
                                          ? 'محتوى إضافي'
                                          : 'Contenu supplémentaire',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: color.withValues(alpha: 0.6)),
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                          color: color.withValues(alpha: 0.3))),
                                ]),
                              ),
                            ...docs.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return _ContentCard(
                                title: isAr
                                    ? (data['titleAr'] ?? '')
                                    : (data['titleFr'] ?? ''),
                                body: isAr
                                    ? (data['bodyAr'] ?? '')
                                    : (data['bodyFr'] ?? ''),
                                imageUrl: data['imageUrl']?.toString(),
                                color: color,
                              );
                            }),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({
    required this.title,
    required this.body,
    required this.color,
    this.imageUrl,
  });

  final String title;
  final String body;
  final Color color;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null && imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl!.startsWith('data:image')
                  ? Image.memory(
                      base64Decode(imageUrl!.split(',').last),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    )
                  : Image.network(
                      imageUrl!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: color)),
                  ),
                ]),
                const SizedBox(height: 10),
                Text(body,
                    style: const TextStyle(
                        height: 1.7,
                        fontSize: 14,
                        color: Color(0xFF4D321D))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}