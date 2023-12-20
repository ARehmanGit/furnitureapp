import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/chairs.dart';

final favoritesStateProvider =
    StateNotifierProvider<FavoritesNotifier, List<Chair>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Chair>> {
  FavoritesNotifier() : super([]);

  void addToFavorites(Chair chair) {
    if (state.contains(chair)) {
      state.removeWhere((element) => element == chair);
    }
    state = [...state, chair];
  }

  void removeFromFavorites(Chair chair) {
    state.where((item) => item == chair).toList();
    state = [...state];
  }

  void clearFavorites() {
    state = [];
  }
}
