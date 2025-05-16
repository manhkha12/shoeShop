enum Order {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

extension OrderExt on Order {
  String get title {
    switch (this) {
      case Order.pending:
        return 'Pending';
      case Order.processing:
        return 'Processing';
      case Order.shipped:
        return 'Shipped';
      case Order.delivered:
        return 'Delivered';
      case Order.cancelled:
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }
}
