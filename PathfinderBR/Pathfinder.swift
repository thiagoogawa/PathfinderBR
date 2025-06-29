//
//  Pathfinder.swift
//  PathfinderBR
//
//  Created by Thiago Ogawa on 24/06/25.
//
import SwiftUI
import MapKit

struct Pathfinder: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: pathFinderType
    let latitude: Double
    let longitude: Double
    let topics: [String]
    let description: [Description]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct Description: Decodable, Identifiable {
        let id: Int
        let sceneDescription: String
    }
}

enum pathFinderType: String, Decodable, CaseIterable, Identifiable {
    case all
    case southern
    case southeastern
    case centralWest
    case northern
    case northeastern
    
    var id: pathFinderType {
        self
    }
    
    var background: Color {
        switch self {
        case .southern:
            Color(red: 0.55, green: 0.35, blue: 0.27)
        case .southeastern:
            Color(red: 0.00, green: 0.70, blue: 0.65)
        case .centralWest:
            Color(red: 0.25, green: 0.45, blue: 0.90)
        case .northern:
            Color(red: 0.85, green: 0.30, blue: 0.25)
        case .northeastern:
            Color(red: 0.95, green: 0.80, blue: 0.20)
        case .all:
            Color(red: 0.25, green: 0.25, blue: 0.25)
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .southern:
            "leaf.fill"
        case .southeastern:
            "building.2.fill"
        case .centralWest:
            "tortoise.fill"
        case .northern:
            "drop.fill"
        case .northeastern:
            "sun.max.fill"
        }
    }
}
