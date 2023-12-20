import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnitureapp/cart_state_notifier.dart';
import 'package:furnitureapp/cart_utils.dart';

double ratingindex = 3.0;
double shipping = 30.0;

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartStateNotifierProvider);
    double screenheight = MediaQuery.of(context).size.height * 0.5;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: SizedBox(
        height: screenheight,
        width: screenwidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Selected items",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 22),
                  ),
                  Text(
                    "\$ ${cart.fold<double>(0, (sum, item) => sum + item.totalPrice())}",
                    style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping Fees",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 22),
                  ),
                  Text(
                    "\$30.0",
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(
                        letterSpacing: 0.5,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  Text(
                    "\$ ${cart.fold<double>(0, (sum, item) => sum + item.totalPrice()) + shipping}",
                    style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              FilledButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 34, 37, 48),
                  )),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 60,
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                  )),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            backgroundColor: const Color.fromARGB(255, 236, 236, 236),
            pinned: true,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(size: 30, color: Colors.black),
            centerTitle: true,
            foregroundColor: Colors.black,
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
                  const Text(
                    "Cart",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: badges.Badge(
                      badgeAnimation: const badges.BadgeAnimation.scale(),
                      position: badges.BadgePosition.custom(top: -6, end: -2),
                      badgeContent: Text(
                        cart.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(cartStateNotifierProvider.notifier)
                            .clearCart();
                      },
                      icon: const Icon(Icons.remove_shopping_cart_sharp))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...cart.map((chair) => CartTile(
                        chair: chair,
                      )),
                  SizedBox(height: screenheight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
