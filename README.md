# 📱 Wishlist Flutter Mobile

A simple mobile app built with **Flutter** to manage your personal wishlist, organized by urgency and deadlines.

---

## ✨ Features

- Add new wishlist items.
- Organize items by **categories** like:
  - This Week
  - Next Week
  - This Month
  - Next Month
  - This Year
  - Next Year
  - Specific Date
- Mark items as **Done**.
- Postpone items to a later date or different category.
- Overview screen showing items due soon (this week, next week, this month).
- Full wishlist screen with **search** and **filter** options.
- Persistent storage using `shared_preferences` — your data is saved even when you close the app.

---

## 🚀 Getting Started

```bash
# Make sure you have Flutter installed
flutter --version

# Clone this repository
git clone https://github.com/ShiddiqRPL/wishlist-flutter-mobile.git
cd wishlist-flutter-mobile

# Get all Flutter dependencies
flutter pub get

# Run the app
flutter run
```

# 📋 App Roadmap

This checklist will guide the app’s development progress.

---

## 📦 Stage 1: Core Features — CRUD + Local Storage
- [ ] Create `WishlistItem` model
- [ ] Create Wishlist Add Screen
- [ ] Create Wishlist Edit Screen
- [ ] Create Wishlist Detail View
- [ ] Add Delete functionality
- [ ] Set up Hive (or Isar) for local database
- [ ] Connect CRUD actions to local storage

---

## 🗓️ Stage 2: Timeframe Grouping + Postpone
- [ ] Write timeframe grouping logic (This Week, Next Week, This Month, etc.)
- [ ] Main View filtering: show only items up to this month
- [ ] Add filter toggle to show beyond this month
- [ ] Add Done/Undone functionality
- [ ] Add Postpone functionality (+1 day, +1 week, +1 month, +1 year, or specific date)

---

## 🏷️ Stage 3: Category / Tag Management
- [ ] Add category/tag field to wishlist items
- [ ] Filter wishlist items by category
- [ ] (Optional) Create Manage Categories Screen

---

## 🔔 Stage 4: Notification System
- [ ] Install `flutter_local_notifications` package
- [ ] Setup "Due Today" morning reminders
- [ ] Setup "Due This Week" reminders (Monday, Wednesday, Sunday)
- [ ] Setup "Due This Month" reminders (every Monday + last day)
- [ ] Add Notification Settings toggle for user

---

## 🎨 Stage 5: UI/UX Polish
- [ ] Create beautiful Wishlist Card widget
- [ ] Add color codes or labels for different timeframes
- [ ] Animate Done/Undone, Adding, Deleting wishlist items
- [ ] Implement Light/Dark mode toggle

---

## 🚀 Stage 6: (Optional Extras)
- [ ] Setup Cloud Sync (Firebase, Supabase, or custom backend)
- [ ] Add Wishlist Sharing feature
- [ ] Add Backup/Restore wishlist data functionality
- [ ] Setup User Authentication (if needed)

---

# 📈 Progress Tracking

Keep this list updated as you complete tasks!  
**Feel free to check `[x]` as you finish each item!** 🎉