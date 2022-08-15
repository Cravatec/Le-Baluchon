//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Sam on 22/06/2022.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonTests: XCTestCase
{
    func testDownloadWebData()
    {
        // On crée l'expectation en lui donnant une simple description.
        let expectation = XCTestExpectation(description: "Télécharge le site openclassrooms.com")
        // On prépare une requête
        let url = URL(string: "https://openclassrooms.com")!
        let dataTask = URLSession(configuration: .default).dataTask(with: url)
        { (data, _, _) in
            // On vérifie qu'il y a bien des données qui ont été chargées, c'est ici que le test a lieu.
            XCTAssertNotNil(data)
            // On déclare que l'expectation est terminée, on peut clore le test.
            expectation.fulfill()
        }
        // On lance la requête.
        dataTask.resume()
        // On attend que l'expectation soit terminée, avec une durée maximum de 10 secondes.
        wait(for: [expectation], timeout: 10.0)
    }
}
