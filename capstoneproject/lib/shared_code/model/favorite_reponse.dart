class FavoriteResponse {
  final bool success;
  final List<int> data;
  final String error;

  FavoriteResponse(
    this.data,
    this.error,
    this.success,
  );

  FavoriteResponse.fromJson(dynamic json)
      : success = json['success'],
        data = List<int>.from(json['data']),
        error = json['error'] ?? "";
  FavoriteResponse.withError(this.error)
      : success = false,
        data = [];
}
