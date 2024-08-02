String get MESSAGE_SUCCESS => 'success';
String get MESSAGE_UNSUCCESS => 'unsuccess';
String get MESSAGE_DONT_AVAILIBLE => 'dont availible';

enum RepositoryStat {
  saved,
  sended,
  error,
  added,
  deleted,
  resp_success,
  resp_unsucces,
  resp_packageDontAvailible,
  resp_unknown,
}

RepositoryStat getStat(String message) {
  if (message == MESSAGE_SUCCESS) {
    return RepositoryStat.resp_success;
  } else if (message == MESSAGE_UNSUCCESS) {
    return RepositoryStat.resp_unsucces;
  } else if (message == MESSAGE_DONT_AVAILIBLE) {
    return RepositoryStat.resp_packageDontAvailible;
  } else {
    return RepositoryStat.resp_unknown;
  }
}
