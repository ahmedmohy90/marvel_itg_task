// To parse this JSON data, do
//
//     final charactersStoriesModel = charactersStoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:marvel_task/presentation/string_manager.dart';

CharactersStoriesModel charactersStoriesModelFromJson(String str) => CharactersStoriesModel.fromJson(json.decode(str));

String charactersStoriesModelToJson(CharactersStoriesModel data) => json.encode(data.toJson());

class CharactersStoriesModel {
    CharactersStoriesModel({
       required this.code,
       required this.status,
       required this.copyright,
       required this.attributionText,
       required this.attributionHtml,
       required this.etag,
       required this.data,
    });

    int code;
    String status;
    String copyright;
    String attributionText;
    String attributionHtml;
    String etag;
    Data data;

    factory CharactersStoriesModel.fromJson(Map<String, dynamic> json) => CharactersStoriesModel(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
    };
}

class Data {
    Data({
       required this.offset,
       required this.limit,
       required this.total,
       required this.count,
       required this.results,
    });

    int offset;
    int limit;
    int total;
    int count;
    List<StoresModel> results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<StoresModel>.from(json["results"].map((x) => StoresModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class StoresModel {
    StoresModel({
       required this.id,
       required this.title,
       required this.description,
       required this.resourceUri,
       required this.type,
       required this.modified,
       required this.thumbnail,
       required this.creators,
       required this.characters,
       required this.series,
       required this.comics,
       required this.events,
       required this.originalIssue,
    });

    int id;
    String title;
    String description;
    String resourceUri;
    String type;
    String modified;
    Thumbnail thumbnail;
    Creators creators;
    Characters characters;
    Characters series;
    Characters comics;
    Characters events;
    OriginalIssue originalIssue;

    factory StoresModel.fromJson(Map<String, dynamic> json) => StoresModel(
        id: json["id"],
        title: json["title"],
        description: json["description"] ?? AppStrings.charNoDescription,
        resourceUri: json["resourceURI"],
        type: json["type"],
        modified: json["modified"],
        thumbnail:json["thumbnail"] == null ?Thumbnail(path: "", extension: "extension") : Thumbnail.fromJson(json["thumbnail"]),
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        series: Characters.fromJson(json["series"]),
        comics: Characters.fromJson(json["comics"]),
        events: Characters.fromJson(json["events"]),
        originalIssue: OriginalIssue.fromJson(json["originalIssue"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "resourceURI": resourceUri,
        "type": type,
        "modified": modified,
        "thumbnail": thumbnail,
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "series": series.toJson(),
        "comics": comics.toJson(),
        "events": events.toJson(),
        "originalIssue": originalIssue.toJson(),
    };
}
class Thumbnail {
    Thumbnail({
       required this.path,
       required this.extension,
    });

    String path;
    String extension;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"] ?? "",
        extension: json["extension"]??"",
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
    };
}
class Characters {
    Characters({
       required this.available,
       required this.collectionUri,
       required this.items,
       required this.returned,
    });

    int available;
    String collectionUri;
    List<OriginalIssue> items;
    int returned;

    factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<OriginalIssue>.from(json["items"].map((x) => OriginalIssue.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class OriginalIssue {
    OriginalIssue({
       required this.resourceUri,
       required this.name,
    });

    String resourceUri;
    String name;

    factory OriginalIssue.fromJson(Map<String, dynamic> json) => OriginalIssue(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
    };
}

class Creators {
    Creators({
       required this.available,
       required this.collectionUri,
       required this.items,
       required this.returned,
    });

    int available;
    String collectionUri;
    List<Item> items;
    int returned;

    factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class Item {
    Item({
       required this.resourceUri,
       required this.name,
       required this.role,
    });

    String resourceUri;
    String name;
    String role;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": role,
    };
}


