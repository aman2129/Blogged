import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class BlogDataModel {
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final String userId;
  @HiveField(4)
  final String id;

  BlogDataModel({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.userId,
    required this.id,
  });
}
