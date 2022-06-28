class ArticleDetailResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  DataArticleDetailResponse? data;

  ArticleDetailResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  ArticleDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null
        ? new DataArticleDetailResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataArticleDetailResponse {
  String? title;
  String? content;
  String? author;
  int? id;
  String? imageFilename;
  String? createdAt;
  String? updatedAt;

  DataArticleDetailResponse(
      {this.title,
      this.content,
      this.author,
      this.id,
      this.imageFilename,
      this.createdAt,
      this.updatedAt});

  DataArticleDetailResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    author = json['author'];
    id = json['id'];
    imageFilename =
        json['image_filename'] != null ? json['image_filename'] : '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['author'] = this.author;
    data['id'] = this.id;
    if (this.imageFilename != null) {
      data['image_filename'] = this.imageFilename;
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
