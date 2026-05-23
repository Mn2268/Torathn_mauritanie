import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class OralHeritagePage extends StatelessWidget {
  const OralHeritagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF8E4A24),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                isAr ? 'التراث الشفهي' : 'Patrimoine oral',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8E4A24), Color(0xFF6C3B1F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.record_voice_over_rounded,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeritageCard(
                    title: isAr ? 'الغِنى الحساني' : 'Le Ghina Hassani',
                    icon: Icons.music_note_rounded,
                    color: const Color(0xFF8E4A24),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => GhinaPage(isAr: isAr)),
                    ),
                  ),
                  _HeritageCard(
                    title: isAr ? 'الآلات الموسيقية' : 'Instruments de musique',
                    icon: Icons.queue_music_rounded,
                    color: const Color(0xFF6C3B1F),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InstrumentsPage(isAr: isAr),
                      ),
                    ),
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

class _HeritageCard extends StatelessWidget {
  const _HeritageCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: color),
        onTap: onTap,
      ),
    );
  }
}

// ── صفحة الغِنى الحساني ──────────────────────────────────────────────────────
class GhinaPage extends StatelessWidget {
  const GhinaPage({super.key, required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAr ? 'الغِنى الحساني' : 'Le Ghina Hassani'),
        backgroundColor: const Color(0xFF8E4A24),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoCard(
            title: isAr
                ? 'ما هو الغِنى الحساني؟'
                : 'Qu\'est-ce que le Ghina Hassani ?',
            body: isAr
                ? 'الغِنى الحساني هو الفن الموسيقي والشعري التقليدي عند المجتمع الحساني في موريتانيا، ويُعد جزءًا أساسيًا من الهوية الثقافية الموريتانية.\n\nيجمع بين الشعر، والإيقاع، والعزف على الآلات التقليدية مثل التيدينيت والآردين والطبل.\n\nيتميّز بالكلمات العميقة والألحان الهادئة المرتبطة بالصحراء والحياة البدوية.'
                : 'Le Ghina Hassani est l\'art musical et poétique traditionnel de la société hassanie en Mauritanie. Il fait partie intégrante de l\'identité culturelle mauritanienne.\n\nIl associe la poésie, le rythme et le jeu d\'instruments traditionnels comme le Tidinit, l\'Ardin et le tambour.\n\nIl se distingue par des paroles profondes et des mélodies douces liées au désert et à la vie nomade.',
          ),
          _InfoCard(
            title: isAr ? 'أشهر أنواعه' : 'Ses principaux genres',
            body: isAr
                ? '• الهول: الغناء التقليدي الكلاسيكي.\n• التبراع: شعر نسائي قصير يغلب عليه الغزل.\n• الگاف: أبيات شعبية تحمل الحكمة أو الوصف.\n• المديح: الإنشاد الديني ومدح النبي ﷺ.'
                : '• Al-Houl : le chant traditionnel classique.\n• At-Tebra : courte poésie féminine à dominante lyrique.\n• Al-Gaf : vers populaires portant sagesse ou description.\n• Al-Madih : chant religieux en louange du Prophète ﷺ.',
          ),
          _InfoCard(
            title: isAr ? 'من أشهر الفنانين' : 'Artistes célèbres',
            body: isAr
                ? '• ديمي منت آبه\n• المعلومة منت الميداح\n• محمد ولد أيده'
                : '• Dimi Mint Abba\n• El Maâlouma Mint El Meidah\n• Mohamed Ould Aïdah',
          ),
          _InfoCard(
            title: isAr ? 'مثال — مديح نبوي' : 'Exemple — Éloge prophétique',
            body: isAr
                ? 'رَايم شي هون ايلى رتام •• مافيه الكذب ابلا عظام\nنمـدح سيّد لنام هام •• بيـه الظاهر والخافِ\nاللِّ مرسول ارسول تام •• رِسالة بيهَ وافِ\nواعليَّ شكرُ فات شاع •• درتُ منُّ دون اتلافِ\nؤُ شكرُ كافيني زاد گاع •• مخلَّ شكرُ كافِ'
                : 'Extrait de poésie hassanie en louange du Prophète ﷺ :\n\n« Rāyim shi houn ilā ritām •• māfīh al-kadhib ablā \'idhām\nNamdah sayyid al-nām hām •• bīh adh-dhāhir wal-khāfī »\n\n(Nous louons le Maître des hommes, par qui l\'apparent et le caché sont connus)',
          ),
          _InfoCard(
            title: isAr ? 'مثال — التبراع' : 'Exemple — Tebra\'',
            body: isAr
                ? 'العهدْ ابّاشْ ابطَ يمتانْ\nوابّاشْ امْتانْ ابّاشْ ازْيانْ'
                : '« Al-\'ahd abbāsh abta\' ymtān\nwabbāsh amtān abbāsh azayān »\n\n(Poésie féminine hassanie — le Tebra\' est une forme de lyrisme spontané propre aux femmes)',
          ),
        ],
      ),
    );
  }
}

