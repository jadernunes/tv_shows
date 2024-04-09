//
//  FavoriteService.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 07/04/24.
//

import Foundation

protocol IFavoriteService {
    func add(model: ShowDTO)
    func remove(id: Int)
    func loadAll() -> [ShowDTO]
}

final class FavoriteService: IFavoriteService {

    // MARK: - Properties

    private let database: IDatabaseService

    // MARK: - Life cycle

    init(database: IDatabaseService = DatabaseService()) {
        self.database = database
    }

    // MARK: - Methods

    func add(model: ShowDTO) {
        var model = model
        model.isFavorite = true
        do {
            var objects = try database.loadAll(type: ShowDTO.self)
            if !objects.contains(where: { $0.id == model.id }) {
                objects.append(model)
                try database.save(model: objects)
            }
        } catch {
            //TODO: handle error
        }
    }

    func remove(id: Int) {
        do {
            var objects = try database.loadAll(type: ShowDTO.self)
            objects.removeAll(where: { $0.id == id })
            try database.save(model: objects)
        } catch {
            //TODO: handle error
        }
    }

    func loadAll() -> [ShowDTO] {
        do {
            return try database.loadAll(type: ShowDTO.self)
        } catch {
            return []
        }
    }
}
