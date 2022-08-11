//
//  Photo.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import Foundation

struct Photo: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
