class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const String authUrl = '$baseUrl/auth';
  static const String loginUrl = '$authUrl/login';
  static const String todosCrud = '$baseUrl/todos';
  static const String todosUser = '$baseUrl/todos/user';
  static const String todosAdd='$todosCrud/add';
  static const String todosUpdate='$baseUrl/todos/';
  static const String todosDelete='$baseUrl/todos/';
  static const String docsPagination =
      'https://dummyjson.com/todos?limit=10&skip=10';
}
