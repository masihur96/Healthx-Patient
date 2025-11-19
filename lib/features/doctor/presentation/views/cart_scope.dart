import 'package:flutter/widgets.dart';

import '../../../medicine/presentation/views/medicine_models.dart';

class CartScope extends InheritedNotifier<CartState> {
  const CartScope(
      {super.key, required CartState notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static CartState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in context');
    return scope!.notifier!;
  }
}
