// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ValU Task';

  @override
  String get appTitle => 'GrocerMate';

  @override
  String get youAreOnline => 'You Are Online';

  @override
  String get youAreOffline => 'You Are Offline';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out Of Stock';

  @override
  String get remove => 'Remove';

  @override
  String get addToCart => 'Add To Cart';

  @override
  String get productDetailsTitle => 'Product Details';

  @override
  String get initializing => 'Initializing...';

  @override
  String get brandLabel => 'Brand';

  @override
  String get priceLabel => 'Price';

  @override
  String get originalPriceLabel => 'Original Price';

  @override
  String get stockLabel => 'Stock';

  @override
  String get ratingLabel => 'Rating';

  @override
  String get removeFromCart => 'Remove from Cart';

  @override
  String get save => 'Save';

  @override
  String get removeFromSaved => 'Remove from Saved';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get search => 'search';

  @override
  String get searchHint => 'Search products...';

  @override
  String get searchInitial => 'Enter a search term';

  @override
  String get noResults => 'No results found';
}
