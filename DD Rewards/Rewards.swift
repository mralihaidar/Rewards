//
//  Rewards.swift
//  DD Rewards
//
//  Created by Ali on 16/02/2023.
//

import Foundation

struct RewardsResponse: Codable {
    let status: Int?
    let status_message: String?
    let data: [Rewards]?
}

struct Rewards: Codable {
    let title: String?
    let date: String?
    let reward_url: String?
}

struct gamesResponse: Codable {
    let games: [games]?
}

struct games: Codable {
    let url: String?
    let name: GameName?
    let assets: GamePng?
}

struct GameName: Codable {
    let en: String?
}

struct GamePng: Codable {
    let thumb: String?
}
