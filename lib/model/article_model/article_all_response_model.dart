class ArticleAllResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataArticleAllResponse>? data;

  ArticleAllResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  ArticleAllResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataArticleAllResponse>[];
      json['data'].forEach((v) {
        data!.add(new DataArticleAllResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataArticleAllResponse {
  int? id;
  String? title;
  String? imageFilename;
  String? updatedAt;

  DataArticleAllResponse(
      {this.id, this.title, this.imageFilename, this.updatedAt});

  DataArticleAllResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFilename =
        json['image_filename'] != null ? json['image_filename'] : '';
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.imageFilename != null) {
      data['image_filename'] = this.imageFilename;
    }
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
