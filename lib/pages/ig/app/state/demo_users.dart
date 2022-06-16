import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

/// Demo application users.
enum DemoAppUser {
  sahil,
  sacha,
  reuben,
  gordon,
  anya,
}

/// Convenient class Extension on [DemoAppUser] enum
extension DemoAppUserX on DemoAppUser {
  /// Convenient method Extension to generate an [id] from [DemoAppUser] enum
  String? get id => {
        DemoAppUser.sahil: 'sahil-kumar',
        DemoAppUser.sacha: 'sacha-arbonel',
        DemoAppUser.reuben: 'reuben-turner',
        DemoAppUser.gordon: 'gordon-hayes',
        DemoAppUser.anya: 'anya-forger',
      }[this];

  /// Convenient method Extension to generate a [name] from [DemoAppUser] enum
  String? get name => {
        DemoAppUser.sahil: 'Sahil Kumar',
        DemoAppUser.sacha: 'Sacha Arbonel',
        DemoAppUser.reuben: 'Reuben Turner',
        DemoAppUser.gordon: 'Gordon Hayes',
        DemoAppUser.anya: 'Anya Forger',
      }[this];

  /// Convenient method Extension to generate [data] from [DemoAppUser] enum
  Map<String, Object>? get data => {
        DemoAppUser.sahil: {
          'first_name': 'Sahil',
          'last_name': 'Kumar',
          'full_name': 'Sahil Kumar',
          'user_about': 'help',
        },
        DemoAppUser.sacha: {
          'first_name': 'Sacha',
          'last_name': 'Arbonel',
          'full_name': 'Sacha Arbonel',
          'user_about': 'help',
        },
        DemoAppUser.reuben: {
          'first_name': 'Reuben',
          'last_name': 'Turner',
          'full_name': 'Reuben Turner',
          'user_about': 'help',
        },
        DemoAppUser.gordon: {
          'first_name': 'Gordon',
          'last_name': 'Hayes',
          'full_name': 'Gordon Hayes',
          'user_about': 'help',
        },
        DemoAppUser.anya: {
          'first_name': 'Anya',
          'last_name': 'Forger',
          'full_name': 'Anya Forger',
          'user_about': 'help',
        },
      }[this];

  /// Convenient method Extension to generate a [token] from [DemoAppUser] enum
  Token? get token => <DemoAppUser, Token>{
        // TODO: Add User Frontend Tokens
        DemoAppUser.sahil: const Token(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2FoaWwta3VtYXIifQ.Bw7xRyBh68tYymCURj4FNUGbTJJbe7G62QghJwmZsVQ'),
        DemoAppUser.sacha: const Token(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2FjaGEtYXJib25lbCJ9.QSOpI8Jc4NVx20DcWiDZ9s36TAhNLo-2zjk85r364QQ'),
        DemoAppUser.reuben: const Token(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicmV1YmVuLXR1cm5lciJ9.MmHruBwP61DU8N9yPEHnRpIv9q5yD22feLULLJUBaOI'),
        DemoAppUser.gordon: const Token(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ29yZG9uLWhheWVzIn0.1grBb728Lr9sI4pdZWgzDNk1Rg1jhF4Z660yIuFWo30'),
        DemoAppUser.anya: const Token(
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYW55YS1mb3JnZXIifQ.jFz2YxbAZWUz9VVWKUX1RAgxvz7cewSWwRBUI2Gm26Y'),
      }[this];
}
