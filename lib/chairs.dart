class Chair {
  Chair(
      {required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.card,
      this.isFavorite = false,
      this.quantity = 1});
  final String name;
  final String description;
  final double price;
  final String image;
  final String card;
  int quantity;
  bool isFavorite;
  int get increment => quantity += 1;
  double totalPrice() {
    return price * quantity;
  }
}

List<Chair> data = [
  Chair(
      name: 'Wooden Chair',
      description:
          'lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsum',
      price: 30.00,
      image: "assets/images/woodchairbox.png",
      card: "assets/images/woodchaircard.png"),
  Chair(
      name: 'Feather Chair',
      description:
          'lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsum',
      price: 40.00,
      image: "assets/images/featherchairbox.png",
      card: "assets/images/featherchaircard.png"),
  Chair(
      name: 'Minimal Chair',
      description:
          'lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsum',
      price: 50.00,
      image: "assets/images/minimalchairbox.png",
      card: "assets/images/minimalchaircard.png"),
  Chair(
      name: 'Grey Chair',
      description:
          'lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsum',
      price: 60.00,
      image: "assets/images/greychairbox.png",
      card: "assets/images/greychaircard.png"),
  Chair(
      name: 'Gold Chair',
      description:
          'lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsum',
      price: 70.00,
      image: "assets/images/goldchairbox.png",
      card: "assets/images/goldchaircard.png"),
];
