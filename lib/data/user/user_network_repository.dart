import 'package:meteo_sncf/data/user/model/user.dart';

class UserNetworkRepository {
  static final TEST_USER = User(
    id: 7,
    firstName: 'Ryan',
    lastName: 'C',
    emailAddress: 'rc@sncf.connect.fr',
  );

  /// Hors le périmètre du projet
  ///
  /// Simuler une attente et le retour d'un utilisateur
  Future<User> getAuthenticatedUser(int userAuthId) {
    return Future.delayed(const Duration(seconds: 2), () => TEST_USER);
  }
}
