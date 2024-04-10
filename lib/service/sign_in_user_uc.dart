import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/data/user/auth_repository.dart';
import 'package:meteo_sncf/data/user/user_network_repository.dart';

class SignInUserUC {
  final _authRepo = GetIt.I<AuthRepository>();
  final _userNetworkRepo = GetIt.I<UserNetworkRepository>();

  Future<String?> handle(String email, String password) async {
    try {
      final userAuthId = await _authRepo.authenticateUser(email, password);
      if (userAuthId != null) {
        final user = await _userNetworkRepo.getAuthenticatedUser(userAuthId);
        return user.firstName;
      }
      return null;
    } catch (_) {
      // Hors périmètre pour le projet : gérer les erreurs
      return null;
    }
  }
}
