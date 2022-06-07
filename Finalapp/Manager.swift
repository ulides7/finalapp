//
//  Manager.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-03.
//

import Foundation

protocol Managerprotocol {
    func cargarDatos(datitos: [Datos])
    func Error(Error:String)
}



struct Manager{
    
    var delegado: Managerprotocol?

    var resultados = [Datos]()
    
    func buscar(){
        let urlString = URL(string: "https://dummyapi.io/data/v1/post")
        var request = URLRequest(url: urlString!)
        
        request.setValue("629540eee000608d09fb3463", forHTTPHeaderField: "app-id")
        
        let session = URLSession(configuration: .default)
        let tarea = session.dataTask(with: request) { datos, response, error in
                                   
                    if error != nil{
                                  
                        delegado?.Error(Error: error!.localizedDescription)
                        print(String(describing: error))

                               }
                               if let datosSeguros = datos{
               
                                   if let lista = self.parcearJSON(stories: datosSeguros){
                                                           delegado?.cargarDatos(datitos: lista)
                                       
                                           }}
                
            }
            tarea.resume()
        }
    
    
    
    func parcearJSON(stories: Data) -> [Datos]?{
        let decodificador = JSONDecoder()
        do{
            
//            let datosDecodificados: [Datos] = try decodificador.decode(todosdat.self, from: stories)
//
//            let stories:[Datos] = datosDecodificados
//
            let datosDecodificados = try decodificador.decode(todosdat.self, from: stories)
            
            let stories: [Datos] = datosDecodificados.data
            
            
            print("a im: \(stories[0].text)")
            print("owner: \(stories[0].owner?.firstName)")

            
            
            
            
          
            return stories
        }
        
        catch{
            print("error: \(error)")
          return nil
        }
    }

    
    //        if let url = URL(string: urlString){
    //            let session = URLSession(configuration: .default)
    //            let tarea = session.dataTask(with: url) { datos, respuesta, error in
    //                if error != nil{
    //                    delegado?.Error(Error: error!.localizedDescription)
    //                }
    //                if let datosSeguros = datos{
    //
    //                    if let lista = self.parcearJSON(datosCovid: datosSeguros){
    //                                            delegado?.cargarDatos(pais: lista)
    //                            }}
    //            }
    //            tarea.resume()
    //        }
    //    }
    
//    func parcearJSON(datosCovid: Data) -> [Datos]?{
//        let decodificador = JSONDecoder()
//        do{
//            let datosDecodificados: [Datos] = try decodificador.decode([Datos].self, from: datosCovid)
//            let pais:[Datos] = datosDecodificados
//
//            print(datosDecodificados[0].country)
//            print(datosDecodificados[0].cases)
//
//            return pais
//        }
//        catch{
//            print("error: \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
}
