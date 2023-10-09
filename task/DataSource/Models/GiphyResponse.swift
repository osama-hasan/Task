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

struct GiphySingleResponse: Codable {
    let data: GiphyGif
}
struct GiphyGif: Codable {
    let id: String
    let title: String
    let images: GiphyImages
    let url : String
    let slug : String
    let type : String
}

struct GiphyImages: Codable {
    let original: GiphyImage
    let fixedWidthDownsampled: GiphyImage
}

struct GiphyImage: Codable {
    let url: String
    let height:String
    let width:String
}
