class ServerExcepiton implements Exception{


  const ServerExcepiton({
    required this.massage,
  });

  final String massage;

}

class EmptyExcepiton implements Exception{
  final bool isEmpty;

  EmptyExcepiton(this.isEmpty);
}