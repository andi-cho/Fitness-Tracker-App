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

struct ExerciseParameters: Codable {
    let name: String
    var sets: [Set]
   
    
    init(name: String){
        self.name = name
        self.sets = []
    }
}

struct Exercise: Codable {
    let _id: String
    let name: String
    let templateID: String
    var sets: [Set]
    let created: String
    
    init(name: String){
        self.name = name
        self.templateID = ""
        self.sets = []
        self.created = ""
        self._id = ""
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
    func getDailyLog(completion: @escaping ([Exercise])->()){
        let URLString = "https://workoutapp-api-heroku.herokuapp.com/exercises"
        guard let url = URL(string: URLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    
                    let dailyLog = try JSONDecoder().decode([Exercise].self, from:jsonData)
                    completion(dailyLog)
                } catch {
                    print(error)
                }
            }
            }.resume()
        
    }
    
    
    func createExercise(jsonData: Data, completion: @escaping (String)->()){
        let URLString = "https://workoutapp-api-heroku.herokuapp.com/exercises"
        guard let url = URL(string: URLString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    
                   // let jsonResponse = try JSONDecoder().decode(String.self, from:jsonData)
                    let jsonString = String(data: jsonData, encoding: .utf8)!
                    print(jsonString)
                    completion(jsonString)
                } catch {
                    print(error)
                }
            }
            }.resume()
        
    }
 
}
