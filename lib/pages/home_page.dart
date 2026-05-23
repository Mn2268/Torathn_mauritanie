import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'heritage_page.dart';
import 'oral_heritage_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onOpenShop});

  final VoidCallback onOpenShop;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
      children: [
        _TouchLift(
          onTap: onOpenShop,
          child: _GlassHero(
            badge: loc.translate('heritageBadge'),
            title: loc.translate('heroTitle'),
            subtitle: loc.translate('heritageStory'),
            cta: loc.translate('openShop'),
            onOpenShop: onOpenShop,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeritagePage(
                      titleAr: 'الصناعة اليدوية',
                      titleFr: 'Artisanat',
                      subtitleAr:
                          'النحاس والجلد والنسيج اليدوي: قطع فريدة بروح موريتانية خالصة.',
                      subtitleFr:
                          'Cuivre, cuir et tissage artisanal : des créations uniques à l\'âme mauritanienne.',
                      icon: Icons.auto_awesome_rounded,
                      color: const Color(0xFF6C3B1F),
                      imageAssets: [],
                      contentAr: [
                        {
                          'title': 'الآلات الخشبية',
                          'body':
                              'من الآلات الخشبية التقليدية: التاديت، الگدحان، الراحلة. ومنها ألعاب كالسيگ وخشبة أكرور، تُصنع من خشب الشجر ولا تزال تُصنع حتى اليوم.',
                        },
                        {
                          'title': 'الفضة والنحاس',
                          'body':
                              'الفضة تُستخدم في صناعة الأواني وحلي النساء كالخواتم والخلاخل. والنحاس مستعمل في أبراريد أتاي والتاسوفرة.',
                        },
                        {
                          'title': 'النسيج',
                          'body':
                              'صناعة نسائية أصيلة، تخيط النساء الخيام من الوبر، والسجاد القديم، والحصائر من الأشجار كأزرم وغيره.',
                        },
                        {
                          'title': 'أتاي',
                          'body':
                              'الشاي الموريتاني المعروف بـ"أتاي" يُجهَّز على ثلاث مراحل ويتميز بالرغوة والتجمع. يُقدَّم للضيوف وهو وسيلة للتجمع وحكي الغناء الحساني.',
                        },
                        {
                          'title': 'ازريگ',
                          'body':
                              'مشروب موريتاني متوارث عبر الأجيال، يُقدَّم قبل أتاي للضيوف وهو من علامات إكرام الضيف. ويُعتبر الشعب الموريتاني من أكرم الشعوب.',
                        },
                      ],
                      contentFr: [
                        {
                          'title': 'Ustensiles en bois',
                          'body':
                              'Parmi les outils traditionnels en bois : le Tadit, le Gadhan, la Rahla. Et des jeux comme le Sig et la planche Akrour, fabriqués à partir du bois des arbres, encore produits aujourd\'hui.',
                        },
                        {
                          'title': 'Argent et cuivre',
                          'body':
                              'L\'argent est utilisé pour des ustensiles et bijoux féminins comme les bagues et bracelets. Le cuivre sert à fabriquer les théières (Brared Atay) et le Tassoufra.',
                        },
                        {
                          'title': 'Tissage',
                          'body':
                              'Art féminin authentique : les femmes tissent les tentes en poil de chameau, les vieux tapis et les nattes à partir d\'arbres comme l\'Azrm.',
                        },
                        {
                          'title': 'Atay',
                          'body':
                              'Le thé mauritanien "Atay" est préparé en trois étapes et se distingue par sa mousse. Il est servi aux invités et constitue un moment de rassemblement et de chant hassani.',
                        },
                        {
                          'title': 'Azrig',
                          'body':
                              'Boisson ancestrale mauritanienne, servie avant l\'Atay aux invités, signe d\'hospitalité. Le peuple mauritanien est réputé parmi les plus généreux.',
                        },
                      ],
                    ),
                  ),
                ),
                child: _StatPill(
                  icon: Icons.auto_awesome_rounded,
                  title: loc.translate('handmade'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeritagePage(
                      titleAr: 'الأزياء التقليدية',
                      titleFr: 'Mode traditionnelle',
                      subtitleAr:
                          'الملحفة والدراعة رمز أناقة موريتانية أصيلة وعابرة للزمن.',
                      subtitleFr:
                          'La Melha et la Daraa, symboles d\'une élégance mauritanienne authentique et intemporelle.',
                      icon: Icons.checkroom_rounded,
                      color: const Color(0xFFB07A46),
                      imageAssets: [],
                      contentAr: [
                        {
                          'title': 'الملحفة',
                          'body':
                              'الملحفة هي اللباس التقليدي للمرأة الموريتانية ولا تزال مستخدمة حتى يومنا هذا. من أنواعها القديمة النيلة وهي ملحفة سوداء ذات لون يلون جسد من تلبسه، ولا تزال مستخدمة في البوادي.',
                        },
                        {
                          'title': 'الدراعة',
                          'body':
                              'الدراعة هي الزي الرجالي التقليدي الموريتاني، ثوب فضفاض ولا يزال مستخدماً حتى يومنا هذا وهو الزي الرسمي للرجال. من أنواعه: الأزبي والشگة وغيرهما.',
                        },
                        {
                          'title': 'الحلي والمجوهرات',
                          'body':
                              'تشتهر موريتانيا بصياغة الفضة والذهب، وتتزين النساء بالأساور والخلاخل والقلائد المصنوعة يدوياً.',
                        },
                      ],
                      contentFr: [
                        {
                          'title': 'La Melha',
                          'body':
                              'La Melha est le vêtement traditionnel de la femme mauritanienne, encore porté aujourd\'hui. Parmi ses formes anciennes, la Nila est une melha noire dont la couleur teinte la peau, toujours utilisée dans les régions rurales.',
                        },
                        {
                          'title': 'La Daraa',
                          'body':
                              'La Daraa est le vêtement traditionnel masculin mauritanien, une longue robe ample encore portée aujourd\'hui comme tenue officielle. Parmi ses variantes : l\'Azbi, le Chagga et d\'autres.',
                        },
                        {
                          'title': 'Bijoux et ornements',
                          'body':
                              'La Mauritanie est réputée pour la joaillerie en argent et en or. Les femmes se parent de bracelets, de chevilles et de colliers faits à la main.',
                        },
                      ],
                    ),
                  ),
                ),
                child: _StatPill(
                  icon: Icons.palette_outlined,
                  title: loc.translate('traditionalFashion'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OralHeritagePage()),
                ),
                child: _StatPill(
                  icon: Icons.menu_book_rounded,
                  title: loc.translate('oralHeritage'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _TouchLift(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFB07A46).withValues(alpha: 0.40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              loc.translate('heritageIntro'),
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.65,
                color: const Color(0xFF4D321D),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _HeritageTile(
          icon: Icons.record_voice_over_rounded,
          color: const Color(0xFF8E4A24),
          title: loc.translate('oralHeritage'),
          subtitle: loc.translate('oralHeritageDescRich'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OralHeritagePage()),
          ),
        ),
        _HeritageTile(
          icon: Icons.checkroom_rounded,
          color: const Color(0xFFB07A46),
          title: loc.translate('traditionalFashion'),
          subtitle: loc.translate('traditionalFashionDescRich'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HeritagePage(
                titleAr: 'الأزياء التقليدية',
                titleFr: 'Mode traditionnelle',
                subtitleAr:
                    'الملحفة والدراعة رمز أناقة موريتانية أصيلة وعابرة للزمن.',
                subtitleFr:
                    'La Melha et la Daraa, symboles d\'une élégance mauritanienne authentique et intemporelle.',
                icon: Icons.checkroom_rounded,
                color: const Color(0xFFB07A46),
                imageAssets: [],
                contentAr: [
                  {
                    'title': 'الملحفة',
                    'body':
                        'الملحفة هي اللباس التقليدي للمرأة الموريتانية ولا تزال مستخدمة حتى يومنا هذا. من أنواعها القديمة النيلة وهي ملحفة سوداء ذات لون يلون جسد من تلبسه، ولا تزال مستخدمة في البوادي.',
                  },
                  {
                    'title': 'الدراعة',
                    'body':
                        'الدراعة هي الزي الرجالي التقليدي الموريتاني، ثوب فضفاض ولا يزال مستخدماً حتى يومنا هذا وهو الزي الرسمي للرجال. من أنواعه: الأزبي والشگة وغيرهما.',
                  },
                  {
                    'title': 'الحلي والمجوهرات',
                    'body':
                        'تشتهر موريتانيا بصياغة الفضة والذهب، وتتزين النساء بالأساور والخلاخل والقلائد المصنوعة يدوياً.',
                  },
                ],
                contentFr: [
                  {
                    'title': 'La Melha',
                    'body':
                        'La Melha est le vêtement traditionnel de la femme mauritanienne, encore porté aujourd\'hui. Parmi ses formes anciennes, la Nila est une melha noire dont la couleur teinte la peau, toujours utilisée dans les régions rurales.',
                  },
                  {
                    'title': 'La Daraa',
                    'body':
                        'La Daraa est le vêtement traditionnel masculin mauritanien, une longue robe ample encore portée aujourd\'hui comme tenue officielle. Parmi ses variantes : l\'Azbi, le Chagga et d\'autres.',
                  },
                  {
                    'title': 'Bijoux et ornements',
                    'body':
                        'La Mauritanie est réputée pour la joaillerie en argent et en or. Les femmes se parent de bracelets, de chevilles et de colliers faits à la main.',
                  },
                ],
              ),
            ),
          ),
        ),
        _HeritageTile(
          icon: Icons.auto_awesome_rounded,
          color: const Color(0xFF6C3B1F),
          title: loc.translate('handmade'),
          subtitle: loc.translate('handmadeDescRich'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HeritagePage(
                titleAr: 'الصناعة اليدوية',
                titleFr: 'Artisanat',
                subtitleAr:
                    'النحاس والجلد والنسيج اليدوي: قطع فريدة بروح موريتانية خالصة.',
                subtitleFr:
                    'Cuivre, cuir et tissage artisanal : des créations uniques à l\'âme mauritanienne.',
                icon: Icons.auto_awesome_rounded,
                color: const Color(0xFF6C3B1F),
                imageAssets: [],
                contentAr: [
                  {
                    'title': 'الآلات الخشبية',
                    'body':
                        'من الآلات الخشبية التقليدية: التاديت، الگدحان، الراحلة. ومنها ألعاب كالسيگ وخشبة أكرور، تُصنع من خشب الشجر ولا تزال تُصنع حتى اليوم.',
                  },
                  {
                    'title': 'الفضة والنحاس',
                    'body':
                        'الفضة تُستخدم في صناعة الأواني وحلي النساء كالخواتم والخلاخل. والنحاس مستعمل في أبراريد أتاي والتاسوفرة.',
                  },
                  {
                    'title': 'النسيج',
                    'body':
                        'صناعة نسائية أصيلة، تخيط النساء الخيام من الوبر، والسجاد القديم، والحصائر من الأشجار كأزرم وغيره.',
                  },
                  {
                    'title': 'أتاي',
                    'body':
                        'الشاي الموريتاني المعروف بـ"أتاي" يُجهَّز على ثلاث مراحل ويتميز بالرغوة والتجمع. يُقدَّم للضيوف وهو وسيلة للتجمع وحكي الغناء الحساني والسهر.',
                  },
                  {
                    'title': 'ازريگ',
                    'body':
                        'مشروب موريتاني متوارث عبر الأجيال، يُقدَّم قبل أتاي للضيوف وهو من علامات إكرام الضيف. ويُعتبر الشعب الموريتاني من أكرم الشعوب وأبسطها.',
                  },
                ],
                contentFr: [
                  {
                    'title': 'Ustensiles en bois',
                    'body':
                        'Parmi les outils traditionnels en bois : le Tadit, le Gadhan, la Rahla. Et des jeux comme le Sig et la planche Akrour, fabriqués à partir du bois des arbres, encore produits aujourd\'hui.',
                  },
                  {
                    'title': 'Argent et cuivre',
                    'body':
                        'L\'argent est utilisé pour des ustensiles et bijoux féminins comme les bagues et bracelets. Le cuivre sert à fabriquer les théières (Brared Atay) et le Tassoufra.',
                  },
                  {
                    'title': 'Tissage',
                    'body':
                        'Art féminin authentique : les femmes tissent les tentes en poil de chameau, les vieux tapis et les nattes à partir d\'arbres comme l\'Azrm.',
                  },
                  {
                    'title': 'Atay',
                    'body':
                        'Le thé mauritanien "Atay" est préparé en trois étapes et se distingue par sa mousse. Il est servi aux invités et constitue un moment de rassemblement et de chant hassani.',
                  },
                  {
                    'title': 'Azrig',
                    'body':
                        'Boisson ancestrale mauritanienne, servie avant l\'Atay aux invités, signe d\'hospitalité. Le peuple mauritanien est réputé parmi les plus généreux.',
                  },
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeritageTile extends StatelessWidget {
  const _HeritageTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _TouchLift(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios, size: 14, color: color),
        ),
      ),
    );
  }
}

class _GlassHero extends StatelessWidget {
  const _GlassHero({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.onOpenShop,
  });

  final String badge;
  final String title;
  final String subtitle;
  final String cta;
  final VoidCallback onOpenShop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withValues(alpha: 0.30),
            const Color(0xFF5D3018).withValues(alpha: 0.40),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.17),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: onOpenShop,
            icon: const Icon(Icons.storefront_rounded),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE4B07A),
              foregroundColor: const Color(0xFF402714),
            ),
            label: Text(cta),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFB07A46).withValues(alpha: 0.28),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8E4A24), size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: Color(0xFF4D321D),
            ),
          ),
        ],
      ),
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
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _pressed ? const Offset(0, 0.01) : Offset.zero,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
