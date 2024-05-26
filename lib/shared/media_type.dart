class MediaType {
  List<String> imageType = ['.jpg', '.jpeg', '.JPG', '.png'];
  List<String> videoType = ['.mp4', '.mov', '.mkv', '.avi'];

  bool isImage(String content) {
    for (String type in imageType) {
      if (content.contains(type)) {
        return true;
      }
    }
    return false;
  }

  bool isVideo(String content) {
    for (String type in videoType) {
      if (content.contains(type)) {
        return true;
      }
    }
    return false;
  }
}
