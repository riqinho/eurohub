class Challenge {
  final String id;
  final String area;
  final String title;
  final String summary;
  final DateTime deadline;
  final String status;
  final String oQueQueremosResolver;
  final String oQueBuscamos;
  final int likes;

  Challenge({
    required this.id,
    required this.oQueQueremosResolver,
    required this.area,
    required this.title,
    required this.summary,
    required this.deadline,
    required this.status,
    required this.likes,
    required this.oQueBuscamos,
  });

  factory Challenge.fromJson(Map<String, dynamic> j) => Challenge(
    id: j['id'] as String,
    area: j['area'] as String,
    title: j['title'] as String,
    summary: j['summary'] as String,
    deadline: DateTime.parse(j['deadline'] as String),
    status: j['status'] as String,
    likes: (j['likes'] as num).toInt(),
    oQueQueremosResolver: j['o_que_queremos_resolver'] as String,
    oQueBuscamos: j['o_que_buscamos'] as String,
  );
}
