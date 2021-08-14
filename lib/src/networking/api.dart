import 'package:chopper/chopper.dart';

import 'package:flutter_testapp/src/networking/network_constants.dart';

part 'api.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class Api extends ChopperService {
  //Config Api

  static Api create(){
    final client = ChopperClient(
      baseUrl: NetworkConstants.SITE_URL,
      converter: JsonConverter(),
      services: [
        _$Api()
      ],
      interceptors: [
        HeadersInterceptor({
          "Content-Type": 'application/json',
          "Accept": "application/json;",
        })
      ]
    );
    return _$Api(client);
  }

  //Get Equipo
  @Get()
  Future<Response> getEquipoApi();

  //Add Equipo
  @Post()
  Future<Response> postEquipoApi(
    @Body() Map<String, dynamic> body);

  //Edit Equipo
  @Put(path: '{id}/')
  Future<Response> putEquipoApi(
      @Path('id') int id,
      @Body() Map<String, dynamic> body);

  //Delete Equipo
  @Delete(path: '{id}/')
  Future<Response> deleteEquipoApi(
      @Path('id') int id,);
}