import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class ApiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'notes';

  /// GET — charge toutes les notes depuis Firestore
  Future<List<Note>> getAllNotes() async {
    final snapshot = await _db
        .collection(_collection)
        .orderBy('dateCreation', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note(
        id: doc.id,
        titre: data['titre'] ?? 'Sans titre',
        contenu: data['contenu'] ?? '',
        couleur: data['couleur'] ?? '#FFFFFF',
        dateCreation: (data['dateCreation'] as Timestamp).toDate(),
        dateModification: data['dateModification'] != null
            ? (data['dateModification'] as Timestamp).toDate()
            : null,
      );
    }).toList();
  }

  /// POST — crée une nouvelle note dans Firestore
  Future<Note> createNote({required String titre, required String contenu}) async {
    final now = DateTime.now();
    final docRef = await _db.collection(_collection).add({
      'titre': titre,
      'contenu': contenu,
      'couleur': '#C8E6C9',
      'dateCreation': Timestamp.fromDate(now),
      'dateModification': null,
    });

    return Note(
      id: docRef.id,
      titre: titre,
      contenu: contenu,
      couleur: '#C8E6C9',
      dateCreation: now,
    );
  }

  /// DELETE — supprime une note par son ID Firestore
  Future<bool> deleteNote(String id) async {
    try {
      await _db.collection(_collection).doc(id).delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}

