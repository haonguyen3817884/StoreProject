import "package:store_project/models/customerImage.dart";
import "package:store_project/models/category.dart";

mixin GPParserJson {
  static Map<Type, Function> _mapFactories<T>() {
    return <Type, Function>{
      T: (dynamic x) => _mapFactoryValue<T>(x),
    };
  }

  static dynamic _mapFactoryValue<T>(dynamic x) {
    // parse all items here
    switch (T) {
      case CustomerImage:
        return CustomerImage.fromJson(x);
      case Category:
        return Category.fromJson(x);
      case String:
        return x as String;

      default:
        throw Exception("ApiResponseExtension _mapFactoryValue error!!!");
    }
  }

  static T parseJson<T>(dynamic x) {
    Map<Type, Function> _factories = _mapFactories<T>();
    return _factories[T]?.call(x);
  }
}
