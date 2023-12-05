int calculateTotalPrice(double price, double taxPercentage) {
  double totalPrice =
      (price) + (price  * (taxPercentage / 100));

  String formattedTotalPrice = totalPrice.ceil().toStringAsFixed(2);

  formattedTotalPrice = formattedTotalPrice.replaceAll(RegExp(r'\.0*$'), '');

  return int.parse(formattedTotalPrice);
}
