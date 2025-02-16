import 'package:shoe_store/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum SpendCategory {
  education,
  shopping,
  food,
  entertainment,
  healthy,
  vehicle,
  services,
  investment,
  salary,
  saving,
  business,
  travel,
  other
}

extension SpendCategoryExt on SpendCategory {
  String get icon {
    switch (this) {
      case SpendCategory.education:
        return Assets.icons.education.path;
      case SpendCategory.shopping:
        return Assets.icons.shoppingCart.path;
      case SpendCategory.food:
        return Assets.icons.food.path;
      case SpendCategory.entertainment:
        return Assets.icons.entertainment.path;
      case SpendCategory.healthy:
        return Assets.icons.icMedicine.path;
      case SpendCategory.vehicle:
        return Assets.icons.moto.path;
      case SpendCategory.services:
        return Assets.icons.service.path;
      case SpendCategory.investment:
        return Assets.icons.investment.path;
      case SpendCategory.salary:
        return Assets.icons.salary.path;
      case SpendCategory.saving:
        return Assets.icons.saving.path;
      case SpendCategory.business:
        return Assets.icons.shopHouse.path;
      case SpendCategory.travel:
        return Assets.icons.airplane.path;
      default:
        return Assets.icons.other.path;
    }
  }

  Color get color {
    switch (this) {
      case SpendCategory.education:
        return const Color(0xffFAA604);
      case SpendCategory.shopping:
        return const Color(0xff4E7EF9);
      case SpendCategory.food:
        return const Color(0xff3D00EC);
      case SpendCategory.entertainment:
        return const Color(0xff0893A6);
      case SpendCategory.healthy:
        return const Color(0xffFF6464);
      case SpendCategory.vehicle:
        return const Color(0xff09B138);
      case SpendCategory.services:
        return const Color(0xffDB7A7A);
      case SpendCategory.investment:
        return const Color(0xff15A334);
      case SpendCategory.salary:
        return const Color(0xffFFB800);
      case SpendCategory.saving:
        return const Color(0xffFA8EEF);
      case SpendCategory.business:
        return const Color(0xff0B71F1);
      case SpendCategory.travel:
        return const Color(0xff2CA7EC);
      default:
        return const Color(0xff91D501);
    }
  }

  String get titleI18n {
    switch (this) {
      case SpendCategory.education:
        return 'spend_category.education';
      case SpendCategory.shopping:
        return 'spend_category.shopping';
      case SpendCategory.food:
        return 'spend_category.food';
      case SpendCategory.entertainment:
        return 'spend_category.entertainment';
      case SpendCategory.healthy:
        return 'spend_category.healthy';
      case SpendCategory.vehicle:
        return 'spend_category.vehicle';
      case SpendCategory.services:
        return 'spend_category.services';
      case SpendCategory.investment:
        return 'spend_category.investment';
      case SpendCategory.salary:
        return 'spend_category.salary';
      case SpendCategory.saving:
        return 'spend_category.saving';
      case SpendCategory.business:
        return 'spend_category.business';
      case SpendCategory.travel:
        return 'spend_category.travel';
      default:
        return 'spend_category.other';
    }
  }
}
