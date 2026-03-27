import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({
    super.key,
    required this.onSignin,
    required this.onNavigateToSignup,
    this.isLoading = false,
  });

  final Function(String cpf, String password) onSignin;
  final VoidCallback onNavigateToSignup;
  final bool isLoading;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _documentController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _documentController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignin() {
    if (_formKey.currentState?.validate() ?? false) {
      final cpf = _cpfMaskFormatter.getUnmaskedText();
      widget.onSignin(cpf, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isWeb ? 440 : double.infinity,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? 40 : 24,
                vertical: isWeb ? 48 : 32,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/valid.png',
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 48),
                    TextFormField(
                      controller: _documentController,
                      inputFormatters: [_cpfMaskFormatter],
                      decoration: InputDecoration(
                        labelText: l10n.cpfLabel,
                        hintText: l10n.cpfHint,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.badge_outlined),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return l10n.cpfRequired;
                        }
                        final unmasked =
                            _cpfMaskFormatter.getUnmaskedText();
                        if (unmasked.length != 11) {
                          return l10n.cpfMustHave11Digits;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return l10n.passwordRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ValidButton(
                      label: l10n.signIn,
                      onPressed: widget.isLoading
                          ? null
                          : _handleSignin,
                      isLoading: widget.isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: widget.onNavigateToSignup,
                      child: Text(l10n.noAccountSignUp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
