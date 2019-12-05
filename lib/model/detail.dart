class GoodsDetailModel {
  AdvertesPicture advertesPicture;
  GoodInfo goodInfo;
  List<GoodComments> goodComments;

  GoodsDetailModel({this.advertesPicture, this.goodInfo, this.goodComments});

  GoodsDetailModel.fromJson(Map<String, dynamic> json) {
    advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;
    goodInfo = json['goodInfo'] != null
        ? new GoodInfo.fromJson(json['goodInfo'])
        : null;
    if (json['goodComments'] != null) {
      goodComments = new List<GoodComments>();
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
    if (this.goodComments != null) {
      data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvertesPicture {
  String pictureAddress;
  String toPlace;

  AdvertesPicture({this.pictureAddress, this.toPlace});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pictureAddress = json['PICTURE_ADDRESS'];
    toPlace = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pictureAddress;
    data['TO_PLACE'] = this.toPlace;
    return data;
  }
}

class GoodInfo {
  String image1;
  String image4;
  String goodsName;
  String goodsDetail;
  String goodsSerialNumber;
  double presentPrice;
  int state;
  String shopId;
  String goodsId;
  double oriPrice;
  String image5;
  int amount;
  String image2;
  String comPic;
  String image3;
  String isOnline;

  GoodInfo(
      {this.image1,
      this.image4,
      this.goodsName,
      this.goodsDetail,
      this.goodsSerialNumber,
      this.presentPrice,
      this.state,
      this.shopId,
      this.goodsId,
      this.oriPrice,
      this.image5,
      this.amount,
      this.image2,
      this.comPic,
      this.image3,
      this.isOnline});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    image1 = json['image1'];
    image4 = json['image4'];
    goodsName = json['goodsName'];
    goodsDetail = json['goodsDetail'];
    goodsSerialNumber = json['goodsSerialNumber'];
    presentPrice = json['presentPrice'];
    state = json['state'];
    shopId = json['shopId'];
    goodsId = json['goodsId'];
    oriPrice = json['oriPrice'];
    image5 = json['image5'];
    amount = json['amount'];
    image2 = json['image2'];
    comPic = json['comPic'];
    image3 = json['image3'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image1'] = this.image1;
    data['image4'] = this.image4;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['presentPrice'] = this.presentPrice;
    data['state'] = this.state;
    data['shopId'] = this.shopId;
    data['goodsId'] = this.goodsId;
    data['oriPrice'] = this.oriPrice;
    data['image5'] = this.image5;
    data['amount'] = this.amount;
    data['image2'] = this.image2;
    data['comPic'] = this.comPic;
    data['image3'] = this.image3;
    data['isOnline'] = this.isOnline;
    return data;
  }
}

class GoodComments {
  int discussTime;
  String userName;
  String comments;
  int score;

  GoodComments({this.discussTime, this.userName, this.comments, this.score});

  GoodComments.fromJson(Map<String, dynamic> json) {
    discussTime = json['discussTime'];
    userName = json['userName'];
    comments = json['comments'];
    score = json['SCORE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discussTime'] = this.discussTime;
    data['userName'] = this.userName;
    data['comments'] = this.comments;
    data['SCORE'] = this.score;
    return data;
  }
}
