# Application Bloc-Notes

Une application Flutter complète de gestion de notes personnelles, réalisée dans le cadre de travaux pratiques.

## Fonctionnalités

- **Créer** des notes avec un titre, un contenu et une couleur personnalisée
- **Lire** ses notes dans une grille masonry colorée
- **Modifier** une note existante
- **Supprimer** une note avec confirmation
- **Rechercher** des notes en temps réel par titre ou contenu
- **Trier** les notes par date (récent/ancien) ou par titre (A→Z / Z→A)
- **Compteur** de notes en temps réel dans l'en-tête
- **Persistance locale** — les notes sont sauvegardées et restaurées entre les sessions via `shared_preferences`
- **Synchronisation cloud** — les notes sont stockées et récupérées depuis **Firebase Cloud Firestore** via un service API dédié
- **Détection de connexion** — indique visuellement l'état du réseau (en ligne/hors ligne) et empêche la synchronisation sans connexion

## Architecture

Le projet est structuré en deux parties pédagogiques :

### Partie 1 — setState & Navigation
Gestion de l'état local avec `setState` et navigation entre les écrans via `Navigator.push` / `Navigator.pop`.

### Partie 2 — Provider & Gestion d'État Global
Refactorisation complète de l'architecture avec le package `provider` :
- `NoteService` (ChangeNotifier) centralise toute la logique métier et la persistance locale
- `ApiService` encapsule toutes les opérations Firestore (GET, POST, DELETE) dans une couche de service séparée
- Les pages consomment l'état via `context.watch<NoteService>()` et `context.read<NoteService>()`
- Séparation claire entre interface, logique métier et accès aux données
- **Firebase Core** initialisé au démarrage de l'application
- **Cloud Firestore** utilisé comme backend de données cloud

## Structure du projet

```
lib/
├── models/
│   └── note.dart            # Modèle de données Note (avec toJson / fromJson)
├── pages/
│   ├── home_page.dart       # Écran principal (liste, recherche, tri)
│   ├── api_notes_page.dart  # Écran de gestion de la synchronisation API
│   ├── create_page.dart     # Formulaire de création / modification
│   └── detail_page.dart     # Affichage détaillé d'une note
├── services/
│   ├── note_service.dart    # Logique métier + persistance locale (ChangeNotifier)
│   └── api_service.dart     # Accès aux données Firestore (GET, POST, DELETE)
└── main.dart                # Point d'entrée, initialisation Firebase & injection du Provider
```

## Technologies utilisées

- [Flutter](https://flutter.dev/)
- [provider](https://pub.dev/packages/provider) — gestion d'état global
- [shared_preferences](https://pub.dev/packages/shared_preferences) — persistance locale des notes
- [firebase_core](https://pub.dev/packages/firebase_core) — initialisation Firebase
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) — base de données cloud temps réel
- [connectivity_plus](https://pub.dev/packages/connectivity_plus) — détection de l'état de la connexion réseau
- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) — grille masonry
- [google_fonts](https://pub.dev/packages/google_fonts) — typographie Poppins

## Prérequis

- Flutter SDK installé
- Un projet Firebase configuré avec un fichier `google-services.json` placé dans `android/app/`
- Cloud Firestore activé dans la console Firebase

## Exécution

```bash
flutter run
```
