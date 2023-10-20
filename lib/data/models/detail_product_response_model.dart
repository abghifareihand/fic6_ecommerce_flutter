import 'dart:convert';

DetailProductResponseModel detailProductResponseModelFromJson(String str) => DetailProductResponseModel.fromJson(json.decode(str));

String detailProductResponseModelToJson(DetailProductResponseModel data) => json.encode(data.toJson());

class DetailProductResponseModel {
    final Product data;
    final Meta meta;

    DetailProductResponseModel({
        required this.data,
        required this.meta,
    });

    factory DetailProductResponseModel.fromJson(Map<String, dynamic> json) => DetailProductResponseModel(
        data: Product.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
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
    };
}

class Meta {
    Meta();

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toJson() => {
    };
}
