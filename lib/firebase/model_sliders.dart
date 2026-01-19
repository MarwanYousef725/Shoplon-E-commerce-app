class Sliders {
  final String image;
  final String text1;
  final String text2;
  final String text3;
  Sliders({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
  });
  Map<String, dynamic> toJson() {
    return {"image": image, 'text1': text1, 'text2': text2, 'text3': text3};
  }

  factory Sliders.fromJson(json) => Sliders(
    image: json['image'],
    text1: json['text1'],
    text2: json['text2'],
    text3: json['text3'],
  );
}
