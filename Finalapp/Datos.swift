//
//  Datos.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-03.
//

import Foundation
import UIKit

struct todosdat: Decodable {
    let data: [Datos]
}


struct Datos: Decodable{
    let image: String?
    let likes: Double?
    let text: String?
    var owner: getowner?
    
}

struct getowner: Decodable{
    let title: String?
    let firstName: String?
    let lastName: String?
    let picture: String?
}



//{"id":"60d21bd767d0d8992e610e31","image":"https://img.dummyapi.io/photo-1576707064479-3139e7e8aace.jpg","likes":19,"tags":["animal","canine","dog"] ,"text":"Sleeping dogs lie two dogs lying on black textile","publishDate":"2020-05-23T12:55:22.576Z", "owner”:
//
//{"id":"60d0fe4f5311236168a10a0f","title":"mr","firstName":"Kaya","lastName":"Basoglu","picture":"https://randomuser.me/api/portraits/med/men/59.jpg"}
//}
