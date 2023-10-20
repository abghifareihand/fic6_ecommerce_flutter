import 'dart:convert';

ListProductResponseModel listProductResponseModelFromJson(String str) =>
    ListProductResponseModel.fromJson(json.decode(str));

String listProductResponseModelToJson(ListProductResponseModel data) =>
    json.encode(data.toJson());

class ListProductResponseModel {
  final List<Product> data;
  final Meta meta;

  ListProductResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ListProductResponseModel(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Product {
  final int id;
  final Attributes attributes;

  Product({
    required this.id,
    required this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  final String name;
  final String description;
  final int quantity;
  final int price;
  final bool inStock;
  final String image;
  final String distributor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final double rating;

  Attributes({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.inStock,
    required this.image,
    required this.distributor,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.rating,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        inStock: json["inStock"],
        image: json["image"],
        distributor: json["distributor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        rating: json['rating'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "quantity": quantity,
        "price": price,
        "inStock": inStock,
        "image": image,
        "distributor": distributor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "rating": rating,
      };
}

class Meta {
  final Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
