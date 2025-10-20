import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/remesa.dart';

class SampleDataService {
  static final DatabaseHelper _databaseHelper = DatabaseHelper();

  static Future<void> insertSampleData() async {
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
  }

  static Widget buildSampleDataButton(
    BuildContext context,
    VoidCallback onDataInserted,
  ) {
    return ElevatedButton.icon(
      onPressed: () async {
        // Mostrar diálogo de confirmación
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Agregar Datos de Prueba'),
              content: const Text(
                '¿Deseas agregar algunos datos de ejemplo para probar la aplicación?\n\n'
                'Se agregarán 5 remesas de muestra.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );

        if (confirm == true) {
          try {
            await insertSampleData();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Datos de ejemplo agregados exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
              onDataInserted();
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error al agregar datos: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      },
      icon: const Icon(Icons.add_box),
      label: const Text('Agregar Datos de Prueba'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }
}
