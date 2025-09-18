class Idea {
  final String status;
  final String title;
  final String summary;
  final int votes;
  final DateTime date;

  Idea({
    required this.status,
    required this.title,
    required this.summary,
    required this.votes,
    required this.date,
  });

  factory Idea.fromJson(Map<String, dynamic> j) => Idea(
    status: j['status'] as String,
    title: j['title'] as String,
    summary: j['summary'] as String,
    votes: (j['votes'] as num).toInt(),
    date: DateTime.parse(j['date'] as String),
  );
}
