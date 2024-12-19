# frontend_presensiv3


lib/
├── core/
│   ├── error/
│   │   └── failure.dart                # Kelas Failure untuk error handling
│   ├── network/
│   │   ├── network_info.dart           # Kelas untuk mengecek status koneksi internet
│   │   └── api_client.dart            # Client untuk API, bisa menggunakan Dio atau HTTP
│   └── usecases/
│       └── use_case.dart              # Kelas dasar UseCase
│
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_data_source.dart   # Mengambil data dari API
│   │   │   ├── models/
│   │   │   │   └── auth_model.dart    # Model data untuk login
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart  # Implementasi repository
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart         # Entitas user
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart  # Interface repository
│   │   │   ├── usecases/
│   │   │   │   └── login_use_case.dart  # UseCase login
│   │   ├── presentation/
│   │   │   ├── blocs/
│   │   │   │   ├── auth_bloc.dart        # BLoC untuk login
│   │   │   │   └── auth_event.dart       # Event untuk login
│   │   │   ├── screens/
│   │   │   │   └── login_screen.dart     # Halaman login
│   │   │   ├── widgets/
│   │   │   │   └── login_form.dart       # Form login
│
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart     # Halaman utama Home
│   │   │   ├── widgets/
│   │   │   │   └── bottom_nav.dart      # Bottom Navigation Widget
│   │   └── domain/
│   │       └── usecases/
│   │           └── get_home_data.dart   # UseCase untuk mengambil data Home
│
│   ├── presensi/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── presensi_screen.dart # Halaman presensi
│   │   └── domain/
│   │       └── usecases/
│   │           └── mark_presence.dart   # UseCase untuk menandai presensi
│
│   └── profile/
│       ├── presentation/
│       │   ├── screens/
│       │   │   └── profile_screen.dart  # Halaman Profile
│       └── domain/
│           └── usecases/
│               └── get_profile_data.dart  # UseCase untuk mengambil data Profile
└── main.dart
