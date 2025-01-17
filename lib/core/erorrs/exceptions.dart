abstract class Exceptions {
  final String message;

  Exceptions(this.message);
}

class ServerException extends Exceptions {
  ServerException(super.message);

  @override
  String toString() {
    return message;
  }
}


class CacheException extends Exceptions {
  CacheException(super.message);

  @override
  String toString() {
    return message;
  }
}
