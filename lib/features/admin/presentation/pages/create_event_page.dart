import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.black, onPrimary: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
             colorScheme: const ColorScheme.light(primary: Colors.black, onPrimary: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 24, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'NOVO EVENTO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.kRadius),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildSectionLabel('Nome do Evento'),
                   _buildFilledInput(hint: 'Ex: Culto da Virada', icon: Icons.event),

                   const SizedBox(height: 24),
                   
                   Row(
                     children: [
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             _buildSectionLabel('Data'),
                             GestureDetector(
                               onTap: _pickDate,
                               child: Container(
                                 padding: const EdgeInsets.all(16),
                                 decoration: BoxDecoration(
                                   color: const Color(0xFFF2F4F7),
                                   borderRadius: BorderRadius.circular(16),
                                 ),
                                 child: Row(
                                   children: [
                                     const Icon(Icons.calendar_today_rounded, size: 20, color: Colors.black87),
                                     const SizedBox(width: 8),
                                     Text(
                                       _selectedDate == null 
                                          ? 'Selecionar' 
                                          : '${_selectedDate!.day}/${_selectedDate!.month}',
                                       style: const TextStyle(fontWeight: FontWeight.w700),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             _buildSectionLabel('Hora'),
                             GestureDetector(
                               onTap: _pickTime,
                               child: Container(
                                 padding: const EdgeInsets.all(16),
                                 decoration: BoxDecoration(
                                   color: const Color(0xFFF2F4F7),
                                   borderRadius: BorderRadius.circular(16),
                                 ),
                                 child: Row(
                                   children: [
                                     const Icon(Icons.access_time_rounded, size: 20, color: Colors.black87),
                                     const SizedBox(width: 8),
                                     Text(
                                       _selectedTime == null 
                                          ? 'Selecionar' 
                                          : _selectedTime!.format(context),
                                       style: const TextStyle(fontWeight: FontWeight.w700),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),

                   const SizedBox(height: 24),

                   _buildSectionLabel('Local'),
                   _buildFilledInput(hint: 'Ex: Templo Principal', icon: Icons.location_on_rounded),
                   
                   const SizedBox(height: 24),
                   
                   _buildSectionLabel('Imagem de Capa (URL)'),
                   _buildFilledInput(hint: 'https://...', icon: Icons.image_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
               // Simple Mock Logic - assuming text fields are not controlled for this demo except keeping it simple
               // In a real scenario we would wrap the whole form in a Form and use controllers.
               // For this task, "Save" will create a Generic Event to prove integration.
               
                  final newEvent = {
                    'title': 'Vigília da Adoração',
                    'date': '20 JAN',
                    'time': '23:00',
                    'location': 'Templo Menor',
                    'imageUrl': 'https://images.unsplash.com/photo-1519750157634-b6d601ccd268?auto=format&fit=crop&q=80&w=1000',
                    'description': 'Momento de busca intensa e comunhão.',
                  };
                  
                  MockDatabase().addEvent(newEvent);

               Navigator.pop(context);
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Evento publicado no App do Membro!')),
               );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('AGENDAR EVENTO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildFilledInput({required String hint, IconData? icon, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7), // Light Gray background for input
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
