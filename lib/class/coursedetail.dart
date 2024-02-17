class CourseDetail {
  final int courseId;
  final int memberId;
  final String name;
  final String content;
  final List<PostCourseDetailResponseDto> postCourseDetailResponseDtoList;
  final int like;

  CourseDetail({
    required this.courseId,
    required this.memberId,
    required this.name,
    required this.content,
    required this.postCourseDetailResponseDtoList,
    required this.like,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    List<PostCourseDetailResponseDto> postCourseDetailResponseDtoList = [];
    if (json['postCourseResponseDtoList'] != null) {
      postCourseDetailResponseDtoList = (json['postCourseResponseDtoList'] as List)
          .map((item) => PostCourseDetailResponseDto.fromJson(item))
          .toList();
    }
    return CourseDetail(
      courseId: json['courseId'] ?? 0,
      memberId: json['memberId'] ?? 0,
      name: json['name'] ?? '',
      content: json['content'] ?? '',
      postCourseDetailResponseDtoList: postCourseDetailResponseDtoList,
      like: json['like'] ?? 0,
    );
  }
}

class PostCourseDetailResponseDto {
  final int postId;
  final String name;
  final String content;
  final String memberName;

  PostCourseDetailResponseDto({
    required this.postId,
    required this.name,
    required this.content,
    required this.memberName,
  });

  factory PostCourseDetailResponseDto.fromJson(Map<String, dynamic> json) {
    return PostCourseDetailResponseDto(
      postId: json['postId'] ?? 0,
      name: json['name'] ?? '',
      content: json['content'] ?? '',
      memberName: json['memberName'] ?? '',
    );
  }
}
