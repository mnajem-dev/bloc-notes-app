import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Note> _notes = [];

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void _navigateToCreatePage() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNotePage()),
    );

    if (newNote != null && newNote is Note) {
      setState(() {
        _notes.add(newNote);
      });
    }
  }

  void _navigateToDetailPage(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailNotePage(note: _notes[index]),
      ),
    );

    if (result == 'deleted') {
      setState(() {
        _notes.removeAt(index);
      });
    } else if (result is Note) {
      // It was modified
      setState(() {
        _notes[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text('Aucune note'),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                final snippet = note.contenu.length > 30
                    ? '${note.contenu.substring(0, 30)}...'
                    : note.contenu;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _getColorFromHex(note.couleur),
                          width: 8,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(note.titre, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('$snippet\nCréée le ${note.dateCreation.day}/${note.dateCreation.month}/${note.dateCreation.year}'),
                      isThreeLine: true,
                      onTap: () => _navigateToDetailPage(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreatePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
