# Application Bloc-Notes (Partie 1)

Une application Flutter de gestion de notes personnelles réalisée dans le cadre de travaux pratiques.
Cette version correspond à la **Partie 1**, qui utilise `setState` et le système de navigation standard (`Navigator.push` / `Navigator.pop`) pour gérer l'état de l'application et les transitions entre les écrans.

## Fonctionnalités (Partie 1)

*   **Affichage des notes :** Liste de toutes les notes sur la page d'accueil avec un aperçu du contenu, la date et la couleur associée.
*   **Création de notes :** Formulaire permettant de définir un titre, un contenu et de choisir une couleur pour la note.
*   **Modification de notes :** Édition du titre, du contenu et de la couleur d'une note existante.
*   **Suppression de notes :** Suppression d'une note avec une boîte de dialogue de confirmation.
*   **Détails de la note :** Affichage complet du contenu d'une note avec un en-tête coloré en fonction de la couleur de la note.

## Structure du projet

*   `lib/models/note.dart` : Modèle de données représentant une note.
*   `lib/pages/home_page.dart` : Écran principal affichant la liste des notes.
*   `lib/pages/create_page.dart` : Écran de création et d'édition d'une note.
*   `lib/pages/detail_page.dart` : Écran affichant les détails d'une note et permettant sa modification ou sa suppression.

## Exécution

Assurez-vous d'avoir Flutter installé sur votre machine. Ensuite, pour lancer le projet, exécutez simplement la commande suivante dans le terminal :

```bash
flutter run
```
