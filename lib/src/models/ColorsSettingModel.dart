class ColorSettingModel {
  String bradfordA;
  String bradfordB;
  String lowryA;
  String lowryB;

  ColorSettingModel({this.bradfordA, this.bradfordB, this.lowryA, this.lowryB});

  ColorSettingModel.fromJson(Map<String, dynamic> json) {
    bradfordA = json['bradfordA'];
    bradfordB = json['bradfordB'];
    lowryA = json['lowryA'];
    lowryB = json['lowryB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bradfordA'] = this.bradfordA;
    data['bradfordB'] = this.bradfordB;
    data['lowryA'] = this.lowryA;
    data['lowryB'] = this.lowryB;
    return data;
  }
}
