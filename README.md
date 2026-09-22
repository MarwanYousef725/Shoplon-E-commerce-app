# Shoplon E-commerce App

> A Flutter shopping app that covers catalog browsing, product details, cart management, checkout UI, and Firebase-backed authentication.

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205822_Shoplon.png?raw=true" width="220" alt="Shoplon splash screen" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210015_Shoplon.png?raw=true" width="220" alt="Shop home" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210026_Shoplon.png?raw=true" width="220" alt="Product details" />
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" />
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.8-0175C2?logo=dart&logoColor=white" />
  <img alt="Firebase" src="https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase&logoColor=black" />
  <img alt="Provider" src="https://img.shields.io/badge/State-Provider-5C6BC0" />
  <img alt="Android" src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white" />
</p>

---

## Overview

Shoplon is a mobile e-commerce client built with Flutter. It is designed as a complete shopping flow for a clothing-style catalog: onboarding, account creation, product discovery, cart updates, payment method selection, and order confirmation.

The product catalog, promotional sliders, user records, and cart documents live in **Cloud Firestore**. Authentication uses **Firebase Auth** (email/password with email verification, plus Google Sign-In). UI state is handled with **Provider**.

Firebase is configured for Android (`google-services.json`). An iOS runner exists from the Flutter project template, but there is no `GoogleService-Info.plist` in this repository, so iOS Firebase is not set up yet.

---

## Features

### Authentication

- Splash screen with auth-aware routing (`Wrapper` + `FirebaseAuth.authStateChanges()`)
- Multi-page onboarding with skip
- Email/password registration and login
- Email verification required before entering the shop
- Google Sign-In
- Password recovery via Firebase password-reset email
- Form validation (required fields, email `@` check, password length)
- Sign out (Firebase Auth + Google session)

### Product experience

- Shop home with Firestore-driven banner sliders
- Category chips (On Sale, Men's, Women's, Kids)
- Popular products and flash-sale sections
- Product details with image gallery, stock status, price, and “you may also like”
- Discover tab with search field UI and expandable category lists
- Bookmark tab as a product grid
- On-sale listing screens

### Shopping

- Add / increment / decrement cart items in Firestore (`cartProducts`)
- Cart badge on the bottom navigation bar (live `StreamBuilder` count)
- Cart review with address card, quantity controls, coupon field, and order summary
- Payment method screen: pay with card (static card artwork) or cash on delivery
- Order summary and order confirmation screens
- Checkout completion clears the current user's cart documents

### Account

- Profile header with display name / Firestore user name and email
- Account menu (Orders, Returns, Addresses, Payment, Wallet)
- Cookie preferences screen
- Light / dark appearance toggle persisted with `SharedPreferences`
- Wallet screen with a static balance display and history UI backed by cart product data
  
---

## Application Preview

Screenshots extracted from the app running on Android.

### Onboarding

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205822_Shoplon.png?raw=true" width="200" alt="Splash" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205826_Shoplon.png?raw=true" width="200" alt="Onboarding browse" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205828_Shoplon.png?raw=true" width="200" alt="Onboarding cart" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205832_Shoplon.png?raw=true" width="200" alt="Onboarding tracking" />
</p>

### Authentication

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205839_Shoplon.png?raw=true" width="230" alt="Login" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205845_Shoplon.png?raw=true" width="230" alt="Sign up" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210157_Shoplon.png?raw=true" width="230" alt="Login dark theme" />
</p>

### Home & discovery

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210015_Shoplon.png?raw=true" width="230" alt="Shop" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210041_Shoplon.png?raw=true" width="230" alt="Discover" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210048_Shoplon.png?raw=true" width="230" alt="Bookmark" />
</p>

### Product experience

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210026_Shoplon.png?raw=true" width="260" alt="Product details" />
</p>

### Cart & checkout

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210057_Shoplon.png?raw=true" width="200" alt="Cart" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210103_Shoplon.png?raw=true" width="200" alt="Payment method" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210105_Shoplon.png?raw=true" width="200" alt="Order" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210108_Shoplon.png?raw=true" width="200" alt="Order confirmation" />
</p>

### Profile

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210115_Shoplon.png?raw=true" width="200" alt="Profile" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210120_Shoplon.png?raw=true" width="200" alt="Wallet" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210126_Shoplon.png?raw=true" width="200" alt="Cookie preferences" />
</p>

### Dark theme

