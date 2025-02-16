import 'package:shoe_store/gen/assets.gen.dart';

class Wallet {
  final String number;
  final String name;
  final String placeholder;

  Wallet({
    required this.number,
    required this.name,
    required this.placeholder,
  });

  String get placeholderImg {
    switch (placeholder) {
      case 'card_1':
        return Assets.images.card1.path;
      case 'card_2':
        return Assets.images.card2.path;
      case 'card_3':
        return Assets.images.card3.path;
      case 'card_4':
        return Assets.images.card4.path;
      case 'card_5':
        return Assets.images.card5.path;
      default:
        return Assets.images.card1.path;
    }
  }
}
