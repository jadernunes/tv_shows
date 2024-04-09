//
//  ScheduleDTO.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

struct ScheduleDTO: Decodable {
    let time: String
    let days: [String]
    
    init(time: String, days: [String]) {
        self.time = time
        self.days = days
    }
    
    init(schedule: Schedule?) {
        self.init(
            time: schedule?.time ?? "",
            days: schedule?.days ?? [])
    }
    
    var asSchedule: Schedule {
        Schedule(
            time: time,
            days: days)
    }
}

// MARK: - ObjectRepresentable

extension ScheduleDTO: ObjectRepresentable {
    static var key: String { "ScheduleDTO" }
}
