//
//  ScheduleDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

struct ScheduleDTO: Decodable {
    let time: String
    let days: [String]
    
    var asSchedule: Schedule {
        Schedule(
            time: time,
            days: days)
    }
}
