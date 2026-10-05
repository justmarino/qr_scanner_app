import 'package:flutter/material.dart';
import 'screens/scanner_screen.dart';

void main() {
  runApp(const VictoryPointApp());
}

class VictoryPointApp extends StatelessWidget {
  const VictoryPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Victory Point',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF17699B),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;
  String _errorMessage = '';

  // Colores
  static const Color azulOscuro = Color(0xFF142D3F);
  static const Color azulPrincipal = Color(0xFF17699B);
  static const Color fondo = Color(0xFFF8FAF7);
  static const Color fondoCampo = Color(0xFFEAF1FA);
  static const Color grisTexto = Color(0xFF718096);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ==========================================================
  // LOGIN
  // ==========================================================

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Credenciales temporales para pruebas
    if (email == 'admin@qr.com' && password == '123456') {
      setState(() {
        _errorMessage = '';
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Correo o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Column(
                children: [
                  // ==================================================
                  // LOGO
                  // ==================================================

                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: azulPrincipal,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // VICTORY POINT
                  // ==================================================

                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Victory ',
                          style: TextStyle(
                            color: azulOscuro,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Point',
                          style: TextStyle(
                            color: azulPrincipal,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sistema de gestión empresarial',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grisTexto,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ==================================================
                  // TARJETA LOGIN
                  // ==================================================

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // TITULO
                          // ==================================================

                          const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: azulOscuro,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // ==================================================
                          // USUARIO
                          // ==================================================

                          const Text(
                            'USUARIO',
                            style: TextStyle(
                              color: azulOscuro,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _emailController,
                            keyboardType:
                                TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Correo electrónico',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                              ),
                              filled: true,
                              fillColor: fondoCampo,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: azulPrincipal,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Ingresa tu correo';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // ==================================================
                          // CONTRASEÑA
                          // ==================================================

                          const Text(
                            'CONTRASEÑA',
                            style: TextStyle(
                              color: azulOscuro,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              filled: true,
                              fillColor: fondoCampo,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: azulPrincipal,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Ingresa tu contraseña';
                              }

                              return null;
                            },
                          ),

                          // ==================================================
                          // ERROR
                          // ==================================================

                          if (_errorMessage.isNotEmpty) ...[
                            const SizedBox(height: 15),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    Colors.red.withValues(alpha: 0.08),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _errorMessage,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 25),

                          // ==================================================
                          // BOTÓN ENTRAR
                          // ==================================================

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: azulPrincipal,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Entrar al sistema',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // ==================================================
                          // DATOS DE PRUEBA
                          // ==================================================

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: fondoCampo,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Datos de prueba',
                                  style: TextStyle(
                                    color: azulOscuro,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text(
                                  'Correo: admin@qr.com',
                                  style: TextStyle(
                                    color: grisTexto,
                                    fontSize: 13,
                                  ),
                                ),

                                SizedBox(height: 3),

                                Text(
                                  'Contraseña: 123456',
                                  style: TextStyle(
                                    color: grisTexto,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Victory Point © 2026',
                    style: TextStyle(
                      color: grisTexto,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME / MENÚ PRINCIPAL
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color azulOscuro = Color(0xFF142D3F);
  static const Color azulPrincipal = Color(0xFF17699B);
  static const Color azulClaro = Color(0xFF3BA9D9);
  static const Color fondo = Color(0xFFF8FAF7);
  static const Color grisTexto = Color(0xFF718096);

  // ==========================================================
  // ABRIR SCANNER
  // ==========================================================

  void _abrirScanner(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerScreen(),
      ),
    );
  }

  // ==========================================================
  // CERRAR SESIÓN
  // ==========================================================

  void _cerrarSesion(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        title: const Text(
          'Victory Point',
          style: TextStyle(
            color: azulOscuro,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              _cerrarSesion(context);
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: azulOscuro,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ========================================================
      // CONTENIDO
      // ========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // BIENVENIDA
              // ==================================================

              const Text(
                'Bienvenido',
                style: TextStyle(
                  color: azulOscuro,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Selecciona una opción para comenzar.',
                style: TextStyle(
                  color: grisTexto,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // CONSULTA CÓDIGO DE BARRAS
              // ==================================================

              _ModuloCard(
                icon: Icons.qr_code_scanner_rounded,
                title: 'Consulta código de barras',
                description:
                    'Busca un producto mediante su código de barras.',
                color: azulPrincipal,
                onTap: () {
                  _abrirScanner(context);
                },
              ),

              const SizedBox(height: 16),

              // ==================================================
              // INVENTARIO
              // ==================================================

              _ModuloCard(
                icon: Icons.inventory_2_outlined,
                title: 'Inventario',
                description:
                    'Consulta y administra el inventario de productos.',
                color: azulClaro,
                disabled: true,
                label: 'Próximamente',
                onTap: null,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // VENTAS
              // ==================================================

              _ModuloCard(
                icon: Icons.point_of_sale_outlined,
                title: 'Ventas',
                description:
                    'Gestiona las ventas y operaciones del negocio.',
                color: azulPrincipal,
                disabled: true,
                label: 'Próximamente',
                onTap: null,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // REPORTES
              // ==================================================

              _ModuloCard(
                icon: Icons.bar_chart_rounded,
                title: 'Reportes',
                description:
                    'Consulta información y estadísticas del sistema.',
                color: azulClaro,
                disabled: true,
                label: 'Próximamente',
                onTap: null,
              ),

              const SizedBox(height: 35),

              // ==================================================
              // INFORMACIÓN
              // ==================================================

              const Center(
                child: Column(
                  children: [
                    Text(
                      'Victory Point',
                      style: TextStyle(
                        color: azulOscuro,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Sistema de gestión empresarial',
                      style: TextStyle(
                        color: grisTexto,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TARJETA DE MÓDULO
// ============================================================

class _ModuloCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback? onTap;
  final bool disabled;
  final String? label;

  const _ModuloCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    this.disabled = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorFinal =
        disabled ? Colors.grey.shade400 : color;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: disabled
                  ? Colors.grey.shade200
                  : color.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==================================================
              // ICONO
              // ==================================================

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: colorFinal.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: colorFinal,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              // ==================================================
              // TEXTO
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: disabled
                                  ? Colors.grey.shade500
                                  : const Color(0xFF142D3F),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        if (label != null)
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Text(
                              label!,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: TextStyle(
                        color: disabled
                            ? Colors.grey.shade400
                            : const Color(0xFF718096),
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ==================================================
              // FLECHA
              // ==================================================

              Icon(
                disabled
                    ? Icons.lock_outline
                    : Icons.arrow_forward_ios_rounded,
                size: disabled ? 18 : 17,
                color: colorFinal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}