# Ausgaben-Tracker App

Eine einfache Flutter-App zum Verwalten und Filtern von Ausgaben.  
Die App nutzt das **BLoC-Pattern** für State Management und speichert Daten lokal.

---

## Features

- Ausgaben hinzufügen (Betrag, Kategorie, Beschreibung, Datum)  
- Ausgaben löschen  
- Ausgaben nach Kategorie filtern  
- Übersicht über alle Ausgaben  
- Snackbars für erfolgreiche Aktionen (Erstellen/Löschen von Einträgen)

---

## Setup & Installation

1. Repository klonen

```bash
git clone <REPO_URL>
cd finance_tracker_app
```

2. Abhängigkeiten installieren
```bash
flutter pub get
```

3. App starten
```bash
flutter run
```

## Projektinformationen

Name: finance_tracker_app
Version: 0.1.0


Wichtige Abhängigkeiten:
- flutter_bloc: ^9.1.1 – für BLoC State Management
- intl: ^0.20.2 – für Datumsformatierung
- Die App wurde mit Flutter SDK >=3.6.0 <4.0.0 entwickelt.

## Projektstruktur
<pre lang="md">
lib/
├── core/
│   ├── app_colors.dart
│   ├── app_theme.dart
│   └── utils/
│       ├── expense_category.dart
│       └── truncate_decimals.dart
├── features/
│   └── expenses/
│       ├── bloc/
│       │   ├── expense_bloc.dart
│       │   ├── expense_event.dart
│       │   └── expense_state.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── expense.dart
│       │   ├── provider/
│       │   │   ├── local_database.dart
│       │   │   └── mockdata.dart
│       │   └── repos/
│       │       └── database_repo.dart
│       └── presentation/
│           ├── screens/
│           │   └── expenses_screen.dart
│           └── widgets/
│               ├── amount_field.dart
│               ├── category_dropdown.dart
│               ├── confirm_button.dart
│               ├── description_field.dart
│               ├── expense_card.dart
│               └── new_expense_modal.dart
└── main.dart
</pre>
