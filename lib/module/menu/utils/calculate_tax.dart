int calculateTotalPrice(double price, double addOn, double taxPercentage) {
  double totalPrice =
      (price + addOn) + ((price + addOn) * (taxPercentage / 100));

  String formattedTotalPrice = totalPrice.ceil().toString();

  formattedTotalPrice = formattedTotalPrice.replaceAll(RegExp(r'\.0*$'), '');

  return int.parse(formattedTotalPrice);
}
