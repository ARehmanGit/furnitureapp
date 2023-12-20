import 'package:flutter/material.dart';

import 'package:furnitureapp/chairs.dart';

class FavoritesTile extends StatelessWidget {
  const FavoritesTile({super.key, required this.chair});
  final Chair chair;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 10,
        ),
        child: Row(children: [
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  chair.card,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chair.name,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "\$${chair.price}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
