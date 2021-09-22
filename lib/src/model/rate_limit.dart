class RateLimit {
  final int limit;
  final DateTime reset;
  final int remaining;

  RateLimit({
    required this.limit,
    required this.reset,
    required this.remaining,
  });
}
