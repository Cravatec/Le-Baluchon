//
//  TranslateResponse.swift
//  Le Baluchon
//
//  Created by Sam on 20/07/2022.
//

import Foundation

struct TranslateResponse: Decodable
{
    let data: DataTranslate
}

struct DataTranslate: Decodable
{
    let translations: [Translation]
}

struct Translation: Decodable
{
    let translatedText: String
}
