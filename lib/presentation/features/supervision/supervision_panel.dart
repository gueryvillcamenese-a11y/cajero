import 'package:flutter/material.dart';
import 'package:cajero/injection/injection_container.dart';
import 'package:cajero/presentation/features/supervision/supervision_controller.dart';

class SupervisionPanel extends StatefulWidget {
  const SupervisionPanel({super.key});

  @override
  State<SupervisionPanel> createState() => _SupervisionPanelState();
}

class _SupervisionPanelState extends State<SupervisionPanel> {
  late SupervisionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SupervisionController(getSupervisionDataUseCase: sl.getSupervisionDataUseCase);
    _controller.loadSupervisionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text('Panel de Supervisión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Sucursal: Centro 12-A', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading || _controller.data == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB74D)));
          }
          final data = _controller.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ESTADO DE FLUJO EN VIVO',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildFlowStat('Flujo Total', '\$${data.totalFlow.toStringAsFixed(2)}', '+ ${data.flowIncreasePercentage}%', Colors.green),
                    const SizedBox(width: 16),
                    _buildFlowStat('Pendientes', data.pendingAuthorizations.toString().padLeft(2, '0'), '${data.urgentPending} Urgentes', Colors.orange),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Autorizaciones Críticas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text('Ver Todas', style: TextStyle(color: Colors.yellow[800], fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAuthCard(context, 'Devolución #8429', 'a Cajero: Juan Pérez', '\$120.00'),
                const SizedBox(height: 12),
                _buildAuthCard(context, 'Devolución #8431', 'a Cajero: María García', '\$45.50'),
                const SizedBox(height: 32),
                const Text(
                  'ESTADO DE TERMINALES',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1),
                ),
                const SizedBox(height: 16),
                ...data.terminals.map((t) => 
                  _buildTerminalItem(t.name, t.status, '\$${t.amount.toStringAsFixed(2)}', _getColor(t.color))
                ).toList(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFFB74D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushReplacementNamed(context, '/catalog');
          if (index == 2) Navigator.pushNamed(context, '/reports');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.security_outlined), label: 'Autoriz.'),
        ],
      ),
    );
  }

  Color _getColor(String color) {
    switch (color) {
      case 'green': return Colors.green;
      case 'orange': return Colors.orange;
      default: return Colors.grey;
    }
  }

  Widget _buildFlowStat(String label, String value, String sub, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(sub, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthCard(BuildContext context, String title, String subtitle, String amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.receipt_long, color: Colors.teal[700]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Operación $title Autorizada Correctamente'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB74D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('AUTORIZAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalItem(String name, String status, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(status, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
