class DataModel {
  String? id,
      title,
      thumbnailUrl,
      duration,
      uploadTime,
      views,
      author,
      videoUrl,
      description,
      subscriber;
  bool? isLive;

  DataModel(
      {this.id,
      this.title,
      this.thumbnailUrl,
      this.duration,
      this.uploadTime,
      this.views,
      this.author,
      this.videoUrl,
      this.description,
      this.subscriber,
      this.isLive});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      thumbnailUrl: json["thumbnailUrl"] ?? '',
      duration: json["duration"] ?? '',
      uploadTime: json["uploadTime"] ?? '',
      views: json["views"] ?? '',
      author: json["author"] ?? '',
      videoUrl: json["videoUrl"] ?? '',
      description: json["description"] ?? '',
      subscriber: json["subscriber"] ?? '',
      isLive: json["isLive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnailUrl": thumbnailUrl,
      "duration": duration,
      "uploadTime": uploadTime,
      "views": views,
      "author": author,
      "videoUrl": videoUrl,
      "description": description,
      "subscriber": subscriber,
      "isLive": isLive,
    };
  }

//
}
