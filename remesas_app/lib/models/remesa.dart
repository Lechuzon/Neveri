class Remesa {
  final int? id;
  final String nombreCliente;
  final double monto;
  final DateTime fechaEnvio;
  final String usuarioRegistro;
  final DateTime fechaCreacion;

  const Remesa({
    this.id,
    required this.nombreCliente,
    required this.monto,
    required this.fechaEnvio,
    required this.usuarioRegistro,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre_cliente': nombreCliente,
      'monto': monto,
      'fecha_envio': fechaEnvio.millisecondsSinceEpoch,
      'usuario_registro': usuarioRegistro,
      'fecha_creacion': fechaCreacion.millisecondsSinceEpoch,
    };
  }

  factory Remesa.fromMap(Map<String, dynamic> map) {
    return Remesa(
      id: map['id'],
      nombreCliente: map['nombre_cliente'],
      monto: map['monto'],
      fechaEnvio: DateTime.fromMillisecondsSinceEpoch(map['fecha_envio']),
      usuarioRegistro: map['usuario_registro'],
      fechaCreacion: DateTime.fromMillisecondsSinceEpoch(map['fecha_creacion']),
    );
  }

  @override
  String toString() {
    return 'Remesa{id: $id, nombreCliente: $nombreCliente, monto: $monto, fechaEnvio: $fechaEnvio, usuarioRegistro: $usuarioRegistro}';
  }
}
