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
    
    let id : String?
    let title : String?
    let game_name : String?
    let reward_url : String?
    let is_redeem_code : String?
    let is_game_link : String?
    let date : String?
    let time : String?
    let views : String?
    var is_opened : String?

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
