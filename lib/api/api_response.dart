class ApiResponse<T> {
  String message;
  bool status;
  T? data;

  ApiResponse({
    required this.message,
    required this.status,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      message: json['message'] ?? "",
      status: json['status'] ?? false,
      data: json['data'],
    );
  }
}