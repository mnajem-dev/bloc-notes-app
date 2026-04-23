import 'package:flutter/material.dart';
import '../models/note.dart';

enum SortOption { dateRecent, dateAncien, titreAZ, titreZA }

class NoteService extends ChangeNotifier {
  final List<Note> _notes = [];
  SortOption _sortOption = SortOption.dateRecent;

  SortOption get sortOption => _sortOption;

  List<Note> get notes {
    final sorted = List<Note>.from(_notes);
    switch (_sortOption) {
      case SortOption.dateRecent:
        sorted.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));
        break;
      case SortOption.dateAncien:
        sorted.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));
        break;
      case SortOption.titreAZ:
        sorted.sort((a, b) => a.titre.toLowerCase().compareTo(b.titre.toLowerCase()));
        break;
      case SortOption.titreZA:
        sorted.sort((a, b) => b.titre.toLowerCase().compareTo(a.titre.toLowerCase()));
        break;
    }
    return List.unmodifiable(sorted);
  }

  int get count => _notes.length;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Note> search(String query) {
    if (query.trim().isEmpty) return notes;
    final q = query.toLowerCase();
    return notes.where((n) {
      return n.titre.toLowerCase().contains(q) || n.contenu.toLowerCase().contains(q);
    }).toList();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }
}
