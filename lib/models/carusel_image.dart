class CaruselModel {
  String image;
  CaruselModel(this.image);
}

List<CaruselModel> carusels =
    caroseldata.map((e) => CaruselModel(e['image'])).toList();
var caroseldata = [
  {"image": "https://admin.ekottro.com/public/images/adminbanner1.png"},
  {"image": "https://admin.ekottro.com/public/images/adminbanner2.png"},
  {"image": "https://admin.ekottro.com/public/images/adminbanner3.png"},
  {"image": "https://admin.ekottro.com/public/images/adminbanner4.png"}
];
