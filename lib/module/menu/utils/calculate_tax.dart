String addAndFormatCurrency(double value1, double value2) {
  double result = value1 + value2;
  String formattedResult = '\$${result.toStringAsFixed(2)}';
  return formattedResult;
}
