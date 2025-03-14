class ZoomMeeting {
  final String meetingId;
  final String url;

  ZoomMeeting({required this.meetingId, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
      'url': url,
    };
  }
}