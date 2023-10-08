//
//  GiphyResponse.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//
import Foundation

struct GiphyResponse: Codable {
    let data: [GiphyGif]
}

struct GiphyGif: Codable {
    let id: String
    let title: String
    let images: GiphyImages
}

struct GiphyImages: Codable {
    let original: GiphyImage
}

struct GiphyImage: Codable {
    let url: String
    let height:String
    let width:String
}
