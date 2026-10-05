class Producto {
  final int id;
  final String codigo;
  final String codigoBarras;
  final String nombre;
  final String? categoria;
  final String? descripcion;
  final double stock;
  final double precioVenta;
  final double precioMayoreo;
  final double cantidadMayoreo;
  final double costoUnitario;
  final double stockMinimo;
  final String? unidad;
  final String? ubicacion;
  final String? imagen;

  Producto({
    required this.id,
    required this.codigo,
    required this.codigoBarras,
    required this.nombre,
    this.categoria,
    this.descripcion,
    required this.stock,
    required this.precioVenta,
    required this.precioMayoreo,
    required this.cantidadMayoreo,
    required this.costoUnitario,
    required this.stockMinimo,
    this.unidad,
    this.ubicacion,
    this.imagen,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'] ?? 0,
      codigo: json['codigo'] ?? '',
      codigoBarras: json['codigo_barras'] ?? '',
      nombre: json['nombre'] ?? '',
      categoria: json['categoria'],
      descripcion: json['descripcion'],

      stock: _toDouble(json['stock']),
      precioVenta: _toDouble(json['precio_venta']),
      precioMayoreo: _toDouble(json['precio_mayoreo']),
      cantidadMayoreo: _toDouble(json['cantidad_mayoreo']),
      costoUnitario: _toDouble(json['costo_unitario']),
      stockMinimo: _toDouble(json['stock_minimo']),

      unidad: json['unidad'],
      ubicacion: json['ubicacion'],
      imagen: json['imagen'],
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0;
  }
}