import 'dart:convert';

// Model for https://events.api.secureserver.net/t/1/tl/event
class EventTrackingRequest {
  final String dh;
  final String ua;
  final String clientName;
  final String cv;
  final String vg;
  final String vtg;
  final String dp;
  final String traceId;
  final String cts;
  final String hitId;
  final String ht;
  final Map<String, dynamic> trfd;

  EventTrackingRequest({
    required this.dh,
    required this.ua,
    required this.clientName,
    required this.cv,
    required this.vg,
    required this.vtg,
    required this.dp,
    required this.traceId,
    required this.cts,
    required this.hitId,
    required this.ht,
    required this.trfd,
  });

  factory EventTrackingRequest.fromJson(Map<String, dynamic> json) {
    return EventTrackingRequest(
      dh: json['dh'],
      ua: json['ua'],
      clientName: json['client_name'],
      cv: json['cv'],
      vg: json['vg'],
      vtg: json['vtg'],
      dp: json['dp'],
      traceId: json['trace_id'],
      cts: json['cts'],
      hitId: json['hit_id'],
      ht: json['ht'],
      trfd: json['trfd'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dh': dh,
      'ua': ua,
      'client_name': clientName,
      'cv': cv,
      'vg': vg,
      'vtg': vtg,
      'dp': dp,
      'trace_id': traceId,
      'cts': cts,
      'hit_id': hitId,
      'ht': ht,
      'trfd': trfd,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTrackingRequest &&
          runtimeType == other.runtimeType &&
          dh == other.dh &&
          ua == other.ua &&
          clientName == other.clientName &&
          cv == other.cv &&
          vg == other.vg &&
          vtg == other.vtg &&
          dp == other.dp &&
          traceId == other.traceId &&
          cts == other.cts &&
          hitId == other.hitId &&
          ht == other.ht &&
          trfd == other.trfd;

  @override
  int get hashCode =>
      dh.hashCode ^
      ua.hashCode ^
      clientName.hashCode ^
      cv.hashCode ^
      vg.hashCode ^
      vtg.hashCode ^
      dp.hashCode ^
      traceId.hashCode ^
      cts.hashCode ^
      hitId.hashCode ^
      ht.hashCode ^
      trfd.hashCode;
}

// Model for https://csp.secureserver.net/eventbus/web
class EventBusRequest {
  final String clientId;

  EventBusRequest({required this.clientId});

  factory EventBusRequest.fromJson(Map<String, dynamic> json) {
    return EventBusRequest(clientId: json['clientid']);
  }

  Map<String, dynamic> toJson() {
    return {'clientid': clientId};
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventBusRequest &&
          runtimeType == other.runtimeType &&
          clientId == other.clientId;

  @override
  int get hashCode => clientId.hashCode;
}

// Model for https://www.youtube.com/youtubei/v1/player
class YouTubePlayerRequest {
  final bool? prettyPrint;

  YouTubePlayerRequest({this.prettyPrint});

  factory YouTubePlayerRequest.fromJson(Map<String, dynamic> json) {
    return YouTubePlayerRequest(prettyPrint: json['prettyPrint']);
  }

  Map<String, dynamic> toJson() {
    return {'prettyPrint': prettyPrint};
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YouTubePlayerRequest &&
          runtimeType == other.runtimeType &&
          prettyPrint == other.prettyPrint;

  @override
  int get hashCode => prettyPrint.hashCode;
}

// Model for https://www.youtube.com/api/stats/qoe
class YouTubeQoERequest {
  final String fmt;
  final String cpn;
  final String el;
  final String ns;
  final String docid;
  final String event;

  YouTubeQoERequest({
    required this.fmt,
    required this.cpn,
    required this.el,
    required this.ns,
    required this.docid,
    required this.event,
  });

  factory YouTubeQoERequest.fromJson(Map<String, dynamic> json) {
    return YouTubeQoERequest(
      fmt: json['fmt'],
      cpn: json['cpn'],
      el: json['el'],
      ns: json['ns'],
      docid: json['docid'],
      event: json['event'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fmt': fmt,
      'cpn': cpn,
      'el': el,
      'ns': ns,
      'docid': docid,
      'event': event,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YouTubeQoERequest &&
          runtimeType == other.runtimeType &&
          fmt == other.fmt &&
          cpn == other.cpn &&
          el == other.el &&
          ns == other.ns &&
          docid == other.docid &&
          event == other.event;

  @override
  int get hashCode =>
      fmt.hashCode ^
      cpn.hashCode ^
      el.hashCode ^
      ns.hashCode ^
      docid.hashCode ^
      event.hashCode;
}

// Model for https://www.youtube.com/api/stats/watchtime
class YouTubeWatchTimeRequest {
  final String ns;
  final String el;
  final String cpn;
  final String fmt;
  final String state;
  final String volume;

  YouTubeWatchTimeRequest({
    required this.ns,
    required this.el,
    required this.cpn,
    required this.fmt,
    required this.state,
    required this.volume,
  });

  factory YouTubeWatchTimeRequest.fromJson(Map<String, dynamic> json) {
    return YouTubeWatchTimeRequest(
      ns: json['ns'],
      el: json['el'],
      cpn: json['cpn'],
      fmt: json['fmt'],
      state: json['state'],
      volume: json['volume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ns': ns,
      'el': el,
      'cpn': cpn,
      'fmt': fmt,
      'state': state,
      'volume': volume,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YouTubeWatchTimeRequest &&
          runtimeType == other.runtimeType &&
          ns == other.ns &&
          el == other.el &&
          cpn == other.cpn &&
          fmt == other.fmt &&
          state == other.state &&
          volume == other.volume;

  @override
  int get hashCode =>
      ns.hashCode ^
      el.hashCode ^
      cpn.hashCode ^
      fmt.hashCode ^
      state.hashCode ^
      volume.hashCode;
}

// Model for https://www.youtube.com/youtubei/v1/log_event
class YouTubeLogEventRequest {
  final String alt;

  YouTubeLogEventRequest({required this.alt});

  factory YouTubeLogEventRequest.fromJson(Map<String, dynamic> json) {
    return YouTubeLogEventRequest(alt: json['alt']);
  }

  Map<String, dynamic> toJson() {
    return {'alt': alt};
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YouTubeLogEventRequest &&
          runtimeType == other.runtimeType &&
          alt == other.alt;

  @override
  int get hashCode => alt.hashCode;
}
