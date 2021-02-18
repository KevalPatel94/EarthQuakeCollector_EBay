//
//  EarthQuakeMocks.swift
//  EarthQuakeCollectorTests
//
//  Created by Keval Patel on 2/16/21.
//

import Foundation
import XCTest
@testable import EarthQuakeCollector

struct EarthQuakeMocks {
    static let firstEarthQuakeProperties = EarthQuakeProperties(magnitude: 1.8,
                                                                usgsUrl: "https://earthquake.usgs.gov/earthquakes/eventpage/ak01421dpqr",
                                                                title: "M 1.8 - 74km SW of Unalaska, Alaska",
                                                                status: "reviewed")
    static let secondEarthQuakeProperties = EarthQuakeProperties(magnitude: 1.1,
                                                                 usgsUrl: "https://earthquake.usgs.gov/earthquakes/eventpage/ak01421ig3u",
                                                                 title: "M 1.1 - 117km NW of Talkeetna, Alaska",
                                                                 status: "reviewed")
    static let thirdEarthQuakeProperties = EarthQuakeProperties(magnitude: 1.2,
                                                                usgsUrl: "https://earthquake.usgs.gov/earthquakes/eventpage/ak01421i2zj",
                                                                title: "M 1.2 - 6km SSW of Big Lake, Alaska",
                                                                status: "reviewed")
    static let fourthEarthQuakeProperties = EarthQuakeProperties(magnitude: 1.4,
                                                                 usgsUrl: "https://earthquake.usgs.gov/earthquakes/eventpage/ak01421heui",
                                                                 title: "M 1.4 - 63km NW of Talkeetna, Alaska",
                                                                 status: "reviewed")
    static let fifthEarthQuakeProperties = EarthQuakeProperties(magnitude: 4,
                                                                usgsUrl: "https://earthquake.usgs.gov/earthquakes/eventpage/usc000mnnn",
                                                                title: "M 4.0 - 27km WNW of Coquimbo, Chile",
                                                                status: "reviewed")
    
    static let firstEarthQuake = EarthQuake(earthQuakeProperties: firstEarthQuakeProperties)
    static let secondEarthQuake = EarthQuake(earthQuakeProperties: secondEarthQuakeProperties)
    static let thirdEarthQuake = EarthQuake(earthQuakeProperties: thirdEarthQuakeProperties)
    static let fourthEarthQuake = EarthQuake(earthQuakeProperties: fourthEarthQuakeProperties)
    static let fifthEarthQuake = EarthQuake(earthQuakeProperties: fifthEarthQuakeProperties)
    static let arrayOfEarthQuake: [EarthQuake] = [firstEarthQuake, secondEarthQuake, thirdEarthQuake, fourthEarthQuake, fifthEarthQuake]
    static let wrongSequenceArrayOfEarthQuake: [EarthQuake] = [thirdEarthQuake, fourthEarthQuake, secondEarthQuake, fifthEarthQuake, firstEarthQuake]
    
}
