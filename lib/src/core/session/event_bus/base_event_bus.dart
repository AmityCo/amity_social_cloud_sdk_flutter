import 'dart:async';

class BaseEventBus<T>{

  Stream<T>? stream;
  T? currentEvent;
  StreamController<T> controller = StreamController<T>();

  Stream observe(){
    stream ??= controller.stream.asBroadcastStream();
    return stream!;
  }

  void publish(T event){
    currentEvent = event;
    controller.add(event);
  }

  T? getCurrentEvent()  {
		return currentEvent;
	}

}