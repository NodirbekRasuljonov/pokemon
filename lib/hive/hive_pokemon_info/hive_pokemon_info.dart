import 'package:hive/hive.dart';

part 'hive_pokemon_info.g.dart';
@HiveType(typeId: 3)
class HivePokemonInfo {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  String height;
  @HiveField(4)
  String weight;
  @HiveField(5)
  String category;
  HivePokemonInfo(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.height,
      required this.weight,
      required this.category});
}
