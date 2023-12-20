import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/chair_page.dart';
import 'package:furnitureapp/favorites_utils.dart';
import 'package:furnitureapp/favoritesnotifer.dart';

class FavoriteList extends ConsumerWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favor = ref.watch(favoritesStateProvider);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(favoritesStateProvider.notifier).clearFavorites();
                },
                icon: const Icon(
                  Icons.remove_circle,
                  size: 34,
                )),
            const SizedBox(
              width: 24,
            )
          ],
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Favorites (${favor.length.toString()})"),
        ),
        SliverToBoxAdapter(
          child: favor.isEmpty
              ? const Center(
                  child: Text(
                    "No favorites Added!",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                  ),
                )
              : Column(
                  children: [
                    ...favor.map((chair) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChairPage(chair: chair),
                              ));
                        },
                        child: FavoritesTile(chair: chair))),
                  ],
                ),
        ),
      ]),
    );
  }
}
