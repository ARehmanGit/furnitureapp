import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/cart.dart';
import 'package:furnitureapp/cart_state_notifier.dart';
import 'package:furnitureapp/chairs.dart';
import 'package:badges/badges.dart' as badges;

class ChairPage extends ConsumerStatefulWidget {
  const ChairPage({required this.chair, super.key});
  final Chair chair;

  @override
  ConsumerState<ChairPage> createState() => _ChairPageConsumerState();
}

class _ChairPageConsumerState extends ConsumerState<ChairPage> {
  double ratingindex = 3.0;
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartStateNotifierProvider);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            height: 60,
            width: 200,
            child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 34, 37, 48),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(40, 40),
                )),
                onPressed: () {
                  ref
                      .read(cartStateNotifierProvider.notifier)
                      .addProduct(widget.chair);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Text(
                    "+ Add to Cart",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                )),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(size: 30, color: Colors.black),
              forceMaterialTransparency: true,
              centerTitle: true,
              foregroundColor: Colors.black,
              expandedHeight: 400,
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Text(
                      widget.chair.name,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Cart(),
                            )),
                        child: badges.Badge(
                          badgeAnimation: const badges.BadgeAnimation.scale(),
                          position:
                              badges.BadgePosition.custom(top: -6, end: -2),
                          badgeContent: Text(
                            cart.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(80, 60)),
                  child: Image.asset(
                    widget.chair.image,
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${widget.chair.price}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 34),
                      ),
                      Text(
                        widget.chair.name,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 40, 10, 0),
                        height: 100,
                        child: RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratingindex = rating;
                            });
                          },
                        ),
                      ),
                      Text(
                        "$ratingindex".toString(),
                        style: const TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ],
                  ),
                )
              ]),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  Text(
                    widget.chair.description,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  )
                ],
              ),
            )),
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            )
          ],
        ),
      ),
    );
  }
}
