import 'package:shoe_store/gen/assets.gen.dart';


class CaterogyModel {
  final String name;
  final String placeHolder;

  CaterogyModel({required this.name, required this.placeHolder});

  String get placeHolderIc {
    switch (placeHolder) {
      case 'education':
        return Assets.icons.education.path;
      case 'shopping':
        return Assets.icons.shoppingCart.path;
      case 'entertainment':
        return Assets.icons.entertainment.path;
      case 'healthy':
        return Assets.icons.icMedicine.path;
      case 'vehicle':
        return Assets.icons.moto.path;
      case 'services':
        return Assets.icons.service.path;
      case 'investment':
        return Assets.icons.investment.path;
      case 'salary':
        return Assets.icons.salary.path;
      case 'saving':
        return Assets.icons.saving.path;
      case 'other':
        return Assets.icons.other.path;
      default:
        return Assets.icons.education.path;
    }
  }
}
