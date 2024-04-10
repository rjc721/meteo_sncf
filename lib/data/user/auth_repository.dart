class AuthRepository {
  /// Hors le périmètre du projet
  ///
  /// Simuler une attente et le retour d'un ID de l'utilisateur authentifié
  Future<int> authenticateUser(String email, String password) async {
    // Envoyer les coordonnées et récupérer une réponse token
    // Enregistrer un access et un refresh token permettant l'utilisateur de rester connecté

    final userAuthId =
        await Future.delayed(const Duration(seconds: 2), () => 1);
    return userAuthId;
  }
}
