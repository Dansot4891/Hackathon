import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wagle_front/class/comment.dart';
import 'package:wagle_front/class/course.dart';
import 'package:wagle_front/class/coursedetail.dart';
import 'package:wagle_front/class/post.dart';
import 'package:wagle_front/main.dart';
import 'package:http/http.dart' as http;

class CourseInfo extends StatefulWidget {
  final String id;

  CourseInfo({required this.id});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

String baseurl =
    'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com/v1/';

class _CourseInfoState extends State<CourseInfo> {
  late CourseDetail courses;
  List<PostCourseDetailResponseDto> post = [];
  final String getCourse = baseurl + 'course/';

  // final String getComment = 'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com/v1/post/${postid}/comment';

  List<String> commentUrl = [];

  Future<void> fetchCourseDetailsFromServer() async {
    final response = await http.get(Uri.parse(getCourse + widget.id));
    // print(response.body);
    if (response.statusCode == 200) {
      late CourseDetail courseDetails;
      final json = jsonDecode(response.body);
      courseDetails = CourseDetail.fromJson(json);
      post = courseDetails.postCourseDetailResponseDtoList;
      for (int i = 0; i < post.length; i++) {
        print(post[i].postId);
        postids.add(post[i].postId);
        showComment.add(false);
        postlikes.add(false);
        final response = await http
            .get(Uri.parse(baseurl + 'post/${post[i].postId}/comment'));
        if (response.statusCode == 200) {
          late CommentResponse firstcomment;
          final json = jsonDecode(response.body);
          firstcomment = CommentResponse.fromJson(json);
          comments = firstcomment.data;
        } else {
          throw Exception('Failed to load course details');
        }
      }
      courses = courseDetails;
    } else {
      throw Exception('Failed to load course details');
    }
  }

  List<CommentData> comments = [];

  bool isloading = true;
  bool like = false;
  List<int> postids = [];
  List<bool> postlikes = [];
  List<bool> showComment = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchCourseDetailsFromServer();
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '놀면서 살자',
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    post[index].memberName,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ratio.height * 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: ratio.width * 10,
                              ),
                              Text(
                                post[index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: ratio.width * 10,
                              ),
                              Text(post[index].content,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.chat_bubble)),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        postlikes[index] = !postlikes[index];
                                      });
                                    },
                                    icon: postlikes[index]
                                        ? Icon(Icons.thumb_up,
                                            color: Colors.black)
                                        : Icon(Icons.thumb_up_off_alt),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        print(showComment);
                                        showComment[index] =
                                            !showComment[index];
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text('댓글 보기'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ratio.width * 15,
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          showComment[index]
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: comments.length,
                                  itemBuilder: ((context, index2) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Text(comments[index2].emoji),
                                              Text(
                                                '\u{1f61D}',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              SizedBox(
                                                width: ratio.width * 10,
                                              ),
                                              Text(
                                                comments[index2].nickname,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: ratio.height * 10,
                                          ),
                                          Text(
                                            comments[index2].comment,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: ratio.height * 30,
                                          ),
                                        ],
                                      ),
                                    );
                                  }))
                              : SizedBox(
                                  height: ratio.height * 20,
                                ),
                        ],
                      ),
                    ),
                  );
                }));
  }
}
