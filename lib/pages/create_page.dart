import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/note_service.dart';

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
        SnackBar(
          content: const Text('Le titre est obligatoire'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final noteService = context.read<NoteService>();
    final isEditing = widget.note != null;

    final note = Note(
      id: isEditing
          ? widget.note!.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
      titre: _titleController.text.trim(),
      contenu: _contentController.text.trim(),
      couleur: _selectedColor,
      dateCreation: isEditing ? widget.note!.dateCreation : DateTime.now(),
      dateModification: isEditing ? DateTime.now() : null,
    );

    if (isEditing) {
      noteService.updateNote(note);
    } else {
      noteService.addNote(note);
    }

    Navigator.pop(context);
  }

  Widget _buildColorPicker() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _colors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final colorHex = _colors[index];
          final isSelected = _selectedColor == colorHex;
          final color = _getColorFromHex(colorHex);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = colorHex;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.black87, width: 3)
                    : Border.all(color: Colors.transparent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.black87)
                  : null,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getColorFromHex(_selectedColor);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black87, size: 28),
            onPressed: _saveNote,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLength: 60,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Titre...',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      minLines: 10,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Commencez à écrire...',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: bgColor,
              child: _buildColorPicker(),
            ),
          ],
        ),
      ),
    );
  }
}
