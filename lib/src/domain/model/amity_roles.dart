///[AmityRoles]
class AmityRoles {
  /// Roles
  List<String>? roles;

  /// init [AmityRoles]
  AmityRoles({
    this.roles,
  });

  @override
  String toString() {
    return (roles ?? []).join(',');
  }
}
