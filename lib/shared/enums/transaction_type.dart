import 'package:shoe_store/gen/assets.gen.dart';

enum TransactionType {
  income,
  outcome,
}

extension TransactionTypeExt on TransactionType {
  String get iconPath {
    switch (this) {
      case TransactionType.income:
        return Assets.icons.income.path;
      default:
        return Assets.icons.outcome.path;
    }
  }
}
