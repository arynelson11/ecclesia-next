import 'package:flutter/material.dart';
import '../../../../core/constants/bible_data.dart';
import '../../../../core/constants/mock_bible_content.dart';
import '../../../../core/theme/app_theme.dart';
import 'chapter_selection_page.dart';

class BibleHomePage extends StatefulWidget {
  const BibleHomePage({super.key});

  @override
  State<BibleHomePage> createState() => _BibleHomePageState();
}

class _BibleHomePageState extends State<BibleHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredOldTestament = [];
  List<Map<String, dynamic>> _filteredNewTestament = [];

  @override
  void initState() {
    super.initState();
    _filteredOldTestament = BibleData.oldTestament;
    _filteredNewTestament = BibleData.newTestament;
  }

  void _filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredOldTestament = BibleData.oldTestament;
        _filteredNewTestament = BibleData.newTestament;
      });
      return;
    }

    setState(() {
      _filteredOldTestament = BibleData.oldTestament
          .where((book) {
             final nameMatch = book['name']!.toLowerCase().contains(query.toLowerCase());
             if (nameMatch) return true;
             return MockBibleContent.containsQuery(book['name']!, query);
          })
          .toList();
      _filteredNewTestament = BibleData.newTestament
          .where((book) {
             final nameMatch = book['name']!.toLowerCase().contains(query.toLowerCase());
             if (nameMatch) return true;
             return MockBibleContent.containsQuery(book['name']!, query);
          })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground, // STRICT BG
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                children: [
                  const Text(
                    'BIBLIOTECA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // STRICT WHITE INPUT
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [AppTheme.kSoftShadow],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterBooks,
                      decoration: const InputDecoration(
                        hintText: 'Buscar livro...',
                        prefixIcon: Icon(Icons.search, color: Colors.black45),
                        filled: true,
                        fillColor: Colors.transparent, // Handled by Container
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                  const SizedBox(height: 24),
                  
                  // Plans Banner
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/bible-plans'),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF111111), Color(0xFF333333)]),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [AppTheme.kSoftShadow],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Planos de Leitura', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(height: 4),
                              Text('Continue seu progresso diário', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: Icon(Icons.arrow_forward, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),



            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_filteredOldTestament.isNotEmpty) ...[
                      const Text(
                        'Antigo Testamento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBookGrid(context, _filteredOldTestament),
                    ],

                    if (_filteredNewTestament.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      const Text(
                        'Novo Testamento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBookGrid(context, _filteredNewTestament),
                    ],
                    
                    if (_filteredOldTestament.isEmpty && _filteredNewTestament.isEmpty)
                       const Center(
                         child: Padding(
                           padding: EdgeInsets.only(top: 48),
                           child: Text("Nenhum livro encontrado.", style: TextStyle(color: Colors.grey)),
                         ),
                       ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookGrid(BuildContext context, List<Map<String, dynamic>> books) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildBookCard(context, book);
      },
    );
  }

  Widget _buildBookCard(BuildContext context, Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ChapterSelectionPage(bookData: book)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // STRICT WHITE
          borderRadius: BorderRadius.circular(AppTheme.kRadius), // STRICT 30
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -15,
              right: -5,
              child: Text(
                book['abbr'] ?? '',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: Colors.black.withValues(alpha: 0.03),
                  letterSpacing: -2.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    book['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800, // Extra Bold
                      color: Colors.black,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
