import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const _localizedValues = <String, Map<String, String>>{
    'fr': {
      'appTitle': 'Patrimoine Mauritanien',
      'cart': 'Panier',
      'welcome': 'Bienvenue',
      'products': 'Produits',
      'checkout': 'Commander',
      'admin': 'Admin',
      'openShop': 'Entrer dans la boutique',
      'heroTitle': 'Decouvrez l\'heritage mauritanien',
      'heroSubtitle':
          'Explorez des pieces artisanales uniques, ajoutez-les au panier et commandez en quelques clics.',
      'oralHeritage': 'Patrimoine oral',
      'oralHeritageDesc':
          'Contes et poesie qui racontent l\'identite mauritanienne.',
      'traditionalFashion': 'Mode traditionnelle',
      'traditionalFashionDesc': 'Couleurs du desert et elegance authentique.',
      'handmade': 'Artisanat',
      'handmadeDesc': 'Produits fabriques avec soin par des artisans locaux.',
      'stock': 'Stock',
      'add': 'Ajouter',
      'outOfStock': 'Rupture',
      'cartEmpty': 'Votre panier est vide.',
      'total': 'Total',
      'checkoutEmpty': 'Ajoutez des articles au panier avant de commander.',
      'summary': 'Recapitulatif',
      'totalToPay': 'Total a payer',
      'fullName': 'Nom complet',
      'phone': 'Telephone',
      'address': 'Adresse',
      'sending': 'Envoi...',
      'confirmOrder': 'Confirmer la commande',
      'language': 'Langue',
      'logoutAdmin': 'Deconnexion admin',
      'adminLoggedOut': 'Vous etes deconnecte du mode admin.',
      'loginSuccess': 'Connexion reussie.',
      'loginFailed': 'Identifiants invalides.',
      'adminLoginTitle': 'Connexion administrateur',
      'demoCredentials': 'Compte demo: admin / 1234',
      'username': 'Nom utilisateur',
      'password': 'Mot de passe',
      'login': 'Se connecter',
      'adminDashboard': 'Tableau de bord administrateur',
      'addProductTitle': 'Ajouter un produit',
      'manageProductsTitle': 'Gerer les produits',
      'productTitle': 'Titre',
      'productImageUrl': 'URL image produit',
      'productDescription': 'Description courte',
      'productCategory': 'Categorie',
      'productIcon': 'Icone (emoji)',
      'productPrice': 'Prix',
      'discount': 'Remise',
      'enableDiscount': 'Activer remise',
      'addProductButton': 'Ajouter le produit',
      'updateProductButton': 'Mettre a jour',
      'deleteProductButton': 'Supprimer',
      'cancelEdit': 'Annuler modification',
      'noProducts': 'Aucun produit disponible.',
      'editProduct': 'Modifier',
      'confirmDeleteTitle': 'Confirmation suppression',
      'confirmDeleteBody': 'Supprimer ce produit ?',
      'yesDelete': 'Oui, supprimer',
      'close': 'Fermer',
      'shopEmpty': 'Aucun produit disponible pour le moment.',
      'shopApiUnavailable': 'Serveur indisponible, affichage en mode vide.',
      'pickImage': 'Importer une image',
      'imageRequired': 'Veuillez importer une image.',
      'originalPrice': 'Prix original',
      'finalPrice': 'Prix apres remise',
      'heritageBadge': 'Mauritanie • Tradition vivante',
      'heritageStory':
          'Du son de l\'ardin aux tissages de la melhfa et aux bijoux d\'argent, nous vous rapprochons de la beaute du patrimoine mauritanien avec une touche moderne.',
      'heritageIntro':
          'Le patrimoine mauritanien raconte une histoire de desert, de generosite et de savoir-faire transmis entre generations. Notre boutique met en valeur cette identite avec des pieces authentiques.',
      'oralHeritageDescRich':
          'La poesie hassanya et les recits oraux preservent la memoire collective.',
      'traditionalFashionDescRich':
          'La melhfa et la daraa incarnent une elegance locale intemporelle.',
      'handmadeDescRich':
          'Cuivre, cuir et tissage artisanal: des creations uniques a l\'ame mauritanienne.',
      'noOrders': 'Aucune commande pour le moment.',
      'status': 'Statut',
      'pending': 'En attente',
      'confirmed': 'Confirmé',
      'delivered': 'Livré',
      'ordersTitle': 'Commandes',
      'loginTitle': 'Connexion',
      'registerTitle': 'Créer un compte',
      'email': 'Email',
      'register': 'S\'inscrire',
      'noAccountRegister': 'Pas de compte ? S\'inscrire',
      'haveAccountLogin': 'Déjà un compte ? Se connecter',
      'myOrders': 'Mes commandes',
      'noMyOrders': 'Vous n\'avez pas encore de commandes.',
      'order': 'Commande',
    },
    'ar': {
      'appTitle': 'التراث الموريتاني',
      'cart': 'السلة',
      'welcome': 'الرئيسية',
      'products': 'المعرض',
      'checkout': 'الطلب',
      'admin': 'الإدارة',
      'openShop': 'الدخول إلى المتجر',
      'heroTitle': 'اكتشف روعة التراث الموريتاني',
      'heroSubtitle':
          'تصفح منتجات حرفية أصيلة، أضف ما يعجبك إلى السلة، وأكمل طلبك بسهولة.',
      'oralHeritage': 'تراث شفهي',
      'oralHeritageDesc': 'قصص وشعر يعكسان الهوية الموريتانية الأصيلة.',
      'traditionalFashion': 'أزياء تقليدية',
      'traditionalFashionDesc': 'ألوان صحراوية وأناقة بطابع محلي مميز.',
      'handmade': 'صناعة يدوية',
      'handmadeDesc': 'منتجات مصنوعة بعناية من حرفيين محليين.',
      'stock': 'المخزون',
      'add': 'إضافة',
      'outOfStock': 'نفد المخزون',
      'cartEmpty': 'سلتك فارغة حاليا.',
      'total': 'الإجمالي',
      'checkoutEmpty': 'أضف منتجات إلى السلة قبل إتمام الطلب.',
      'summary': 'ملخص الطلب',
      'totalToPay': 'المبلغ الإجمالي',
      'fullName': 'الاسم الكامل',
      'phone': 'الهاتف',
      'address': 'العنوان',
      'sending': 'جارٍ الإرسال...',
      'confirmOrder': 'تأكيد الطلب',
      'language': 'اللغة',
      'logoutAdmin': 'تسجيل خروج المشرف',
      'adminLoggedOut': 'تم تسجيل الخروج من وضع المشرف.',
      'loginSuccess': 'تم تسجيل الدخول بنجاح.',
      'loginFailed': 'بيانات الدخول غير صحيحة.',
      'adminLoginTitle': 'دخول المشرف',
      'demoCredentials': 'حساب تجريبي: admin / 1234',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'login': 'دخول',
      'adminDashboard': 'لوحة تحكم المشرف',
      'addProductTitle': 'إضافة منتج',
      'manageProductsTitle': 'إدارة المنتجات',
      'productTitle': 'اسم المنتج',
      'productImageUrl': 'رابط صورة المنتج',
      'productDescription': 'وصف قصير',
      'productCategory': 'التصنيف',
      'productIcon': 'أيقونة (إيموجي)',
      'productPrice': 'السعر',
      'discount': 'الخصم',
      'enableDiscount': 'تفعيل الخصم',
      'addProductButton': 'إضافة المنتج',
      'updateProductButton': 'حفظ التعديل',
      'deleteProductButton': 'حذف',
      'cancelEdit': 'إلغاء التعديل',
      'noProducts': 'لا توجد منتجات حاليا.',
      'editProduct': 'تعديل',
      'confirmDeleteTitle': 'تأكيد الحذف',
      'confirmDeleteBody': 'هل تريد حذف هذا المنتج؟',
      'yesDelete': 'نعم، حذف',
      'close': 'إغلاق',
      'shopEmpty': 'لا توجد منتجات حاليا.',
      'shopApiUnavailable': 'الخادم غير متاح حاليا، يتم عرض المتجر فارغا.',
      'pickImage': 'استيراد صورة',
      'imageRequired': 'يرجى استيراد صورة للمنتج.',
      'originalPrice': 'السعر الأصلي',
      'finalPrice': 'السعر بعد الخصم',
      'heritageBadge': 'موريتانيا • تراث حي',
      'heritageStory':
          'من نغمات الآردين إلى نسيج الملحفة وصياغة الفضة، نقرّب إليك جمال التراث الموريتاني بلمسة عصرية.',
      'heritageIntro':
          'التراث الموريتاني يحكي قصة الصحراء والكرم والحرف المتوارثة بين الأجيال. متجرنا يقدّم هذه الهوية عبر منتجات أصيلة.',
      'oralHeritageDescRich':
          'الشعر الحساني والرواية الشفوية يحفظان الذاكرة الجماعية للمجتمع.',
      'traditionalFashionDescRich':
          'الملحفة والدراعة رمز أناقة موريتانية أصيلة وعابرة للزمن.',
      'handmadeDescRich':
          'النحاس والجلد والنسيج اليدوي: قطع فريدة بروح موريتانية خالصة.',
      'noOrders': 'لا توجد طلبات حاليًا.',
      'status': 'الحالة',
      'pending': 'قيد الانتظار',
      'confirmed': 'تم التأكيد',
      'delivered': 'تم التسليم',
      'ordersTitle': 'الطلبات',
      'loginTitle': 'تسجيل الدخول',
      'registerTitle': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'register': 'إنشاء حساب',
      'noAccountRegister': 'ليس لديك حساب؟ سجل الآن',
      'haveAccountLogin': 'لديك حساب؟ سجل الدخول',
      'myOrders': 'طلباتي',
      'noMyOrders': 'لا توجد طلبات بعد.',
      'order': 'طلب',
    },
  };

  String translate(String key) {
    final map =
        _localizedValues[locale.languageCode] ?? _localizedValues['fr']!;
    return map[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