<p align="center">
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210140_Shoplon.png?raw=true" width="180" alt="Shop dark" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210145_Shoplon.png?raw=true" width="180" alt="Discover dark" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210147_Shoplon.png?raw=true" width="180" alt="Bookmark dark" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210148_Shoplon.png?raw=true" width="180" alt="Empty cart dark" />
  <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-210150_Shoplon.png?raw=true" width="180" alt="Profile dark" />
</p>

---

## Demo

A walkthrough of splash, authentication, shopping, cart, and checkout can be placed here.

<p align="center">
  <a href="https://youtube.com/shorts/qodYNR7dzDM">
    <img src="https://github.com/MarwanYousef725/Shoplon-E-commerce-app/blob/main/assets/screenshots/Screenshot_20260922-205822_Shoplon.png?raw=true" width="220" alt="Shoplon splash — tap to watch demo">
  </a>
</p>

## Tech Stack

| Technology | Role in this project |
| --- | --- |
| **Flutter / Dart** (`sdk: ^3.8.1`) | Cross-platform UI. Package name: `ecommerce_app`. App label on Android: **Shoplon**. |
| **Provider** | App-wide `ChangeNotifier`s for auth forms, catalog, cart, theme, onboarding, and tab index. |
| **Firebase Core** | Initializes the Firebase app in `main()`. |
| **Firebase Authentication** | Email/password, email verification, Google credentials, password-reset email, session stream. |
| **Cloud Firestore** | `users`, `Products`, `Sliders`, and `cartProducts` collections. |
| **Google Sign-In** | OAuth account picker wired into Firebase Auth. |
| **SharedPreferences** | Persists light/dark theme. |
| **cached_network_image** | Loads remote product and slider images with placeholders and error widgets. |
| **flutter_launcher_icons** | Generates launcher icons from `assets/logo/logo2.png`. |

There is no REST client (`http` / `Dio`), no BLoC, and no local database package declared in `pubspec.yaml`. Product data is read from Firestore, not from a custom backend API.

---

## Architecture

The project is a **feature-grouped Flutter app** with a thin Firebase data layer and Provider as the state layer. It is **not** Clean Architecture: screens often talk to Firestore directly (especially cart and checkout), while catalog/users/sliders also go through small database helper classes.

```text
lib/
├── main.dart                      # Firebase init, MultiProvider, MaterialApp theme
├── Providers/                     # ChangeNotifiers (auth, catalog, cart, theme, UI)
├── firebase/
│   ├── auth.dart                  # AuthService (register, sign-in, sign-out)
│   ├── database.dart              # Firestore helpers for users, products, sliders
│   ├── model_products.dart
│   ├── model_users.dart
│   └── model_sliders.dart
├── core/
│   ├── wraper.dart                # Auth gate → splash
│   ├── product.dart               # Reusable ProductCard
│   └── product_details.dart
├── start_screens/                 # Splash, onboarding, login, sign-up
├── forget_password_screens/       # Recovery + extra verification UI screens
├── home_screens/                  # Shop, discover, bookmark, profile, wallet
└── cart_screens/                  # Cart, payment, order, receipt
```

**Navigation:** imperative `Navigator` + `MaterialPageRoute`. The signed-in shell is `HomeScreen` with a `BottomNavigationBar` and `IndexedStack` (Shop, Discover, Bookmark, Cart, Profile).

**Data flow (catalog):** `ShopScreen` / product grids → `ProductProvider.loadProducts()` → `DatabaseProducts.getProducts()` → Firestore `Products`.

**Data flow (cart):** product details and cart screens write/read `cartProducts` documents keyed by the Firebase user `uid`.

---

## Engineering Highlights

- **Auth gate.** `Wrapper` listens to `authStateChanges()` and only treats a session as logged in when `emailVerified` is true.
- **Provider composition.** `main.dart` registers dedicated notifiers instead of a single global store (login, signup, products, sliders, cart, theme, tab index).
- **Firestore models.** `Product`, `UserInfo`, and `Sliders` implement `fromJson` / `toJson`.
- **Live cart count.** The cart tab icon uses a Firestore snapshot filtered by `currentUser.uid`.
- **Reusable product UI.** `ProductCard` is shared across shop sections and product details (“You may also like”).
- **Theme persistence.** `ThemeProvider` stores `isDark` in `SharedPreferences` and drives `themeMode`.
- **Image loading.** Remote images use `CachedNetworkImage` with loading and error states.
- **Form UX.** Password visibility toggles, loading indicators on auth buttons, and `SnackBar` feedback for success/failure.
- **Asset variants.** Onboarding and several illustrations ship light and dark artwork.

