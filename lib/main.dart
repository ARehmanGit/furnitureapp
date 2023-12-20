import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/cart.dart';
import 'package:furnitureapp/cart_state_notifier.dart';
import 'package:furnitureapp/chair_page.dart';
import 'package:furnitureapp/chairs.dart';
import 'package:badges/badges.dart' as badges;
import 'package:furnitureapp/favoritelist.dart';
import 'package:furnitureapp/favoritesnotifer.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  final TextEditingController text = TextEditingController();
  List<Chair> stuff = [];

  @override
  void initState() {
    setState(() {
      stuff = data;
    });
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Chair> result = [];
    if (enteredKeyword.isEmpty) {
      result = data;
    } else {
      result = data
          .where((item) =>
              item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      stuff = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartStateNotifierProvider);
    final favoritemain = ref.watch(favoritesStateProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 30, 26, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavoriteList()));
                        },
                        icon: favoritemain.isEmpty
                            ? const Icon(
                                Icons.favorite_rounded,
                                size: 34,
                              )
                            : const Icon(
                                Icons.favorite_rounded,
                                size: 34,
                                color: Colors.red,
                              ),
                      ),
                      const Icon(
                        Icons.person_2_sharp,
                        size: 34,
                      ),
                    ]),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                width: double.maxFinite,
                child: Stack(children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(32, 20, 74, 0),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 2),
                            blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.search_rounded,
                          size: 28,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            onChanged: (value) => _runFilter(value),
                            controller: text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 36,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cart(),
                          )),
                      child: badges.Badge(
                        badgeAnimation: const badges.BadgeAnimation.scale(),
                        position: badges.BadgePosition.custom(top: -6, end: 0),
                        badgeContent: Text(
                          cart.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 34,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: Text('Explore',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 28)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 350,
                child: stuff.isEmpty
                    ? const Center(
                        child: Text(
                          "No Such Chair Exists!",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: stuff.length,
                        itemBuilder: (context, index) {
                          final chair = stuff[index];
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChairPage(chair: chair),
                                  )),
                              child: ChairTile(chair: stuff[index]));
                        },
                      ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Text('Best Selling',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 28)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 40),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            "assets/images/minimalchaircard.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Minimal Chair",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18)),
                            const Text("Lorem Ipsum",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("\$ 50.0",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18)),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_circle_right_sharp,
                                        size: 36,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChairPage(chair: data[2]),
                                            ));
                                      },
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChairTile extends ConsumerStatefulWidget {
  const ChairTile({required this.chair, super.key});
  final Chair chair;

  @override
  ConsumerState<ChairTile> createState() => _ChairTileConsumerState();
}

class _ChairTileConsumerState extends ConsumerState<ChairTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    int showQT = widget.chair.quantity;
    final favorlisten = ref.watch(favoritesStateProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.chair.image,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.chair.name,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 30, 8),
                    child: Text(
                      "\$ ${widget.chair.price.toString()}",
                      style:
                          const TextStyle(fontFamily: "Poppins", fontSize: 24),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            ref
                                .read(cartStateNotifierProvider.notifier)
                                .addProduct(widget.chair);
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 40,
                          )))
                ],
              ),
            ],
          ),
          Positioned(
              right: 10,
              bottom: 80,
              child: Container(
                  height: 30,
                  width: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.chair.increment;
                            showQT = widget.chair.quantity;
                          });
                        },
                        child: Text(
                          "  + $showQT ",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ))),
          Positioned(
            left: 174,
            top: 30,
            child: IconButton(
              onPressed: () {
                ref
                    .read(favoritesStateProvider.notifier)
                    .addToFavorites(widget.chair);
              },
              icon: Icon(
                favorlisten.contains(widget.chair)
                    ? Icons.favorite_sharp
                    : Icons.favorite_border,
                size: 36,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
