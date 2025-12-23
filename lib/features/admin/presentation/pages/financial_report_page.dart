import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

class FinancialReportPage extends StatefulWidget {
  const FinancialReportPage({super.key});

  @override
  State<FinancialReportPage> createState() => _FinancialReportPageState();
}

class _FinancialReportPageState extends State<FinancialReportPage> {
  // State
  List<Map<String, dynamic>> _transactions = [];
  int _selectedFilter = 0; // 0: Tudo, 1: Dízimos, 2: Ofertas, 3: Saídas

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _transactions = MockDatabase().getTransactions();
    });
  }

  // Computed Totals
  double get _totalIncome => _transactions.where((t) => t['type'] == 'credit').fold(0, (sum, t) => sum + (t['amount'] as double));
  double get _totalExpense => _transactions.where((t) => t['type'] == 'debit').fold(0, (sum, t) => sum + (t['amount'] as double));
  double get _balance => _totalIncome - _totalExpense;

  // Filtered List
  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 0) return _transactions;
    if (_selectedFilter == 1) return _transactions.where((t) => t['category'] == 'Dízimo').toList();
    if (_selectedFilter == 2) return _transactions.where((t) => t['category'] == 'Oferta').toList();
    if (_selectedFilter == 3) return _transactions.where((t) => t['type'] == 'debit').toList();
    return _transactions;
  }

  void _showAddTransactionModal() {
    bool isCredit = true;
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String selectedCategory = 'Oferta';
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          final categories = isCredit ? ['Oferta', 'Dízimo', 'Doação', 'Vendas'] : ['Despesas', 'Equipamento', 'Manutenção'];
          if (!categories.contains(selectedCategory)) selectedCategory = categories.first;

          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Novo Lançamento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 24),
                
                // Switch Type
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(child: _buildSwitchOption('Entrada', isCredit, () => setModalState(() => isCredit = true))),
                      Expanded(child: _buildSwitchOption('Saída', !isCredit, () => setModalState(() => isCredit = false))),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Amount
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                  decoration: const InputDecoration(
                    prefixText: 'R\$ ',
                    hintText: '0,00',
                    border: InputBorder.none,
                  ),
                ),
                const Divider(),
                
                // Fields
                TextField(
                  controller: descCtrl, 
                  decoration: const InputDecoration(labelText: 'Descrição', border: InputBorder.none)
                ),
                const Divider(),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: selectedCategory,
                      underline: const SizedBox(),
                      items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) => setModalState(() => selectedCategory = val!),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Data', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () async {
                        final d = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2020), lastDate: DateTime(2030));
                        if(d!=null) setModalState(() => selectedDate = d);
                      },
                      child: Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                    ),
                  ],
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                       if (amountCtrl.text.isNotEmpty && descCtrl.text.isNotEmpty) {
                         final amount = double.tryParse(amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
                         final newTx = {
                           'id': DateTime.now().toString(),
                           'type': isCredit ? 'credit' : 'debit',
                           'amount': amount,
                           'description': descCtrl.text,
                           'category': selectedCategory,
                           'date': selectedDate,
                           'method': 'Manual',
                           'donor': isCredit ? 'Anônimo' : null, 
                         };
                         MockDatabase().addTransaction(newTx);
                         _refreshData();
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lançamento salvo com sucesso!')));
                       }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: const Text('SALVAR LANÇAMENTO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildSwitchOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('FINANCEIRO COMPLETO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          // Dashboard Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(child: _buildSummaryCard('Entradas', _totalIncome, Colors.green)),
                const SizedBox(width: 8),
                Expanded(child: _buildSummaryCard('Saídas', _totalExpense, Colors.red)),
                const SizedBox(width: 8),
                Expanded(child: _buildSummaryCard('Saldo', _balance, Colors.blue)),
              ],
            ),
          ),
          
          const SizedBox(height: 24),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
               children: [
                 _buildFilterChip(0, 'Tudo'),
                 const SizedBox(width: 8),
                 _buildFilterChip(1, 'Dízimos'),
                 const SizedBox(width: 8),
                 _buildFilterChip(2, 'Ofertas'),
                 const SizedBox(width: 8),
                 _buildFilterChip(3, 'Saídas'),
               ],
            ),
          ),
          
          const SizedBox(height: 16),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              itemCount: _filteredTransactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final t = _filteredTransactions[index];
                final isCredit = t['type'] == 'credit';
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [AppTheme.kSoftShadow],
                  ),
                  child: Row(
                     children: [
                       Container(
                         padding: const EdgeInsets.all(12),
                         decoration: BoxDecoration(
                           color: isCredit ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                           shape: BoxShape.circle,
                         ),
                         child: Icon(
                           isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                           color: isCredit ? Colors.green : Colors.red,
                           size: 20
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(t['description'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                             const SizedBox(height: 4),
                             Text(
                               '${DateFormat('dd/MM').format(t['date'])} • ${t['method']}',
                               style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500),
                             ),
                           ],
                         ),
                       ),
                       Text(
                         '${isCredit ? '+' : '-'} ${currency.format(t['amount'])}',
                         style: TextStyle(
                           fontWeight: FontWeight.w900, 
                           color: isCredit ? Colors.green : Colors.red,
                           fontSize: 14,
                         ),
                       ),
                     ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTransactionModal,
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Novo Lançamento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double value, Color color) {
     final currency = NumberFormat.compactSimpleCurrency(locale: 'pt_BR'); // Compact for space
     
     return Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),
         boxShadow: const [AppTheme.kSoftShadow],
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           Text(
             currency.format(value), 
             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color),
             maxLines: 1, 
             overflow: TextOverflow.ellipsis
           ),
         ],
       ),
     );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
