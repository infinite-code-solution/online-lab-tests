import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BookBloodTestPage extends StatefulWidget {
  const BookBloodTestPage({super.key});

  @override
  State<BookBloodTestPage> createState() => _BookBloodTestPageState();
}

class _BookBloodTestPageState extends State<BookBloodTestPage> {
  int _selectedLab = 0;
  int _selectedPatient = 0;
  int _selectedCollection = 0; // 0 = Home Collection, 1 = Center Visit
  int _selectedTimeSlot = 0;
  String? _selectedGender;

  final _ageController = TextEditingController();
  final _flatController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _addressController = TextEditingController();

  static const _labs = ['First Health Labs', 'Lab logo', 'Lab logo'];
  static const _timeSlots = ['7–9 AM', '9–11 AM', '11 AM–1 PM', '4–6 PM'];

  @override
  void dispose() {
    _ageController.dispose();
    _flatController.dispose();
    _landmarkController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──
            _buildTopBar(context),

            // ── Scrollable body ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildTestCard(),
                    const SizedBox(height: 24),
                    _buildSelectLab(),
                    const SizedBox(height: 24),
                    _buildPatientToggle(),
                    const SizedBox(height: 20),
                    _buildFormFields(),
                    const SizedBox(height: 16),
                    _buildCollectionToggle(),
                    const SizedBox(height: 24),
                    _buildTimeSlots(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom bar: Total + Pay Now ──
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ── Top bar ───────────────────────────────────────────────

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
            'Book Blood Test',
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

  // ── Test card ─────────────────────────────────────────────

  Widget _buildTestCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.water_drop_outlined,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete Blood Count (CBC)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '[Test requirements]',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Select lab ────────────────────────────────────────────

  Widget _buildSelectLab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('SELECT LAB'),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_labs.length, (i) {
              final isSelected = i == _selectedLab;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedLab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: isSelected
                          ? AppColors.iconBgTeal.withValues(alpha: 0.4)
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textHint.withValues(alpha: 0.45),
                        width: isSelected ? 2 : 1.5,
                      ),
                    ),
                    child: Text(
                      _labs[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── Patient toggle ────────────────────────────────────────

  Widget _buildPatientToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('PATIENT'),
        const SizedBox(height: 10),
        Row(
          children: [
            _toggleChip('Self', 0, _selectedPatient,
                (i) => setState(() => _selectedPatient = i)),
            const SizedBox(width: 10),
            _toggleChip('Add member', 1, _selectedPatient,
                (i) => setState(() => _selectedPatient = i)),
          ],
        ),
      ],
    );
  }

  // ── Form fields ───────────────────────────────────────────

  Widget _buildFormFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'AGE',
                hint: 'Age',
                controller: _ageController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildGenderDropdown()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'FLAT / H. NO.',
                hint: 'Flat / H. No.',
                controller: _flatController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                label: 'LANDMARK',
                hint: 'Landmark',
                controller: _landmarkController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'ADDRESS',
          hint: 'Street, area, pincode',
          controller: _addressController,
        ),
      ],
    );
  }

  // ── Home Collection / Center Visit toggle ─────────────────

  Widget _buildCollectionToggle() {
    return Row(
      children: [
        Expanded(
          child: _toggleChipFull('Home Collection', 0, _selectedCollection,
              (i) => setState(() => _selectedCollection = i)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _toggleChipFull('Center Visit', 1, _selectedCollection,
              (i) => setState(() => _selectedCollection = i)),
        ),
      ],
    );
  }

  // ── Time slots ────────────────────────────────────────────

  Widget _buildTimeSlots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('TIME SLOT'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(_timeSlots.length, (i) {
            final isSelected = i == _selectedTimeSlot;
            return GestureDetector(
              onTap: () => setState(() => _selectedTimeSlot = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.primary : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.access_time,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      _timeSlots[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── Bottom bar ────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '₹349',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────

  Widget _toggleChip(
      String label, int index, int selected, ValueChanged<int> onTap) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _toggleChipFull(
      String label, int index, int selected, ValueChanged<int> onTap) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: AppColors.textHint, fontSize: 15),
            filled: true,
            fillColor: AppColors.cardBg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('GENDER'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              hint: const Text(
                'Select',
                style: TextStyle(color: AppColors.textHint, fontSize: 15),
              ),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary),
              style: const TextStyle(
                  fontSize: 15, color: AppColors.textPrimary),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (val) => setState(() => _selectedGender = val),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Section label ────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
    );
  }
}
