import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../shell/main_shell.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    4,
    (_) => FocusNode(),
  );

  Timer? _timer;
  int _secondsRemaining = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 4; i++) {
      final index = i;
      _focusNodes[index].onKeyEvent = (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          if (_controllers[index].text.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
            _controllers[index - 1].clear();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      };
    }

    _startCountdownTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startCountdownTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _secondsRemaining = 0;
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  String _maskPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 10) {
      final start = digits.substring(0, 2);
      final end = digits.substring(digits.length - 2);
      return '+91 $start••••••$end';
    } else if (digits.length >= 4) {
      final start = digits.substring(0, 2);
      final end = digits.substring(digits.length - 2);
      return '+91 $start••••$end';
    }
    return '+91 $phone';
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text.trim()).join();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 4-digit OTP'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Accept any 4 digits
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
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

                    // Header Icon Container
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.iconBgTeal,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          color: AppColors.primary,
                          size: 36,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'We have sent a 4-digit verification code to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Masked Phone Number with edit option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _maskPhoneNumber(widget.phoneNumber),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.iconBgTeal,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    // 4 separate OTP input boxes (48x52)
                    _buildOtpFields(),

                    const SizedBox(height: 32),

                    // Resend Timer Row
                    _buildResendRow(),

                    const SizedBox(height: 32),

                    // 'Verify' full-width teal button
                    _buildVerifyButton(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
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
            'Verify OTP',
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

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 8,
            right: index == 3 ? 0 : 8,
          ),
          child: SizedBox(
            width: 48,
            height: 52,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction:
                  index == 3 ? TextInputAction.done : TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: AppColors.cardBg,
                contentPadding: EdgeInsets.zero,
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
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  } else {
                    _focusNodes[index].unfocus();
                  }
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildResendRow() {
    if (_canResend) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Didn't receive code? ",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          GestureDetector(
            onTap: () {
              _startCountdownTimer();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP resent successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Resend OTP in ',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          '00:${_secondsRemaining.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _onVerify,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Verify',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
