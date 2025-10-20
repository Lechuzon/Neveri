import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/remesa.dart';
import 'add_remesa_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Remesa> _remesas = [];
  List<Remesa> _filteredRemesas = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  double _totalMonto = 0.0;
  int _totalRemesas = 0;

  @override
  void initState() {
    super.initState();
    _loadRemesas();
    _loadStats();
  }

  Future<void> _loadRemesas() async {
    setState(() {
      _isLoading = true;
    });

    final remesas = await _databaseHelper.getAllRemesas();
    setState(() {
      _remesas = remesas;
      _filteredRemesas = remesas;
      _isLoading = false;
    });
  }

  Future<void> _loadStats() async {
    final totalMonto = await _databaseHelper.getTotalMonto();
    final totalRemesas = await _databaseHelper.getTotalRemesas();
    setState(() {
      _totalMonto = totalMonto;
      _totalRemesas = totalRemesas;
    });
  }

  Future<void> _insertSampleData() async {
    // Datos de muestra para probar la aplicación
    final sampleRemesas = [
      Remesa(
        nombreCliente: 'Juan Pérez García',
        monto: 1500.00,
        fechaEnvio: DateTime.now().subtract(const Duration(days: 1)),
        usuarioRegistro: 'María López',
        fechaCreacion: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Remesa(
        nombreCliente: 'Ana Rodríguez',
        monto: 850.50,
        fechaEnvio: DateTime.now().subtract(const Duration(days: 2)),
        usuarioRegistro: 'Carlos Mendoza',
        fechaCreacion: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Remesa(
        nombreCliente: 'Roberto Silva',
        monto: 2200.75,
        fechaEnvio: DateTime.now().subtract(const Duration(days: 3)),
        usuarioRegistro: 'María López',
        fechaCreacion: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Remesa(
        nombreCliente: 'Carmen Morales',
        monto: 950.00,
        fechaEnvio: DateTime.now().subtract(const Duration(days: 4)),
        usuarioRegistro: 'Pedro Ruiz',
        fechaCreacion: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Remesa(
        nombreCliente: 'Luis Fernando Castro',
        monto: 1800.25,
        fechaEnvio: DateTime.now().subtract(const Duration(days: 5)),
        usuarioRegistro: 'Carlos Mendoza',
        fechaCreacion: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    // Insertar cada remesa de muestra
    for (final remesa in sampleRemesas) {
      await _databaseHelper.insertRemesa(remesa);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos de ejemplo agregados exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _filterRemesas(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRemesas = _remesas;
      } else {
        _filteredRemesas = _remesas
            .where(
              (remesa) =>
                  remesa.nombreCliente.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  remesa.usuarioRegistro.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  Future<void> _deleteRemesa(int id) async {
    await _databaseHelper.deleteRemesa(id);
    _loadRemesas();
    _loadStats();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remesa eliminada exitosamente')),
      );
    }
  }

  void _showDeleteConfirmation(Remesa remesa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text(
            '¿Estás seguro de que deseas eliminar la remesa de ${remesa.nombreCliente}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteRemesa(remesa.id!);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remesas App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Estadísticas
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            size: 32,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Enviado',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '\$${NumberFormat('#,##0.00').format(_totalMonto)}',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.receipt,
                            size: 32,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Remesas',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '$_totalRemesas',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por cliente o usuario',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterRemesas,
            ),
          ),
          // Lista de remesas
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredRemesas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No hay remesas registradas',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        if (_remesas
                            .isEmpty) // Solo mostrar si no hay datos originales
                          ElevatedButton.icon(
                            onPressed: () async {
                              // Insertar datos de ejemplo
                              await _insertSampleData();
                              _loadRemesas();
                              _loadStats();
                            },
                            icon: const Icon(Icons.add_box),
                            label: const Text('Agregar Datos de Prueba'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredRemesas.length,
                    itemBuilder: (context, index) {
                      final remesa = _filteredRemesas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              remesa.nombreCliente[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            remesa.nombreCliente,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Monto: \$${NumberFormat('#,##0.00').format(remesa.monto)}',
                              ),
                              Text(
                                'Fecha envío: ${DateFormat('dd/MM/yyyy').format(remesa.fechaEnvio)}',
                              ),
                              Text('Registrado por: ${remesa.usuarioRegistro}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmation(remesa),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRemesaScreen()),
          );
          if (result == true) {
            _loadRemesas();
            _loadStats();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