// ── صفحة الآلات الموسيقية ────────────────────────────────────────────────────
class InstrumentsPage extends StatelessWidget {
  const InstrumentsPage({super.key, required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAr ? 'الآلات الموسيقية' : 'Instruments de musique'),
        backgroundColor: const Color(0xFF6C3B1F),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InstrumentCard(
            name: 'Tidinit — التيدينيت',
            description: isAr
                ? 'آلة وترية تقليدية موريتانية تشبه العود، تُعزف باليد وتُصنع من الخشب والجلد. تُعدّ من أهم الآلات في الغناء الحساني.'
                : 'Instrument à cordes traditionnel mauritanien semblable à un luth, joué à la main et fabriqué en bois et cuir. C\'est l\'un des instruments les plus importants du Ghina Hassani.',
          ),
          _InstrumentCard(
            name: 'Ardin — الآردين',
            description: isAr
                ? 'آلة وترية نسائية بامتياز، تشبه القيثارة وتُعزف من قِبل النساء. تتميز بصوتها الرقيق وارتباطها بالتبراع.'
                : 'Instrument à cordes par excellence féminin, ressemblant à une harpe, joué par les femmes. Il se distingue par son son délicat et son lien avec le Tebra\'.',
          ),
          _InstrumentCard(
            name: 'Tambour — الطبل',
            description: isAr
                ? 'آلة إيقاعية جلدية تُستخدم في المناسبات والأفراح والسهرات الحسانية، وتضبط الإيقاع في الغناء الجماعي.'
                : 'Instrument de percussion en cuir utilisé lors des fêtes et soirées hassanies. Il rythme le chant collectif.',
          ),
          _InstrumentCard(
            name: 'Nifara — النيفارة',
            description: isAr
                ? 'آلة نفخية تقليدية تُصنع من الخشب، تُستخدم في بعض المناسبات والأعياد الموريتانية.'
                : 'Instrument à vent traditionnel fabriqué en bois, utilisé lors de certaines occasions et fêtes mauritaniennes.',
          ),
          _InstrumentCard(
            name: 'Arba — أرباب',
            description: isAr
                ? 'آلة وترية ذات وتر واحد، من أقدم الآلات الموريتانية، تُصنع يدوياً من الخشب والجلد.'
                : 'Instrument à une seule corde, parmi les plus anciens de Mauritanie, fabriqué à la main en bois et cuir.',
          ),
        ],
      ),
    );
  }
}

// ── بطاقة معلومات ─────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF8E4A24),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF8E4A24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              height: 1.8,
              fontSize: 14,
              color: Color(0xFF4D321D),
            ),
          ),
        ],
      ),
    );
  }
}

// ── بطاقة آلة موسيقية ────────────────────────────────────────────────────────
class _InstrumentCard extends StatelessWidget {
  const _InstrumentCard({
    required this.name,
    required this.description,
    this.imageUrl,
  });

  final String name;
  final String description;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 180,
                    width: double.infinity,
                    color: const Color(0xFF8E4A24).withValues(alpha: 0.08),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: Color(0xFF8E4A24),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Photo à venir — صورة قريباً',
                          style: TextStyle(color: Color(0xFF8E4A24)),
                        ),
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Color(0xFF6C3B1F),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    height: 1.7,
                    fontSize: 14,
                    color: Color(0xFF4D321D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
