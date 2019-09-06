//
//  AstronomyPictureOfTheDay.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation

struct AstronomyPictureOfTheDay: Decodable {
    let date: String
    let explanation: String
    let hdurl: String
    let title: String
    let url: String
}
