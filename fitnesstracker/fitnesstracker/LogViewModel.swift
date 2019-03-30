//
//  LogViewModel.swift
//  fitnesstracker
//
//  Created by Andi Cho on 3/14/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    let name: String
    let exerciseID: Int
    let templateID: Int
    let sets: Sets
}

struct Sets: Codable {
    let reps: Int
    let weights: Int
}

struct DailyLog: Codable {
    let exercises: [Exercise]
}

extension APIClient {
    func getDailyLog(completion: @escaping (DailyLog)->()){
        let URLString = "https://api.myjson.com/bins/jsqou"
        guard let url = URL(string: URLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    
                    let dailyLog = try JSONDecoder().decode(DailyLog.self, from:jsonData)
                    completion(dailyLog)
                } catch {
                    print(error)
                }
            }
            }.resume()
        
    }
    
    /*
    func createLog(completion: @escaping (DailyLog)->()){
        let URLString = "https://api.myjson.com/bins/jsqou"
        guard let url = URL(string: URLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    
                    let dailyLog = try JSONDecoder().decode(DailyLog.self, from:jsonData)
                    completion(dailyLog)
                } catch {
                    print(error)
                }
            }
            }.resume()
        
    }
 */
}
