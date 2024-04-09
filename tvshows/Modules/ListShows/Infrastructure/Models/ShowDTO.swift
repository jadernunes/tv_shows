//
//  ShowDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

struct ShowDTO: Decodable {
    
    let id: Int
    let name: String
    let language: String?
    let image: ShowImageDTO?
    let summary: String?
    let schedule: ScheduleDTO?
    let genres: [String]?
    
    //Internal
    var isFavorite: Bool?
    
    init(id: Int, name: String, language: String?, image: ShowImageDTO?, summary: String?, schedule: ScheduleDTO?, genres: [String]?, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.language = language
        self.image = image
        self.summary = summary
        self.schedule = schedule
        self.genres = genres
    }
    
    init(show: Show) {
        self.init(
            id: show.id,
            name: show.name,
            language: show.language,
            image: ShowImageDTO(showImage: show.image),
            summary: show.summary,
            schedule: ScheduleDTO(schedule: show.schedule),
            genres: show.genres,
            isFavorite: show.isFavorite)
    }
    
    var asShow: Show {
        Show(
            id: id,
            name: name,
            language: language,
            image: image?.asShowImage,
            summary: summary,
            schedule: schedule?.asSchedule,
            genres: genres,
            isFavorite: isFavorite ?? false)
    }
}

// MARK: - ObjectRepresentable

extension ShowDTO: ObjectRepresentable {
    static var key: String { "ShowDTO" }
}
