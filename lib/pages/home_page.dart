import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'heritage_page.dart';
import 'oral_heritage_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onOpenShop});

  final VoidCallback onOpenShop;

  HeritagePage _buildTraditionsPage() => HeritagePage(
    titleAr: 'العادات الموريتانية',
    titleFr: 'Traditions mauritaniennes',
    subtitleAr: 'مزيج فريد من الأصول العربية والإسلامية والامتداد الإفريقي يمنح الثقافة الموريتانية طابعًا غنيًا.',
    subtitleFr: 'Un mélange unique d\'origines arabes, islamiques et africaines confère à la culture mauritanienne une richesse exceptionnelle.',
    icon: Icons.coffee_rounded,
    color: const Color(0xFF8E4A24),
    imageAssets: [],
    firestoreSection: 'traditions',
    headerImageUrl: 'https://www.nawa3em.com/UserFiles/005-martnya%20(2).jpg',
    contentAr: [
      {'title': 'الكرم والضيافة', 'body': 'يُعرف الموريتانيون بكرمهم الكبير خاصة في البيئات البدوية. يُستقبل الزائر بحرارة ويحرص المضيف على تقديم الطعام فور وصول الضيف مهما كان وقت قدومه.'},
      {'title': 'أتاي', 'body': 'الشاي الموريتاني عنصر أساسي في الضيافة، يُقدَّم في ثلاث جولات: الجمر، الجماعة، الجر. ولا يخلو منه أي منزل موريتاني.', 'imageUrl': 'https://i.pinimg.com/736x/fe/bd/fc/febdfc4b126a3c0455c54e75e35cc044.jpg'},
      {'title': 'ازريگ', 'body': 'مشروب موريتاني متوارث عبر الأجيال، يُقدَّم قبل أتاي للضيوف وهو من أول علامات إكرام الضيف. مكوّن من الحليب والماء والسكر.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCI0V25MLOwxdajN9Ki20CZvtOpetEKMlnLw&s'},
      {'title': 'المحظرة', 'body': 'المحظرة هي المدرسة التقليدية الموريتانية التي تعتمد على الألواح الخشبية لتعليم القرآن الكريم والعلوم الإسلامية. وتُعدّ ركيزة أساسية في الحفاظ على الموروث العلمي والديني.', 'imageUrl': 'https://th.bing.com/th/id/R.0627494839fcfb547df18b5c5fa83e52?rik=%2fCipkorwl00xnA&riu=http%3a%2f%2fallarab.info%2fsites%2fdefault%2ffiles%2ffield%2fimage%2fmauritania_0.jpg&ehk=GsIFE37nmUMpI5IFyYp%2fAUfG84R4Ue3ZkiLKjgwAG9U%3d&risl=&pid=ImgRaw&r=0'},
      {'title': 'المطبخ الموريتاني', 'body': 'يعتمد المطبخ الموريتاني على الأرز واللحوم والأسماك. من أبرز الأطباق: المارو والحوت، والكسكسي الموريتاني بمسحوق الملوخية والتوابل المحلية.', 'imageUrl': 'https://againstthecompass.com/wp-content/uploads/2021/03/mauritania-cuisine.jpg'},
    ],
    contentFr: [
      {'title': 'Générosité et hospitalité', 'body': 'Les Mauritaniens sont connus pour leur grande générosité. L\'hôte accueille chaleureusement ses invités et s\'empresse de leur offrir à manger dès leur arrivée.'},
      {'title': 'Atay', 'body': 'Le thé mauritanien est servi en trois tournées successives et présent dans chaque foyer mauritanien. Il est un moment de rassemblement et de chant hassani.', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.jJyHRUreQjKw9STbhn06-wHaJQ?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
      {'title': 'Azrig', 'body': 'Boisson ancestrale composée de lait, d\'eau et de sucre, servie avant l\'Atay comme premier signe d\'hospitalité.', 'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCI0V25MLOwxdajN9Ki20CZvtOpetEKMlnLw&s'},
      {'title': 'La Mahdara', 'body': 'École traditionnelle utilisant des tablettes en bois pour enseigner le Coran et les sciences islamiques. Pilier fondamental du patrimoine scientifique et religieux mauritanien.', 'imageUrl': 'https://th.bing.com/th/id/R.0627494839fcfb547df18b5c5fa83e52?rik=%2fCipkorwl00xnA&riu=http%3a%2f%2fallarab.info%2fsites%2fdefault%2ffiles%2ffield%2fimage%2fmauritania_0.jpg&ehk=GsIFE37nmUMpI5IFyYp%2fAUfG84R4Ue3ZkiLKjgwAG9U%3d&risl=&pid=ImgRaw&r=0'},
      {'title': 'Cuisine mauritanienne', 'body': 'La cuisine repose sur le riz, les viandes et les poissons. Plats emblématiques : le Marou, le Hout, et le couscous mauritanien aux épices locales.', 'imageUrl': 'https://againstthecompass.com/wp-content/uploads/2021/03/mauritania-cuisine.jpg'},
    ],
  );

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

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
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => HeritagePage(
                    titleAr: 'الصناعة اليدوية',
                    titleFr: 'Artisanat',
                    subtitleAr: 'النحاس والجلد والنسيج اليدوي: قطع فريدة بروح موريتانية خالصة.',
                    subtitleFr: 'Cuivre, cuir et tissage artisanal : des créations uniques à l\'âme mauritanienne.',
                    icon: Icons.auto_awesome_rounded,
                    color: const Color(0xFF6C3B1F),
                    imageAssets: [],
                    firestoreSection: 'handmade',
                    headerImageUrl: 'https://th.bing.com/th/id/R.575010ce9293c7b2e2c7215e543e8a59?rik=skutlq8Pwg5a3Q&pid=ImgRaw&r=0',
                    contentAr: [
                      {'title': 'الآلات الخشبية', 'body': 'من الآلات الخشبية التقليدية: التاديت، الگدحان، الراحلة. ومنها ألعاب كالسيگ وخشبة أكرور، تُصنع من خشب الشجر ولا تزال تُصنع حتى اليوم.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.r0ub_ePcUGD6TxQVTL8dIAAAAA?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                      {'title': 'الفضة والنحاس', 'body': 'الفضة تُستخدم في صناعة الأواني وحلي النساء كالخواتم والخلاخل. والنحاس مستعمل في أبراريد أتاي والتاسوفرة.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.BxYQC5dfDTGZtvKiXixBeAHaHR?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                      {'title': 'النسيج', 'body': 'صناعة نسائية أصيلة، تخيط النساء الخيام من الوبر، والسجاد القديم، والحصائر من الأشجار كأزرم وغيره.', 'imageUrl': 'https://th.bing.com/th/id/R.449cd1f0f12b5f270c81f02cc8a1b61b?rik=N7FxKJQ3Xh%2fcCA&pid=ImgRaw&r=0'},
                    ],
                    contentFr: [
                      {'title': 'Ustensiles en bois', 'body': 'Parmi les outils traditionnels en bois : le Tadit, le Gadhan, la Rahla. Et des jeux comme le Sig et la planche Akrour, encore produits aujourd\'hui.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.r0ub_ePcUGD6TxQVTL8dIAAAAA?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                      {'title': 'Argent et cuivre', 'body': 'L\'argent est utilisé pour des ustensiles et bijoux féminins. Le cuivre sert à fabriquer les théières (Brared Atay) et le Tassoufra.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.BxYQC5dfDTGZtvKiXixBeAHaHR?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                      {'title': 'Tissage', 'body': 'Art féminin authentique : les femmes tissent les tentes en poil de chameau, les vieux tapis et les nattes.', 'imageUrl': 'https://th.bing.com/th/id/R.449cd1f0f12b5f270c81f02cc8a1b61b?rik=N7FxKJQ3Xh%2fcCA&pid=ImgRaw&r=0'},
                    ],
                  ),
                )),
                child: _StatPill(icon: Icons.auto_awesome_rounded, title: loc.translate('handmade')),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => HeritagePage(
                    titleAr: 'الأزياء التقليدية',
                    titleFr: 'Mode traditionnelle',
                    subtitleAr: 'الملحفة والدراعة رمز أناقة موريتانية أصيلة وعابرة للزمن.',
                    subtitleFr: 'La Melha et la Daraa, symboles d\'une élégance mauritanienne authentique.',
                    icon: Icons.checkroom_rounded,
                    color: const Color(0xFFB07A46),
                    imageAssets: [],
                    firestoreSection: 'fashion',
                    headerImageUrl: 'https://i.pinimg.com/736x/22/8a/ab/228aab742bd9fdae731a9cb6440f7c6d.jpg',
                    contentAr: [
                      {'title': 'الملحفة', 'body': 'الملحفة هي اللباس التقليدي للمرأة الموريتانية ولا تزال مستخدمة حتى يومنا هذا. من أنواعها القديمة النيلة وهي ملحفة سوداء ولا تزال مستخدمة في البوادي.', 'imageUrl': 'https://i.pinimg.com/736x/67/59/12/6759124fc155ffed10eb2154a4dd191b.jpg'},
                      {'title': 'الدراعة', 'body': 'الدراعة هي الزي الرجالي التقليدي الموريتاني، ثوب فضفاض وهو الزي الرسمي للرجال. من أنواعه: الأزبي والشگة وغيرهما.', 'imageUrl': 'https://i.pinimg.com/736x/9a/21/05/9a21053df11d9e3bb51f80aaeccf3b35.jpg'},
                      {'title': 'الحلي والمجوهرات', 'body': 'تشتهر موريتانيا بصياغة الفضة والذهب، وتتزين النساء بالأساور والخلاخل والقلائد المصنوعة يدوياً.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.cd3eoiG5i7T-_3kcntJHLgHaNK?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                    ],
                    contentFr: [
                      {'title': 'La Melha', 'body': 'La Melha est le vêtement traditionnel de la femme mauritanienne. La Nila est une melha noire toujours utilisée dans les régions rurales.', 'imageUrl': 'https://i.pinimg.com/736x/67/59/12/6759124fc155ffed10eb2154a4dd191b.jpg'},
                      {'title': 'La Daraa', 'body': 'La Daraa est le vêtement traditionnel masculin mauritanien, une longue robe ample. Parmi ses variantes : l\'Azbi, le Chagga et d\'autres.', 'imageUrl': 'https://i.pinimg.com/736x/9a/21/05/9a21053df11d9e3bb51f80aaeccf3b35.jpg'},
                      {'title': 'Bijoux et ornements', 'body': 'La Mauritanie est réputée pour la joaillerie en argent et en or. Les femmes se parent de bracelets et de colliers faits à la main.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.cd3eoiG5i7T-_3kcntJHLgHaNK?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                    ],
                  ),
                )),
                child: _StatPill(icon: Icons.palette_outlined, title: loc.translate('traditionalFashion')),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const OralHeritagePage())),
                child: _StatPill(icon: Icons.menu_book_rounded, title: loc.translate('oralHeritage')),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TouchLift(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => _buildTraditionsPage())),
                child: _StatPill(icon: Icons.coffee_rounded, title: isAr ? 'العادات' : 'Traditions'),
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
              border: Border.all(color: const Color(0xFFB07A46).withValues(alpha: 0.40)),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 6))],
            ),
            child: Text(loc.translate('heritageIntro'),
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.65, color: const Color(0xFF4D321D))),
          ),
        ),
        const SizedBox(height: 12),
        _HeritageTile(
          icon: Icons.record_voice_over_rounded,
          color: const Color(0xFF8E4A24),
          title: loc.translate('oralHeritage'),
          subtitle: loc.translate('oralHeritageDescRich'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const OralHeritagePage())),
        ),
        _HeritageTile(
          icon: Icons.checkroom_rounded,
          color: const Color(0xFFB07A46),
          title: loc.translate('traditionalFashion'),
          subtitle: loc.translate('traditionalFashionDescRich'),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => HeritagePage(
              titleAr: 'الأزياء التقليدية',
              titleFr: 'Mode traditionnelle',
              subtitleAr: 'الملحفة والدراعة رمز أناقة موريتانية أصيلة وعابرة للزمن.',
              subtitleFr: 'La Melha et la Daraa, symboles d\'une élégance mauritanienne authentique.',
              icon: Icons.checkroom_rounded,
              color: const Color(0xFFB07A46),
              imageAssets: [],
              firestoreSection: 'fashion',
              headerImageUrl: 'https://i.pinimg.com/736x/22/8a/ab/228aab742bd9fdae731a9cb6440f7c6d.jpg',
              contentAr: [
                {'title': 'الملحفة', 'body': 'الملحفة هي اللباس التقليدي للمرأة الموريتانية ولا تزال مستخدمة حتى يومنا هذا. من أنواعها القديمة النيلة وهي ملحفة سوداء ولا تزال مستخدمة في البوادي.', 'imageUrl': 'https://i.pinimg.com/736x/67/59/12/6759124fc155ffed10eb2154a4dd191b.jpg'},
                {'title': 'الدراعة', 'body': 'الدراعة هي الزي الرجالي التقليدي الموريتاني، ثوب فضفاض وهو الزي الرسمي للرجال. من أنواعه: الأزبي والشگة وغيرهما.', 'imageUrl': 'https://i.pinimg.com/736x/9a/21/05/9a21053df11d9e3bb51f80aaeccf3b35.jpg'},
                {'title': 'الحلي والمجوهرات', 'body': 'تشتهر موريتانيا بصياغة الفضة والذهب، وتتزين النساء بالأساور والخلاخل والقلائد المصنوعة يدوياً.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.cd3eoiG5i7T-_3kcntJHLgHaNK?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
              ],
              contentFr: [
                {'title': 'La Melha', 'body': 'La Melha est le vêtement traditionnel de la femme mauritanienne. La Nila est une melha noire toujours utilisée dans les régions rurales.', 'imageUrl': 'https://i.pinimg.com/736x/67/59/12/6759124fc155ffed10eb2154a4dd191b.jpg'},
                {'title': 'La Daraa', 'body': 'La Daraa est le vêtement traditionnel masculin mauritanien. Parmi ses variantes : l\'Azbi, le Chagga et d\'autres.', 'imageUrl': 'https://i.pinimg.com/736x/9a/21/05/9a21053df11d9e3bb51f80aaeccf3b35.jpg'},
                {'title': 'Bijoux et ornements', 'body': 'La Mauritanie est réputée pour la joaillerie en argent et en or. Les femmes se parent de bracelets et de colliers faits à la main.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.cd3eoiG5i7T-_3kcntJHLgHaNK?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
              ],
            ),
          )),
        ),
        _HeritageTile(
          icon: Icons.auto_awesome_rounded,
          color: const Color(0xFF6C3B1F),
          title: loc.translate('handmade'),
          subtitle: loc.translate('handmadeDescRich'),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => HeritagePage(
              titleAr: 'الصناعة اليدوية',
              titleFr: 'Artisanat',
              subtitleAr: 'النحاس والجلد والنسيج اليدوي: قطع فريدة بروح موريتانية خالصة.',
              subtitleFr: 'Cuivre, cuir et tissage artisanal : des créations uniques à l\'âme mauritanienne.',
              icon: Icons.auto_awesome_rounded,
              color: const Color(0xFF6C3B1F),
              imageAssets: [],
              firestoreSection: 'handmade',
              headerImageUrl: 'https://th.bing.com/th/id/R.575010ce9293c7b2e2c7215e543e8a59?rik=skutlq8Pwg5a3Q&pid=ImgRaw&r=0',
              contentAr: [
                {'title': 'الآلات الخشبية', 'body': 'من الآلات الخشبية التقليدية: التاديت، الگدحان، الراحلة. ومنها ألعاب كالسيگ وخشبة أكرور، ولا تزال تُصنع حتى اليوم.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.r0ub_ePcUGD6TxQVTL8dIAAAAA?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                {'title': 'الفضة والنحاس', 'body': 'الفضة تُستخدم في صناعة الأواني وحلي النساء. والنحاس مستعمل في أبراريد أتاي والتاسوفرة.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.BxYQC5dfDTGZtvKiXixBeAHaHR?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                {'title': 'النسيج', 'body': 'صناعة نسائية أصيلة، تخيط النساء الخيام من الوبر، والسجاد القديم، والحصائر من الأشجار.', 'imageUrl': 'https://th.bing.com/th/id/R.449cd1f0f12b5f270c81f02cc8a1b61b?rik=N7FxKJQ3Xh%2fcCA&pid=ImgRaw&r=0'},
              ],
              contentFr: [
                {'title': 'Ustensiles en bois', 'body': 'Parmi les outils traditionnels en bois : le Tadit, le Gadhan, la Rahla. Et des jeux comme le Sig et la planche Akrour.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.r0ub_ePcUGD6TxQVTL8dIAAAAA?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                {'title': 'Argent et cuivre', 'body': 'L\'argent pour les bijoux féminins. Le cuivre pour les théières (Brared Atay) et le Tassoufra.', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.BxYQC5dfDTGZtvKiXixBeAHaHR?r=0&cb=thfvnextfalcon2&rs=1&pid=ImgDetMain&o=7&rm=3'},
                {'title': 'Tissage', 'body': 'Art féminin authentique : tentes en poil de chameau, vieux tapis et nattes traditionnelles.', 'imageUrl': 'https://th.bing.com/th/id/R.449cd1f0f12b5f270c81f02cc8a1b61b?rik=N7FxKJQ3Xh%2fcCA&pid=ImgRaw&r=0'},
              ],
            ),
          )),
        ),
        _HeritageTile(
          icon: Icons.coffee_rounded,
          color: const Color(0xFF8E4A24),
          title: isAr ? 'العادات الموريتانية' : 'Traditions mauritaniennes',
          subtitle: isAr ? 'الكرم، الأتاي، المحظرة والمطبخ' : 'Hospitalité, Atay, Mahdara et cuisine',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => _buildTraditionsPage())),
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
            child: Text(badge,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.w900, height: 1.1)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 14, height: 1.5)),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: onOpenShop,
            icon: const Icon(Icons.storefront_rounded),
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE4B07A),
                foregroundColor: const Color(0xFF402714)),
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
        border: Border.all(color: const Color(0xFFB07A46).withValues(alpha: 0.28)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8E4A24), size: 20),
          const SizedBox(height: 4),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xFF4D321D))),
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