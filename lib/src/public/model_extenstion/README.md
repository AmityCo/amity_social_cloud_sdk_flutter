# Model Extension
### Domain Layer Model Extension for Public Layer, this provide direct access to repo method from the model object. Like we can directly call delete methid on Amity post without calling it from AmityPostRepo (public layer). These extension provide same methods for other public model as well (Domain layer model)


```dart
 amityPost.delete();
```