import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/mock_bible_content.dart';

class ReadingViewPage extends StatefulWidget {
  final Map<String, dynamic> bookData;
  final int chapter;

  const ReadingViewPage({super.key, required this.bookData, this.chapter = 1});

  @override
  State<ReadingViewPage> createState() => _ReadingViewPageState();
}

class _ReadingViewPageState extends State<ReadingViewPage> {
  double _fontSize = 20.0;
  String _version = 'NVI';
  bool _isDarkMode = false;
  late List<String> _verses;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  void _loadContent() {
    _verses = MockBibleContent.getVerses(widget.bookData['name'], widget.chapter);
  }

  void _showFontSizeSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    'Aparência',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 18,
                      color: _isDarkMode ? Colors.white : Colors.black87
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Font Size Slider
                  Row(
                    children: [
                      Icon(Icons.text_fields, size: 16, color: _isDarkMode ? Colors.grey : Colors.black54),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 14.0,
                          max: 32.0,
                          divisions: 9,
                          label: _fontSize.round().toString(),
                          activeColor: _isDarkMode ? Colors.white : Colors.black87,
                          inactiveColor: _isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          onChanged: (value) {
                            setModalState(() => _fontSize = value);
                            setState(() => _fontSize = value);
                          },
                        ),
                      ),
                       Icon(Icons.text_fields, size: 32, color: _isDarkMode ? Colors.white : Colors.black87),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Dark Mode Toggle
                  SwitchListTile(
                    title: Text('Modo Noturno', style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black87)),
                    secondary: Icon(Icons.dark_mode, color: _isDarkMode ? Colors.yellow : Colors.grey),
                    value: _isDarkMode,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.grey[600],
                    onChanged: (value) {
                       setModalState(() => _isDarkMode = value);
                       setState(() => _isDarkMode = value);
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showVersionSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Escolha a Versão',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                   color: _isDarkMode ? Colors.white : Colors.black87
                ),
              ),
              const SizedBox(height: 16),
              _buildVersionOption('Nova Versão Internacional', 'NVI'),
              Divider(color: _isDarkMode ? Colors.grey[800] : Colors.grey[200]),
              _buildVersionOption('Almeida Revista e Corrigida', 'ARC'),
              Divider(color: _isDarkMode ? Colors.grey[800] : Colors.grey[200]),
              _buildVersionOption('King James Atualizada', 'KJA'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVersionOption(String name, String abbr) {
    final isSelected = _version == abbr;
    return ListTile(
      title: Text(name, style: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: _isDarkMode ? Colors.white : Colors.black87
      )),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: () {
        setState(() => _version = abbr);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Versão alterada para $name')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final backgroundColor = _isDarkMode ? const Color(0xFF121212) : const Color(0xFFFAF9F6);
    final textColor = _isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF333333);
    final verseNumColor = _isDarkMode ? Colors.grey[600] : Colors.grey[400];
    final iconColor = _isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor, // Match background
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: iconColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${widget.bookData['name']} ${widget.chapter}',
          style: GoogleFonts.merriweather(
            color: _isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields, color: iconColor),
            onPressed: _showFontSizeSettings,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showVersionSelector,
        label: Text(_version),
        icon: const Icon(Icons.compare_arrows, size: 16),
        backgroundColor: _isDarkMode ? Colors.white : Colors.black87,
        foregroundColor: _isDarkMode ? Colors.black : Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: _verses.length + 1,
        itemBuilder: (context, index) {
          if (index == _verses.length) {
            return const SizedBox(height: 100);
          }

          final verseNum = index + 1;
          final text = _verses[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: RichText(
              text: TextSpan(
                children: [
                  // Verse Number (Superscript-like)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(
                        '$verseNum',
                        style: GoogleFonts.inter(
                          fontSize: 10, // Small
                          color: verseNumColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Verse Content
                  TextSpan(
                    text: text,
                    style: GoogleFonts.merriweather(
                      fontSize: _fontSize,
                      height: 1.6,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
