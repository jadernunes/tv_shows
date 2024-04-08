//
//  DatabaseService.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation

protocol IDatabaseService {
    @discardableResult func save<T: ObjectRepresentable>(model: T) throws -> T
    @discardableResult func save<T: ObjectRepresentable>(model: [T]) throws -> [T]
    func loadObject<T: ObjectRepresentable>(type: T.Type) throws -> T?
    func loadAll<T: ObjectRepresentable>(type: T.Type) throws -> [T]
}

final class DatabaseService: IDatabaseService {

    // MARK: - Attributes

    private let database: UserDefaults

    // MARK: - Life cycle

    init(database: UserDefaults = .standard) {
        self.database = database
    }

    // MARK: - Custom methods

    @discardableResult func save<T: ObjectRepresentable>(model: T) throws -> T {
        let object = try JSONEncoder.encoder.encode(model)
        database.setValue(object, forKey: T.key)
        return model
    }

    @discardableResult func save<T: ObjectRepresentable>(model: [T]) throws -> [T] {
        let object = try JSONEncoder.encoder.encode(model)
        database.setValue(object, forKey: T.key)
        return model
    }

    func loadObject<T: ObjectRepresentable>(type: T.Type) throws -> T? {
        guard let object = database.data(forKey: type.key) else { return nil }
        return try JSONDecoder.decoder.decode(T.self, from: object)
    }

    func loadAll<T: ObjectRepresentable>(type: T.Type) throws -> [T] {
        guard let object = database.data(forKey: type.key) else { return [] }
        return try JSONDecoder.decoder.decode([T].self, from: object)
    }
}