---

## Project Structure

```text
ecommerce_app/
├── android/                 # Android host, Google Services plugin, google-services.json
├── ios/                     # Flutter iOS runner (Firebase iOS config not present)
├── lib/                     # Application source
├── assets/                  # Illustrations, logos, local product/profile images
├── docs/screenshots/        # README preview images
├── test/                    # Default Flutter template test (see Testing)
├── pubspec.yaml
└── README.md
```

`build/`, `.dart_tool/`, and IDE folders are generated and are not part of the application design.

---

## Getting Started

### Prerequisites

- Flutter SDK compatible with **Dart `^3.8.1`**
- Android toolchain (Android Studio / SDK). `minSdk` is at least **24**; `compileSdk` is **36**
- A Firebase project with Authentication (Email/Password and Google) and Cloud Firestore enabled
- For Google Sign-In on Android: SHA-1 registered in Firebase and matching OAuth client

### Installation

```bash
git clone <repository-url>
cd ecommerce_app
flutter pub get
```

### Configuration

1. Create or select a Firebase project.
2. Enable **Email/Password** and **Google** sign-in.
3. Create Firestore collections used by the app:
   - `Products` — catalog documents (`image`, `text1`, `text2`, `price`, `pricedis`, `productinfo`, `discount`, `available`)
   - `Sliders` — home banners (`image`, `text1`, `text2`, `text3`)
   - `users` — created on email registration (`name`, `email`, `createdAt`)
   - `cartProducts` — written at runtime (`id` = Firebase uid plus product fields)
4. Place Android config at `android/app/google-services.json` (already present in this working copy).
5. For iOS, add `ios/Runner/GoogleService-Info.plist` and run `flutterfire configure` if you want Firebase on iOS.

---

## Running the project

```bash
flutter run
```

Android only (typical for this repo):

```bash
flutter run -d android
```

---

## Building

```bash
flutter build apk
flutter build appbundle
```

Release signing currently uses the **debug** keystore in `android/app/build.gradle.kts`. Replace that before a Play Store upload.

---

## Testing

Automated tests for Shoplon flows are not included.

`test/widget_test.dart` is still the default Flutter counter smoke test and does not match this app. Treat the suite as a placeholder until real widget/integration tests are added.

```bash
flutter test
```

---

## Security Considerations

- **`android/app/google-services.json` is in the tree.** It contains the Firebase project id, Android API key, and OAuth client IDs. That file is commonly committed for Android apps, but a **public** GitHub repo should not rely on it as a secret: restrict API keys in Google Cloud, lock down OAuth clients, and rotate keys if this copy was ever shared widely.
- Do **not** commit additional service-account JSON, `.env` secrets, or unrestricted API keys.
- **Firestore security rules** are not stored in this repository. Before any public or multi-user deployment, restrict `Products` / `Sliders` to reads as needed and limit `cartProducts` and `users` writes to the authenticated owner. Open rules would allow anyone to read or modify carts.
- Order confirmation screenshots may show a real account email. Redact PII if you republish marketing images.
- Password-reset and email verification depend on Firebase Auth email templates (check spam folders, as the in-app copy already notes).

---

## Roadmap

- [ ] Persist placed orders in Firestore instead of only deleting cart documents
- [ ] Connect Discover search and category chips to real product queries
- [ ] Store bookmarks per user instead of listing the full catalog
- [ ] Implement profile destinations (orders, addresses, payment methods)
- [ ] Replace static wallet balance / card artwork with a real payments provider if the product requires it
- [ ] Add `GoogleService-Info.plist` and verify iOS Firebase
- [ ] Replace the template widget test with auth, cart, and catalog tests
- [ ] Add Firestore rules to the repo and review them before production
- [ ] Move release signing off the debug keystore
- [ ] Specify a license if the repository will be public

---

## Contributing

This is a personal portfolio project. If you fork it:

1. Open an issue or describe the change first for anything larger than a typo.
2. Keep Firebase config and secrets out of pull requests.
3. Match the existing Dart style (`flutter analyze` / `flutter_lints`).

---

## License

A license has not been specified for this repository.

---

## Author

**Marwan Yousef**

Flutter developer — Shoplon E-commerce App

- GitHub: https://github.com/MarwanYousef725
- LinkedIn: https://www.linkedin.com/in/marwanyouseff/
- Portfolio: https://marwanyousef725.github.io/Marwan-Yousef/
