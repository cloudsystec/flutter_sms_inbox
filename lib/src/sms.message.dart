part of flutter_sms_inbox;

/// Message
class SmsMessage implements Comparable<SmsMessage> {
  int? _id;
  int? _threadId;
  String? _address;
  String? _body;
  bool? _read;
  DateTime? _date;
  DateTime? _dateSent;
  SmsMessageKind? _kind;
  SmsMessageState _state = SmsMessageState.None;
  StreamController<SmsMessageState> _stateStreamController =
      StreamController<SmsMessageState>();

  SmsMessage(
    this._address,
    this._body, {
    int? id,
    int? threadId,
    bool? read,
    DateTime? date,
    DateTime? dateSent,
    SmsMessageKind? kind,
  }) {
    this._id = id;
    this._threadId = threadId;
    this._read = read;
    this._date = date;
    this._dateSent = dateSent;
    this._kind = kind;
  }

  SmsMessage.fromJson(Map data) {
    this._address = data["address"];
    this._body = data["body"];
    if (data.containsKey("_id")) {
      this._id = data["_id"];
    }
    if (data.containsKey("thread_id")) {
      this._threadId = data["thread_id"];
    }
    if (data.containsKey("read")) {
      this._read = (data["read"].toInt() == 1);
    }
    if (data.containsKey("kind")) {
      this._kind = data["kind"];
    }
    if (data.containsKey("date")) {
      this._date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    }
    if (data.containsKey("date_sent")) {
      this._dateSent = DateTime.fromMillisecondsSinceEpoch(data["date_sent"]);
    }
  }

  /// Convert SMS to map
  Map get toMap {
    Map res = {};
    if (_address != null) {
      res["address"] = _address;
    }
    if (_body != null) {
      res["body"] = _body;
    }
    if (_id != null) {
      res["_id"] = _id;
    }
    if (_threadId != null) {
      res["thread_id"] = _threadId;
    }
    if (_read != null) {
      res["read"] = _read;
    }
    if (_date != null) {
      res["date"] = _date!.millisecondsSinceEpoch;
    }
    if (_dateSent != null) {
      res["dateSent"] = _dateSent!.millisecondsSinceEpoch;
    }
    return res;
  }

  /// Convert SMS to map
  Map<String, dynamic> toJson() => {
        "address": _address,
        "body": _body,
        "_id": _id,
        "thread_id": _threadId,
        "read": _read,
        "date": _date!.toString(),
        "dateSent": _dateSent!.toString()
      };

  /// Getters
  int? get id => this._id;
  int? get threadId => this._threadId;
  String? get sender => this._address;
  String? get address => this._address;
  String? get body => this._body;
  bool? get isRead => this._read;
  DateTime? get date => this._date;
  DateTime? get dateSent => this._dateSent;
  SmsMessageKind? get kind => this._kind;
  SmsMessageState get state => this._state;
  Stream<SmsMessageState> get onStateChanged => _stateStreamController.stream;

  /// Setters
  set kind(SmsMessageKind? kind) => this._kind = kind;
  set date(DateTime? date) => this._date = date;
  set state(SmsMessageState state) {
    if (this._state != state) {
      this._state = state;
      _stateStreamController.add(state);
    }
  }

  @override
  int compareTo(SmsMessage other) {
    return other._id! - this._id!;
  }
}
