class ProductDetailModel {
  int? prodId;
  int? catId;
  int? brandId;
  int? typeId;
  int? orderId;
  int? qty;
  String? name;
  String? image;
  String? detail;
  String? unitName;
  String? unitValue;
  String? nutritionWeight;
  double? price;
  double? itemPrice;
  double? totalPrice;
  String? createdDate;
  String? modifyDate;
  String? catName;
  String? brandName;
  String? typeName;
  double? offerPrice;
  String? startDate;
  String? endDate;
  int? isOfferActive;
  bool? isFav;
  


  ProductDetailModel(
      {this.prodId,
      this.catId,
      this.brandId,
      this.typeId,
      this.name,
      this.detail,
      this.unitName,
      this.unitValue,
      this.nutritionWeight,
      this.price,
      this.createdDate,
      this.modifyDate,
      this.catName,
      this.brandName,
      this.typeName,
      this.offerPrice,
      this.startDate,
      this.endDate,
      this.isOfferActive,
      this.isFav});

  ProductDetailModel.fromJson(Map json) {
    prodId = json['prod_id'];
    orderId = json['order_id'];
    qty = json['qty'];
    catId = json['cat_id'];
    brandId = json['brand_id'];
    typeId = json['type_id'];
    name = json['name'];
    image = json['image'];
    detail = json['detail'];
    unitName = json['unit_name'];
    unitValue = json['unit_value'];
    nutritionWeight = json['nutrition_weight'];
    price = (json['price'] != null) ? (json['price'] is int ? (json['price'] as int).toDouble() : json['price'] as double) : null;
    itemPrice = (json['item_price'] != null) ? (json['item_price'] is int ? (json['item_price'] as int).toDouble() : json['item_price'] as double) : null;
    totalPrice = (json['total_price'] != null) ? (json['total_price'] is int ? (json['total_price'] as int).toDouble() : json['total_price'] as double) : null;
    createdDate = json['created_date'];
    modifyDate = json['modify_date'];
    catName = json['cat_name'];
    brandName = json['brand_name'];
    typeName = json['type_name'];
    offerPrice = (json['offer_price'] != null) ? (json['offer_price'] is int ? (json['offer_price'] as int).toDouble() : json['offer_price'] as double) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    isOfferActive = json['is_offer_active'];
    isFav = (json['is_fav'] as int? ?? 0) == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['prod_id'] = prodId;
    data['cat_id'] = catId;
    data['brand_id'] = brandId;
    data['type_id'] = typeId;
    data['order_id'] = orderId;
    data['qty'] = qty;
    data['name'] = name;
    data['image'] = image;
    data['detail'] = detail;
    data['unit_name'] = unitName;
    data['unit_value'] = unitValue;
    data['nutrition_weight'] = nutritionWeight;
    data['price'] = price;
    data['item_price'] = itemPrice;
    data['total_price'] = totalPrice;
    data['created_date'] = createdDate;
    data['modify_date'] = modifyDate;
    data['cat_name'] = catName;
    data['brand_name'] = brandName;
    data['type_name'] = typeName;
    data['offer_price'] = offerPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['is_offer_active'] = isOfferActive;
    data['is_fav'] = isFav;
    return data;
  }
}
