class Model{
  final String name;
  final String ki;
  final String maxKi;
  final String image;
  final String description;
  final String affiliation;

  Model({required this.image, required this.name, required this.ki, required this.maxKi ,required this.description, required this.affiliation});

  factory Model.fromJson(Map<String, dynamic> json){
    return Model(name: json['name'], image: json['image'], ki: json['ki'], maxKi: json['maxKi'], description: json['description'], affiliation: json['affiliation']);
  }

  Map<String, dynamic> toJson(){
    return {'name' : name, 'ki': ki, 'maxKi' : maxKi, 'image' : image, 'description' : description, 'affiliation' : affiliation};
  }
}