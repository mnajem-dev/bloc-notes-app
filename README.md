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

## Architecture

Le projet est structuré en deux parties pédagogiques :

### Partie 1 — setState & Navigation
Gestion de l'état local avec `setState` et navigation entre les écrans via `Navigator.push` / `Navigator.pop`.

### Partie 2 — Provider & Gestion d'État Global
Refactorisation complète de l'architecture avec le package `provider` :
- `NoteService` (ChangeNotifier) centralise toute la logique métier
- Les pages consomment l'état via `context.watch<NoteService>()` et `context.read<NoteService>()`
- Séparation claire entre interface et logique

## Structure du projet

```
lib/
├── models/
│   └── note.dart            # Modèle de données Note
├── pages/
│   ├── home_page.dart       # Écran principal (liste, recherche, tri)
│   ├── create_page.dart     # Formulaire de création / modification
│   └── detail_page.dart     # Affichage détaillé d'une note
├── services/
│   └── note_service.dart    # Logique métier (ChangeNotifier)
└── main.dart                # Point d'entrée & injection du Provider
```

## Technologies utilisées

- [Flutter](https://flutter.dev/)
- [provider](https://pub.dev/packages/provider) — gestion d'état global
- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) — grille masonry
- [google_fonts](https://pub.dev/packages/google_fonts) — typographie Poppins

## Exécution

```bash
flutter run
```
