import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/chairs.dart';

final cartStateNotifierProvider =
    StateNotifierProvider<CartStateNotifier, List<Chair>>((ref) {
  return CartStateNotifier();
});

class CartStateNotifier extends StateNotifier<List<Chair>> {
  CartStateNotifier() : super([]);

  void addProduct(Chair chair) {
    if (state.contains(chair)) {
      state.removeWhere((p) => p == chair);
    }

    state = [...state, chair];
  }

  void removeProduct(Chair chair) {
    state = state.where((p) => p != chair).toList();
  }

  void clearCart() {
    state.map((e) => e.quantity = 1).toList();
    state = [];
  }
}
