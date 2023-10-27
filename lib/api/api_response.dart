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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'message': message,
      'status': status,
    };

    if (data != null) {
      data['data'] = data;
    }

    return data;
  }
}
