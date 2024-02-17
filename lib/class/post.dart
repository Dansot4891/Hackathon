class Post {
  final int id;
  final String name;
  final String content;
  final int likeCount;
  final String nickname;
  final String emoji;

  Post({
    required this.id,
    required this.name,
    required this.content,
    required this.likeCount,
    required this.nickname,
    required this.emoji,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      likeCount: json['likeCount'],
      nickname: json['nickname'],
      emoji: json['emoji'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'likeCount': likeCount,
      'nickname': nickname,
      'emoji': emoji,
    };
  }
}

class PostResponse {
  final int code;
  final String msg;
  final PostData data;

  PostResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      code: json['code'],
      msg: json['msg'],
      data: PostData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data.toJson(),
    };
  }
}

class PostData {
  final List<Post> posts;
  final int totalPages;
  final int currentPage;

  PostData({
    required this.posts,
    required this.totalPages,
    required this.currentPage,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    List<Post> posts = (json['posts'] as List)
        .map((postJson) => Post.fromJson(postJson))
        .toList();
    return PostData(
      posts: posts,
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((post) => post.toJson()).toList(),
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }
}