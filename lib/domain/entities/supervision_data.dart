class SupervisionData {
  final double totalFlow;
  final double flowIncreasePercentage;
  final int pendingAuthorizations;
  final int urgentPending;
  final List<TerminalStatus> terminals;

  SupervisionData({
    required this.totalFlow,
    required this.flowIncreasePercentage,
    required this.pendingAuthorizations,
    required this.urgentPending,
    required this.terminals,
  });
}

class TerminalStatus {
  final String name;
  final String status;
  final double amount;
  final String color;

  TerminalStatus({
    required this.name,
    required this.status,
    required this.amount,
    required this.color,
  });
}
