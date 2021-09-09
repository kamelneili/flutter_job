class Offre {
  String id, title, content,categoryId,createdAt;

  int userId;

  Offre(this.id, 
  this.title,

  this.content,
  this.categoryId ,
  this.createdAt
      );

  factory Offre.fromJson(Map<String, dynamic> json) => Offre(
        json['id'].toString(),
        json['title'].toString(),
                json['content'].toString(),
                    json['category_id'].toString(),
                                        json['created_at'].toString(),


      );
}
