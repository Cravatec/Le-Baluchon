//
//  MoneyResponse.swift
//  Le Baluchon
//
//  Created by Sam on 09/07/2022.
//

import Foundation

struct MoneyResponse: Decodable
{
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: [String: Double]
}
