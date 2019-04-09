//
//  LogViewModel.swift
//  fitnesstracker
//
//  Created by Andi Cho on 3/14/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import Foundation

struct Template: Codable {
    let name: String
    let templateID: Int
    let exercise: Exercise
    
    init(name: String, exercise: Exercise){
        self.name = name
        self.exercise = exercise
        self.templateID = 0
    }
    
}

struct Exercise: Codable {
    let name: String
    let exerciseID: Int
    let templateID: Int
    var sets: [Set]
    
    init(name: String){
        self.name = name
        self.exerciseID = 0
        self.templateID = 0
        self.sets = []
    }
}

struct Set: Codable {
    let reps: Int
    let weights: Int
    
    init(reps: Int,  weights: Int){
        self.reps = reps
        self.weights = weights
    }
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
