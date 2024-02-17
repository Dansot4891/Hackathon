class CommentResponse {
  final int code;
  final String msg;
  final List<CommentData> data;

  CommentResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    List<CommentData> commentList = [];
    if (json['data'] != null) {
      commentList = (json['data'] as List)
          .map((item) => CommentData.fromJson(item))
          .toList();
    }
    return CommentResponse(
      code: json['code'] ?? 0,
      msg: json['msg'] ?? '',
      data: commentList,
    );
  }
}

class CommentData {
  final String comment;
  final String nickname;
  final String emoji;

  CommentData({
    required this.comment,
    required this.nickname,
    required this.emoji,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      comment: json['comment'] ?? '',
      nickname: json['nickname'] ?? '',
      emoji: json['emoji'] ?? '',
    );
  }
}