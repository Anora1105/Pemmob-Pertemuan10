// lib/ui/registrasi_page.dart
import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextBoxController = TextEditingController();
  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _namaTextBoxController.dispose();
    _emailTextBoxController.dispose();
    _passwordTextBoxController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nama harus diisi';
    if (value.trim().length < 3) return 'Nama harus minimal 3 karakter';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email harus diisi';
    final pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) return 'Email tidak valid';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password harus diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  String? _validatePasswordConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Konfirmasi password harus diisi';
    if (value != _passwordTextBoxController.text) return 'Konfirmasi password tidak sama';
    return null;
  }

  Future<void> _onSubmit() async {
    // langsung validasi tanpa menyimpan var yang tak terpakai
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulasi proses registrasi (ganti dengan panggilan API / service sesungguhnya)
      await Future.delayed(const Duration(milliseconds: 600));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil. Silakan login.')),
        );
        Navigator.pop(context); // kembali ke halaman login
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi error saat registrasi: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi Ariza")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaTextBoxController,
                decoration: const InputDecoration(labelText: "Nama"),
                keyboardType: TextInputType.text,
                validator: _validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailTextBoxController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordTextBoxController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: const InputDecoration(labelText: "Password Konfirmasi"),
                obscureText: true,
                validator: _validatePasswordConfirm,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text("Registrasi Ariza"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
