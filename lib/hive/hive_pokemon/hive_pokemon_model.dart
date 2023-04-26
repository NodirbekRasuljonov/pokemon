import 'package:hive/hive.dart';

part 'hive_pokemon_model.g.dart';

@HiveType(typeId: 1)
class HivePokemonModel {
  @HiveField(0)
  int? count;
  @HiveField(1)
  String? next;
  @HiveField(2)
  String? previous;
  @HiveField(3)
  List<Results>? results;

  HivePokemonModel({this.count, this.next, this.previous, this.results});

  HivePokemonModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}
@HiveType(typeId: 2)
class Results {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;

  Results({this.name, this.url});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
