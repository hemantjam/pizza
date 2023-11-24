String calculateTotalPrice(double price, double addOn, double taxPercentage) {
  double totalPrice =
      (price + addOn) + ((price + addOn) * (taxPercentage / 100));

  String formattedTotalPrice = totalPrice.toStringAsFixed(2);

  formattedTotalPrice = formattedTotalPrice.replaceAll(RegExp(r'\.0*$'), '');

  return formattedTotalPrice;
}
