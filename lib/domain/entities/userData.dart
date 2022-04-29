class UserData {
  final String access_token;
  final String token_type;
  final String refresh_token;
  final int expires_in;
  final String scope;
  final String role;
  final String? full_name;
  final String? name;
  final String userid;
  UserData(
      this.access_token,
      this.token_type,
      this.refresh_token,
      this.expires_in,
      this.scope,
      this.role,
      this.full_name,
      this.name,
      this.userid,
      );
}
