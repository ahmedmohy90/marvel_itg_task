// To parse this JSON data, do
//
//     final charactersEventsModel = charactersEventsModelFromJson(jsonString);

import 'dart:convert';

CharactersEventsModel charactersEventsModelFromJson(String str) => CharactersEventsModel.fromJson(json.decode(str));

String charactersEventsModelToJson(CharactersEventsModel data) => json.encode(data.toJson());

class CharactersEventsModel {
    CharactersEventsModel({
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

    factory CharactersEventsModel.fromJson(Map<String, dynamic> json) => CharactersEventsModel(
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
    List<EventsModel> results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<EventsModel>.from(json["results"].map((x) => EventsModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class EventsModel {
    EventsModel({
       required this.id,
       required this.title,
       required this.description,
       required this.resourceUri,
       required this.urls,
       required this.modified,
       required this.start,
       required this.end,
       required this.thumbnail,
       required this.creators,
       required this.characters,
       required this.stories,
       required this.comics,
       required this.series,
       required this.next,
       required this.previous,
    });

    int id;
    String title;
    String description;
    String resourceUri;
    List<Url> urls;
    String modified;
    DateTime start;
    DateTime end;
    Thumbnail thumbnail;
    Creators creators;
    Characters characters;
    Stories stories;
    Characters comics;
    Characters series;
    Next next;
    Next previous;

    factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        modified: json["modified"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        stories: Stories.fromJson(json["stories"]),
        comics: Characters.fromJson(json["comics"]),
        series: Characters.fromJson(json["series"]),
        next: Next.fromJson(json["next"]),
        previous: Next.fromJson(json["previous"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "modified": modified,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "thumbnail": thumbnail.toJson(),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "comics": comics.toJson(),
        "series": series.toJson(),
        "next": next.toJson(),
        "previous": previous.toJson(),
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
    List<Next> items;
    int returned;

    factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Next>.from(json["items"].map((x) => Next.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class Next {
    Next({
       required this.resourceUri,
       required this.name,
    });

    String resourceUri;
    String name;

    factory Next.fromJson(Map<String, dynamic> json) => Next(
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
    List<CreatorsItem> items;
    int returned;

    factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class CreatorsItem {
    CreatorsItem({
       required this.resourceUri,
       required this.name,
       required this.role,
    });

    String resourceUri;
    String name;
    String role;

    factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
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

class Stories {
    Stories({
      required  this.available,
      required  this.collectionUri,
      required  this.items,
      required  this.returned,
    });

    int available;
    String collectionUri;
    List<StoriesItem> items;
    int returned;

    factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class StoriesItem {
    StoriesItem({
       required this.resourceUri,
       required this.name,
       required this.type,
    });

    String resourceUri;
    String name;
    String type;

    factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": type,
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
        path: json["path"],
        extension: json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
    };
}

class Url {
    Url({
      required  this.type,
      required  this.url,
    });

    String type;
    String url;

    factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
    };
}

