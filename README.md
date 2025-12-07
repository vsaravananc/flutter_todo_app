# 📌 Do-it – A Simple & Fast Todo App

Do-it is a minimal, fast, and user-friendly **Todo application** built with **Flutter**.
It helps users manage daily tasks efficiently with a clean UI, offline storage, and smooth animations.

---

## 🚀 Tech Stack

* **Framework:** Flutter (3.38.1)
* **Language:** Dart
* **Local Storage:** SQLite (sqflite)
* **State Management:** BLoC (flutter_bloc)

---

## 📦 Dependencies Used

```yaml
cupertino_icons: ^1.0.8
sqflite: ^2.4.2
bloc: ^9.1.0
flutter_bloc: ^9.1.1
flutter_intro: ^3.4.0
flex_color_picker: ^3.7.2
path: ^1.9.1
flutter_slidable: ^4.0.3
avatar_glow: ^3.0.1
shared_preferences: ^2.5.3
permission_handler: ^12.0.1
device_info_plus: ^12.3.0
audioplayers: ^6.5.1
showcaseview: ^5.0.1
```

---

## ✨ Features

✔ Create, edit, and delete todos
✔ Organize tasks with smooth slide actions
✔ Local offline storage using SQLite
✔ Beautiful theme using FlexColor
✔ Onboarding walkthrough using ShowcaseView / Flutter Intro
✔ Device info & permissions support
✔ Custom sound effects using AudioPlayers
✔ Persistent user preferences using SharedPreferences
✔ Glowing avatar animation for UI enhancement

---

## 📂 Project Structure 

```
└── 📁lib
    └── 📁controller
        └── 📁category_controller
            └── 📁bloc
                ├── home_bloc_bloc.dart
                ├── home_bloc_event.dart
                ├── home_bloc_state.dart
            └── 📁data
                └── 📁model
                    ├── category_model.dart
                └── 📁use_case
                    ├── home_data.dart
            └── 📁domain
                ├── home_domain.dart
        └── 📁select_category_cubit
            └── 📁busines_login
                ├── data.dart
                ├── domain.dart
                ├── repo.dart
            ├── selectcategory_cubit.dart
        └── 📁todo_controller
            └── 📁bloc
                ├── todo_bloc.dart
                ├── todo_event.dart
                ├── todo_state.dart
            └── 📁data
                └── 📁model
                    ├── todo_model.dart
                └── 📁use_case
                    ├── todo_data.dart
            └── 📁domain
                ├── todo_domain.dart
        └── 📁todo_edit_logic
            └── 📁controller
                ├── todo_edit_controller.dart
            └── 📁data
                ├── todo_edit_data.dart
            └── 📁domain
                ├── todo_edit_domain.dart
            └── 📁repo
                ├── todo_edit_repo.dart
    └── 📁core
        └── 📁dimensions
            ├── dimension.dart
        └── 📁extension
            ├── category_model_extension.dart
            ├── text_style_extension.dart
        └── 📁images
            ├── images.dart
        └── 📁pagebuilder
            ├── page_route_builder.dart
        └── 📁permissions
            ├── notification_permission.dart
        └── 📁platform
            ├── device_verion.dart
        └── 📁route
            ├── routes.dart
        └── 📁services
            ├── app_show_case.dart
            ├── builder_service.dart
            ├── error_handeling_service.dart
            ├── shared_preference_services.dart
        └── 📁themes
            ├── colors.dart
            ├── text_theme.dart
            ├── theme.dart
        └── 📁words
            ├── app_words.dart
    └── 📁database
        ├── create_db.dart
    └── 📁features
        └── 📁edit
            └── 📁presentation
                ├── category_edit_screen.dart
                ├── todo_edit_screen.dart
            └── 📁widget
                └── 📁category
                    └── 📁card
                        ├── category_edit_card.dart
                        ├── category_edit_overlay.dart
                        ├── vertical_more_widget.dart
                    ├── category_body.dart
                    ├── category_edit_header.dart
                └── 📁todo
                    ├── todo_body_widget.dart
        └── 📁home
            └── 📁presentation
                ├── home_screen.dart
            └── 📁widgets
                └── 📁body_widgets
                    ├── home_slidable_widget.dart
                    ├── home_todo_card.dart
                    ├── home_todo_list.dart
                └── 📁floating_widgets
                    ├── home_bottom_task_widget.dart
                    ├── home_category_select_widget.dart
                    ├── home_floating_widget.dart
                └── 📁header_widgets
                    ├── home_category_bottomsheet.dart
                    ├── home_category_header.dart
                    ├── home_category_textfield.dart
                    ├── home_choice_chip.dart
                    ├── home_overlay_entry.dart
        └── 📁settings
        └── 📁splash
            └── 📁presentation
                ├── splash_screen.dart
            └── 📁widget
                ├── splash_animation_widget.dart
                ├── splash_logo_widget.dart
        └── 📁welcome
            └── 📁presentation
                ├── welcome_screen.dart
            └── 📁widget
                ├── welcome_get_started_button_widget.dart
                ├── welcome_indicator_dot_widget.dart
                ├── welcome_indicator_screen.dart
                ├── welcome_screen_holder_widget.dart
    └── 📁widgets
        ├── custom_pop_widget.dart
    └── main.dart
```
---

## 🛠️ How to Run the App

1. **Clone the repository**

   ```bash
   git clone https://github.com/vsaravananc/flutter_todo_app.git
   cd do-it
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

## 📱 Screenshots

<img src="assets/screenshots/home.png" width="300" />

```
assets/screenshots/
  home.png
  add_todo.png
  edit_todo.png
```

---

## 👨‍💻 Author

**Saravanan**

---

## 📄 License

This project currently has **no license**.
(You can add MIT / Apache / GPL later if required.)
