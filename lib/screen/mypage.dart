import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:wagle_front/class/course.dart';
import 'package:wagle_front/class/user.dart';
import 'package:wagle_front/common/go_router/go_router.dart';
import 'package:wagle_front/main.dart';
import 'package:wagle_front/screen/courseinfo.dart';
import 'package:http/http.dart' as http;

// 서버 URL
final String getuser =
    'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com/v1/user';
final String getCourse =
    'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com/v1/course/all';

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse(getuser));
  if (response.statusCode == 200) {
    return User.fromjson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class MyPage extends StatefulWidget {
  MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late User user = User(1, 'asdf_@', 'ddf', '1234', '\u{1f602}');
  List<Course> hotCourse = [];
  List<Course> myCourse = [];
  final GlobalKey<FormState> gkey = GlobalKey<FormState>();
  late TextEditingController nameController;

  Future<void> fetchCourses() async {
    final response = await http.get(Uri.parse(getCourse));
    if (response.statusCode == 200) {
      // 요청이 성공한 경우, JSON 데이터 파싱하여 Course 객체로 변환
      List<Course> courses = [];
      List<dynamic> jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        courses.add(Course.fromJson(jsonObj));
      }
      setState(() {
        hotCourse = courses;
        myCourse = courses;
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: user.name);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchCourses();
      setState(() {
        isloading = false;
      });
    });
  }

  List<PopupMenuItem> items = [
    PopupMenuItem(
      child: Text(
        "\u{1f601}",
        style: TextStyle(fontSize: 30),
      ),
      value: '\u{1f601}',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f60A}",
        style: TextStyle(fontSize: 30),
      ),
      value: '\u{1f60A}',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f60D}",
        style: TextStyle(fontSize: 30),
      ),
      value: '\u{1f60D}',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f61A}",
        style: TextStyle(fontSize: 30),
      ),
      value: '\u{1f61A}',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f61D}",
        style: TextStyle(fontSize: 30),
      ),
      value: '\u{1f61D}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showPopupMenu(context);
                                },
                                child: Text(
                                  user.emoji,
                                  style: TextStyle(fontSize: 60),
                                ),
                              ),
                              Container(
                                width: ratio.width * 90,
                                child: Form(
                                  key: gkey,
                                  child: Center(
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 22),
                                      textAlign: TextAlign.center,
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(fontSize: 10),
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: nameValidator,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ratio.height * 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (gkey.currentState!.validate()) {
                                    // submitData(nameController.text);
                                    setState(() {
                                      user.name = nameController.text;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("닉네임 변경"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '내가 추천한 최신 코스',
                            style: TextStyle(fontSize: 20),
                          ),
                          ...List.generate(
                            3,
                            (index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CourseInfo(
                                              id: myCourse[index].id.toString(),
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(6),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(myCourse[index].name),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "핫한 코스",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hotCourse.length,
                    itemBuilder: (context, index) {
                      return HotCourses(hotCourse: hotCourse[index]);
                    })
              ],
            ),
          );
  }

  void showPopupMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset offset = Offset.zero;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          offset.dx, offset.dy, overlay.size.width, overlay.size.height),
      items: items,
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        setState(() {
          user.emoji = value;
        });
        print('선택한 메뉴: $value');
      }
    });
  }

  String? nameValidator(String? val) {
    if (val!.isEmpty) {
      return '이름을 입력해주세요.';
    }
  }
}

class HotCourses extends StatefulWidget {
  final Course hotCourse;

  const HotCourses({
    required this.hotCourse,
    Key? key,
  }) : super(key: key);

  @override
  State<HotCourses> createState() => _HotCoursesState();
}

class _HotCoursesState extends State<HotCourses> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseInfo(
                        id: widget.hotCourse.id.toString(),
                      )));
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        widget.hotCourse.emoji,
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: ratio.width * 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.hotCourse.name,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          widget.hotCourse.content,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.visible,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (like == false) {
                                    ++widget.hotCourse.like;
                                    like = !like;
                                  } else {
                                    --widget.hotCourse.like;
                                    like = !like;
                                  }
                                });
                              },
                              icon: like
                                  ? Icon(Icons.thumb_up, color: Colors.black)
                                  : Icon(Icons.thumb_up_off_alt),
                            ),
                            Text(widget.hotCourse.like.toString()),
                            SizedBox(
                              width: ratio.width * 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
