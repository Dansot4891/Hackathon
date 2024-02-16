class Users {
  late String email, name, pw;

  Users(
    this.email,
    this.name,
    this.pw,
    );

  Users.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    pw = json['pw'];
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'pw': pw,
  };
}

class Post{
  late String like, userid, title, content;

  Post(
    this.like,
    this.userid,
    this.title,
    this.content
  );

  Post.fromjson(Map<String, dynamic> json){
    like = json['like'];
    userid = json['userid'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() => {
        'like': like,
        'userid': userid,
        'title': title,
        'content': content,
  }; 
}
