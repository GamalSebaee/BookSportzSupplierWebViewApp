class BaseModel<T> {
  T? data;
  bool status;
  dynamic errorMsg;

  BaseModel({this.status = false, this.data, this.errorMsg});
}
