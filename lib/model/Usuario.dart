class Usuario {
  final String nombre;
  final String nombreUsuario;

  Usuario({required this.nombre, required this.nombreUsuario});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'],
      nombreUsuario: json['nombreUsuario'],
    );
  }
}