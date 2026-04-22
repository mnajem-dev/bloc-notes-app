import 'package:flutter/material.dart';
import '../models/note.dart';

class CreateNotePage extends StatefulWidget {
  final Note? note;

  const CreateNotePage({super.key, this.note});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  final List<String> _colors = [
    '#FFCDD2', // Red
    '#F8BBD0', // Pink
    '#E1BEE7', // Purple
    '#C8E6C9', // Green
    '#FFF9C4', // Yellow
    '#FFE082', // Amber
  ];
  
  String _selectedColor = '#FFCDD2';

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.titre;
      _contentController.text = widget.note!.contenu;
      _selectedColor = widget.note!.couleur;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le titre est obligatoire')),
      );
      return;
    }

    final isEditing = widget.note != null;
    final note = Note(
      id: isEditing ? widget.note!.id : DateTime.now().millisecondsSinceEpoch.toString(),
      titre: _titleController.text.trim(),
      contenu: _contentController.text.trim(),
      couleur: _selectedColor,
      dateCreation: isEditing ? widget.note!.dateCreation : DateTime.now(),
      dateModification: isEditing ? DateTime.now() : null,
    );

    Navigator.pop(context, note);
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _colors.map((colorHex) {
        final isSelected = _selectedColor == colorHex;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = colorHex;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getColorFromHex(colorHex),
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier la note' : 'Nouvelle Note'),
        backgroundColor: _getColorFromHex(_selectedColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 60,
              decoration: const InputDecoration(
                labelText: 'Titre de la note',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              minLines: 4,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Contenu...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Couleur:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildColorPicker(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveNote,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Sauvegarder'),
            ),
          ],
        ),
      ),
    );
  }
}
