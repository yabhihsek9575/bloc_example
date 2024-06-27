
class PopularProductModel {

  int? productId,productBunchId,productCategoryId,productSubCategoryId,productVariantType1Id,productVariantType2Id;
  String? productName,productBrandName;
  String? productCategoryName;
  String? productSubCategoryName;
  String? productVariantName1,productVariantColorCode1,productVariantColorCode2;
  String? productVariantName2;
  int? productPrice;
  int?  productDiscountedPrice;
  List<Images>? productImages;
  List<dynamic>? productVariant1;
  List<dynamic>? productVariant1ColorCode1;
  List<dynamic>? productVariant2;
  List<dynamic>? productVariant2ColorCode2;
  List<dynamic>? productsId;
  List<dynamic>? price;
  List<dynamic>? discountedPrice;
  List<dynamic>? videoLink;
  List<dynamic>? taxAmt;
  List<dynamic>? minPurchaseQty;
  List<dynamic>? maxPurchaseQty;
  List<dynamic>? productDesc;
  List<dynamic>? isCashOnDelivery;
  List<dynamic>? isProductReturn;
  List<dynamic>? productReturnDays;
  List<dynamic>? productReturnDesc;
  List<dynamic>? isActive;
  List<dynamic>? offeredPrice;
  List<dynamic>? totalCurrentStock;
  List<dynamic>? productVariantType1Name;
  List<dynamic>? productVariantType2Name;

// productId: json["productId"] as int,
  PopularProductModel({
    required  this.productId,
    required  this.productBunchId,
      this.productCategoryId,
      this.productSubCategoryId,
      this.productVariantType1Id,
      this.productVariantType2Id,
      this.productVariantColorCode2,
      this.productName,
      this.productBrandName,
      this.productCategoryName,
      this.productSubCategoryName,
      this.productVariantName1,
      this.productVariantColorCode1,
      this.productVariantName2,
      this.productPrice,
      this.productDiscountedPrice,
      this.productImages,
      this.productVariant1,
      this.productVariant1ColorCode1,
      this.productVariant2,
      this.productVariant2ColorCode2,
      this.productsId,
      this.price,
      this.discountedPrice,
      this.videoLink,
      this.taxAmt,
      this.minPurchaseQty,
      this.maxPurchaseQty,
      this.productDesc,
      this.isCashOnDelivery,
      this.isProductReturn,
      this.productReturnDays,
      this.productReturnDesc,
      this.isActive,
      this.offeredPrice,
      this.totalCurrentStock,
    this.productVariantType1Name,
    this.productVariantType2Name});

  factory PopularProductModel.fromJson(dynamic json) {
    // print("list"+List<Images>.from(json["productImages"].map((x) => Images.fromJson(x)))[0].toString());
    return PopularProductModel(
        productId: json["productId"] as int,
       productBunchId: json['productBunchId'] as int,
        productName:  json['productName'].toString(),
         productCategoryId: json['productCategoryId'] as int,
        productCategoryName: json['productCategoryName'].toString(),
        productSubCategoryId: json['productSubCategoryId'] as int,
        productSubCategoryName: json['productSubCategoryName'].toString(),
        productVariantType1Id: json['productVariantType1Id'] as int,
        productVariantName1: json['productVariantName1'].toString(),
        productVariantColorCode1: json['productVariantColorCode1'].toString(),
        productVariantType2Id: json['productVariantType2Id'] as int,
        productVariantName2: json['productVariantName2'].toString(),
        productVariantColorCode2: json['productVariantColorCode2'].toString(),
    productPrice: json['productPrice']as int,
    productDiscountedPrice: json['productDiscountedPrice']as int,
    productBrandName: json['productBrandName'].toString(),
        productImages: List<Images>.from(
            json["productImages"].map((x) => Images.fromJson(x))),
    productVariant1: json['productVariant1'] as List,
    productVariant1ColorCode1:
        json['productVariant1ColorCode1'],
    productVariant2: json['productVariant2'],
    productVariant2ColorCode2: json['productVariant2ColorCode2'],
    productsId: json['productsId'],
    price: json['price'],
    discountedPrice: json['discountedPrice'],
    videoLink: json['videoLink'],
    taxAmt: json['taxAmt'],
    minPurchaseQty: json['minPurchaseQty'],
    maxPurchaseQty: json['maxPurchaseQty'],
        productDesc: json['productDesc'],
    isCashOnDelivery: json['isCashOnDelivery'],
    isProductReturn: json['isProductReturn'],
    productReturnDays:json['productReturnDays'],
        productReturnDesc: json['productReturnDesc'],
    isActive: json['isActive'],
    offeredPrice: json['offeredPrice'],
    totalCurrentStock: json['totalCurrentStock'],
        productVariantType1Name: json['productVariantType1Name'],
        productVariantType2Name: json['productVariantType2Name'],
    );
  }

  // @override
  // String toString() {
  //   return '{ ${this.productId},${this.productBunchId}, ${this.productName},${this.productCategoryId}, ${this.productCategoryName}, ${this.productSubCategoryName}, ${this.productDesc}, ${this.productPrice},${this.productVariant1},${this.productDiscountedPrice},${this.productVariant1ColorCode1}';
  // }

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
    "productSubCategoryId": productSubCategoryId,
    "productSubCategoryName": productSubCategoryName,
    "productBrandName" : productBrandName,
    "productVariantType1Id": productVariantType1Id,
    "productVariantType2Id": productVariantType2Id,
    "productVariantColorCode2":productVariantColorCode2,
    "productVariantName1": productVariantName1,
    "productVariantColorCode1":productVariantColorCode1,
    "productVariantName2": productVariantName2,
    "productVariant2": productVariant2,
    "productVariant2ColorCode2": productVariant2ColorCode2,
    "productsId": productsId,
    "price": price,
    "discountedPrice": discountedPrice,
    "videoLink": videoLink,
    "taxAmt": taxAmt,
    "minPurchaseQty": minPurchaseQty,
    "maxPurchaseQty": maxPurchaseQty,
    "productDesc": productDesc,
    "isCashOnDelivery": isCashOnDelivery,
    "isProductReturn": isProductReturn,
    "productReturnDays": productReturnDays,
    "productReturnDesc": productReturnDesc,
    "isActive": isActive,
    "offeredPrice":offeredPrice,
    "totalCurrentStock": totalCurrentStock,
    "productDesc": productDesc,
    "productPrice": productPrice,
    "productImages": List<Images>.from(productImages!.map((x) => x.toJson())),
    "productVariant1": productVariant1,
    "productDiscountedPrice": productDiscountedPrice,
    "productVariant1ColorCode1" : productVariant1ColorCode1,
    "productVariantType1Name": productVariantType1Name,
    "productVariantType2Name": productVariantType2Name,
  };
}

class Images {
  Images({
    this.path,
  });

  String? path;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
  };
}