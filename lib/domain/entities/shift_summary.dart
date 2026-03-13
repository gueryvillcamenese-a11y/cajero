class ShiftSummary {
  final double totalSales;
  final int totalTickets;
  final double averageTicket;
  final List<double> hourlySales;
  final Map<String, int> paymentMethodsPercentages;

  ShiftSummary({
    required this.totalSales,
    required this.totalTickets,
    required this.averageTicket,
    required this.hourlySales,
    required this.paymentMethodsPercentages,
  });
}
