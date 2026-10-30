import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import 'otp_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your phone number'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile number'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OTPVerificationPage(phoneNumber: phone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──
            _buildTopBar(context),

            // ── Main Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),

                    // App logo area: Container with teal border and '+' icon + 'Book My Test' text
                    _buildLogoArea(),

                    const SizedBox(height: 48),

                    // Subtitle: 'Enter your phone number to continue'
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your phone number to continue',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Phone input with '+91' prefix widget, rounded border (12px)
                    _buildPhoneInput(),

                    const SizedBox(height: 24),

                    // 'Send OTP' full-width teal button (52px height, rounded 14px)
                    _buildSendOtpButton(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom text: 'By continuing, you agree to our Terms & Conditions'
            _buildBottomTerms(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoArea() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.iconBgTeal,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: AppColors.primary,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Book My Test',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 1.2,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.cardBg,
          hintText: 'Enter 10-digit mobile number',
          hintStyle: const TextStyle(
            color: AppColors.textHint,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🇮🇳',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Text(
                  '+91',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.border,
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
          ),
        ),
      ),
    );
  }

  Widget _buildSendOtpButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _onSendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Send OTP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTerms() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          children: [
            TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms & Conditions',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
