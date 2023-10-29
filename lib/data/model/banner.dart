class BannerHome {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? categoryId;

  BannerHome(this.id, this.collectionId, this.thumbnail, this.categoryId);

  factory BannerHome.fromJson(Map<String, dynamic> jsonObject) {
    return BannerHome(
      jsonObject['id'],
      jsonObject['collectionId'],
      "http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}",
      jsonObject['categoryId'],
    );
  }
}
