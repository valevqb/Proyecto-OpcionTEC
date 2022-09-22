import 'package:flutter/material.dart';
import 'package:untitled/Servicios/modelos/servicioBus.dart';
import 'package:untitled/Servicios/servicios/datos_bus.dart';
import 'package:provider/provider.dart';

import '../../locators.dart';

class InformacionBus extends StatefulWidget {
  //final DataServicioBus servicioSeleccionado;
  //InformacionBus(this.servicioSeleccionado);

  @override
  _InformacionBusState createState() => _InformacionBusState();
}

class _InformacionBusState extends State<InformacionBus> {
  late String _destino;
  late String _origen;
  late int _index;
  late int _index2;

  List _destinos = [];
  DependenciaDestino(indice, lista){

  }

  @override
  void initState() {
    super.initState();
    _destino = "Destino";
    _origen = "Origen";
    _index = 0;
    _index2 = 0;
    locator<DatosBus>().fetchServicioBus();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<DatosBus>(context).isLoading;
    List<dynamic>? servicioBus = Provider.of<DatosBus>(context).servicioBus;
    //print("Origen");
    //print(servicioBus?[0].Origen);
    //print(servicioBus?[0].Destinos?.destinos?[0].Nombre.toString());

    return Scaffold(
        body: (isLoading)
            ? Container(

        )
            : Container(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            seleccionOrigen(context, servicioBus),
                            SizedBox(
                              child: Container(//Lista
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: informacionServicio(context, servicioBus),
                                      );
                                    }
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  );
                }
            )
        )
    );
  }

  Widget seleccionOrigen (BuildContext context, List<dynamic>? servicioBus) { //titulo de la pagina e imagen
    return Container( //La imagen donde dice servicios
      height: 286,
      width: (MediaQuery.of(context).size.width),
      padding: EdgeInsets.only(
          top: 7.76, left: 24.5
      ),
      decoration: BoxDecoration(
          color: Color(0xFF2B436D),
          image: DecorationImage(
            image: NetworkImage(''), //Aca va la imagen
          )
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 44.00),
            child: Text("Buses",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,),
          ),
          nombreDestino(context, servicioBus),
        ],
      )
    );
  }

  Widget nombreDestino (BuildContext context, List<dynamic>? servicioBus){
    List<dynamic> listaOrigenes = ["Origen"];
    List<List<dynamic>> listaDestino = [["Destino"]];

    servicioBus?.forEach((element) {
      listaOrigenes.add(element.Origen.toString());
    });

    servicioBus?.forEach((element) {
      List<dynamic> listas = [];
      element?.Destinos.destinos.forEach((elemento){
        listas.add(elemento.Nombre.toString());
      });
      listas.add("Destino".toString());
      listaDestino.add(listas);
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
          top: 34.7, bottom: 59.5, left: 24, right: 24),
      child: Align (
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 13, right: 74
            ),
            child: Column(
              children: [
                Container(
                  height: 56,
                  child: dropInformacionOrigen (
                      context,
                      listaOrigenes,
                      servicioBus),
                ),
                Container(
                  height: 56,
                  child: dropInformacionDestino (
                      context,
                      listaDestino),
                )
              ],
            ),
          )
        ],
        ),
      ),
    );
  }

  Widget dropInformacionOrigen (BuildContext context, List<dynamic>? informacion, List<dynamic>? servicioBus){ //Informacion de cada dropdown
    return DropdownButton(
      isExpanded: true,
      value: _origen,
      items: informacion?.map((lists)
      => DropdownMenuItem(
        value: lists.toString(),
        child: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            lists.toString(),
            style: Theme.of(context).textTheme.bodyLarge),
        )
      ),
      )?.toList(),
      onChanged: (String? newValue){
        setState(() {
          _destino = "Destino";
          _origen = newValue.toString();
          _index = informacion!.indexWhere((element)
          => element.toString() == _origen);
        });
      },
    );
  }

  Widget dropInformacionDestino (BuildContext context, List<List<dynamic>> informaciones){ //Informacion de cada dropdown
    print(informaciones[1]);
    List<dynamic> informacion = informaciones[_index];
    print(informacion.toString());

    return DropdownButton(
      isExpanded: true,
      value: _destino,
      items: informacion?.map((lists)
      => DropdownMenuItem(
          value: lists.toString(),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
                lists.toString(),
                style: Theme.of(context).textTheme.bodyLarge),
          )
      ),
      )?.toList(),
      onChanged: (String? newValue){
        setState(() {
          _destino = newValue.toString();
          _index2 = informacion!.indexWhere((element)
          => element.toString() == _destino);
        });
      },
    );
  }

  Widget informacionServicio (BuildContext context, List<dynamic>? servicioBus){ //list users son las imagenes, carga la info de los servicios
    var servicioInformacion;
    if(_index-1 < 0){
      return Column();
    }
    if(_index-1 > servicioBus!.length){
      return Column();
    }
    else{
      servicioInformacion = servicioBus![_index-1].Destinos;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 23.39, left: 24, right: 24
            ),
            child: Text (
              "Aquí podés encontrar todas las rutas de buses para movilizarte al TEC de Cartago. ", //Labor del servicio
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: 20.60, left: 24
                  ),
                  alignment: Alignment.topLeft,
                  child: dataBusServicio(context,
                      "Precio",
                      servicioInformacion.destinos[_index2].Precio,
                      'lib/Fotos/Precio.jpg')
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: 20.60, left: 24
                  ),
                  alignment: Alignment.topLeft,
                  child: dataBusServicio(context,
                      "Salida",
                      servicioInformacion.destinos[_index2].Ubicacion,
                      'lib/Fotos/Salida.jpg')
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(
                  top: 20.60, left: 24
              ),
              alignment: Alignment.topLeft,
              child: dataBusServicio(context, "Paradas",
                  servicioInformacion.destinos[_index2].Paradas.join("\n"),
                  'lib/Fotos/Paradas.jpg')
          ),
          Container(
              padding: EdgeInsets.only(
                  top: 20.60, left: 24
              ),
              alignment: Alignment.topLeft,
              child: dataBusServicio(context, "Horarios",
                  servicioInformacion.destinos[_index2].Horarios.join("\n"),
                  'lib/Fotos/Horarios.jpg')
          ),
        ]
    );
  }

  Widget dataBusServicio (BuildContext context, titulo, cantidad, imagen){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            width: 24,
            height: 24,
            image: AssetImage(imagen)
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text (
                titulo.toString(), //Labor del servicio
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text (
                cantidad.toString(), //Labor del servicio
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}