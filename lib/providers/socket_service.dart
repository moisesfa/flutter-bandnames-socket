import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Enumeración para manejar los estados del server
enum ServerStatus { Online, Offline, Connecting }

// Para notificar cambios
class SocketService with ChangeNotifier {
  IO.Socket _socket;
  ServerStatus _serverStatus = ServerStatus.Connecting;

  //getters
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  // Constructor
  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    // IO.Socket socket = IO.io('http://192.168.1.123:3000/', {
    //this._socket = IO.io('https://192.168.1.121:1880/endpoint/io', {
    this._socket = IO.io('http://localhost:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    this._socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // Prueba para escuchar los mensajes
    // socket.on('prueba-mensaje', (payload) {
    //   print('Prueba Mensaje: $payload');
    //   print('nombre: ' + payload['nombre']);
    //   print('mensaje: ' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2')
    //       ? 'mensaje2: ' + payload['mensaje2']
    //       : 'No hay mensaje2');
    //   //print('Prueba Mensaje: $payload');
    // });
  }
}
