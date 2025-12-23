import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'intl.dart'; // We will create a small helper since we can't easily add packages
import '../../../../core/theme/app_theme.dart';

class GivingPage extends StatefulWidget {
  const GivingPage({super.key});

  @override
  State<GivingPage> createState() => _GivingPageState();
}

class _GivingPageState extends State<GivingPage> {
  final TextEditingController _controller = TextEditingController(text: 'R\$ 0,00');
  int _selectedChipIndex = -1;
  int _selectedPaymentMethod = 0; // 0: PIX, 1: Card

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatCurrency);
  }

  @override
  void dispose() {
    _controller.removeListener(_formatCurrency);
    _controller.dispose();
    super.dispose();
  }

  void _formatCurrency() {
    String text = _controller.text;
    // Remove non-digits
    String digits = text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.isEmpty) digits = "0";
    
    double value = double.parse(digits) / 100;
    
    // Simple formatting manual to avoid intl dependency issues if strict
    String formatted = "R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}";
    
    // Only update if changed to avoid loop
    if (_controller.text != formatted) {
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _onChipSelected(int index, double amount) {
    setState(() {
      _selectedChipIndex = index;
      String formatted = "R\$ ${amount.toStringAsFixed(2).replaceAll('.', ',')}";
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('CONTRIBUIR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(flex: 1),
          
          Text(
            'Quanto você quer ofertar?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          
          // GIANT REAL TEXT FIELD
          Center(
            child: IntrinsicWidth(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 56, 
                  fontWeight: FontWeight.w900, 
                  color: Colors.black, 
                  letterSpacing: -2.0
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
          
          const Spacer(flex: 1),

          // SUGGESTION CHIPS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _buildChip(0, 50.00),
                const SizedBox(width: 12),
                _buildChip(1, 100.00),
                const SizedBox(width: 12),
                _buildChip(2, 200.00),
                const SizedBox(width: 12),
                _buildChip(3, 125.50), // "Valor quebrado" test
              ],
            ),
          ),

          const Spacer(flex: 2),

          // PAYMENT METHOD & BUTTON
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [AppTheme.kSoftShadow],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Payment Method Selector
                  Row(
                    children: [
                      Expanded(child: _buildPaymentMethod(0, 'PIX', Icons.qr_code_rounded)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildPaymentMethod(1, 'Cartão', Icons.credit_card_rounded)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Oferta de ${_controller.text} confirmada!')),
                         );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('CONFIRMAR OFERTA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(int index, double amount) {
    final isSelected = _selectedChipIndex == index;
    // Manual format
    String formatted = "R\$ ${amount.toStringAsFixed(2).replaceAll('.', ',')}";
    
    return GestureDetector(
      onTap: () => _onChipSelected(index, amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: isSelected ? null : Border.all(color: Colors.grey[200]!),
        ),
        child: Text(
          formatted,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(int index, String label, IconData icon) {
    final isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2F4F7) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey[200]!, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.black : Colors.grey),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
