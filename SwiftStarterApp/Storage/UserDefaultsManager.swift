//
//  UserDefaultsManager.swift
//  SwiftStarterApp
//
//  Created by Ntobeko Sikithi on 2025/05/14.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    func savePosition(_ position: Position) {
        if let encoded = try? JSONEncoder().encode(position) {
            defaults.set(encoded, forKey: Constants.UserDefaultsKeys.lastPosition)
        }
    }

    func loadPosition() -> Position {
        if let data = defaults.data(forKey: Constants.UserDefaultsKeys.lastPosition),
           let position = try? JSONDecoder().decode(Position.self, from: data) {
            return position
        }
        return .origin
    }

    func saveStepCount(_ count: Int) {
        defaults.set(count, forKey: Constants.UserDefaultsKeys.totalStepCount)
    }

    func loadStepCount() -> Int {
        return defaults.integer(forKey: Constants.UserDefaultsKeys.totalStepCount)
    }

    func clearAll() {
        defaults.removeObject(forKey: Constants.UserDefaultsKeys.lastPosition)
        defaults.removeObject(forKey: Constants.UserDefaultsKeys.totalStepCount)
    }
}
