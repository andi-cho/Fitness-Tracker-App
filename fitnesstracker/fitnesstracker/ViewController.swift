//
//  ViewController.swift
//  fitnesstracker
//
//  Created by Andi Cho on 2/14/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dailyLog: [Exercise]?
    
    @IBAction func addLog(_ sender: Any) {
        self.performSegue(withIdentifier: "addLog", sender: self)
    }
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: date)// Jan 2, 2001
        self.title = dateString
        
        let apiClient = APIClient.sharedinstance
        apiClient.getDailyLog { (currentDailyLog) in
            
            self.dailyLog = currentDailyLog
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //print(self.dailyLog)
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let apiClient = APIClient.sharedinstance
        apiClient.getDailyLog { (currentDailyLog) in
            
            self.dailyLog = currentDailyLog
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //print(self.dailyLog)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dailyLog = dailyLog else {return 0}
        return dailyLog.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyLog = dailyLog else {return 0}
        return dailyLog[section].sets.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyLogCell", for: indexPath) as? ExerciseTableViewCell
        guard let exerciseCell = cell else {return UITableViewCell()}
        guard let dailyLog = dailyLog else {return UITableViewCell()}
        let exercise = dailyLog[indexPath.section]
        let set = exercise.sets[indexPath.row]
        exerciseCell.repCountLabel.text = "\(set.reps)"
        exerciseCell.weightLabel.text = "\(set.weights)"
       // exerciseCell.exerciseNameLabel.text = dailyLog[indexPath.row].name
      //  exerciseCell.repCountLabel.text = "\(dailyLog.exercises[indexPath.row].set.reps)"
     //   exerciseCell.weightLabel.text = "\(dailyLog.exercises[indexPath.row].set.weights)"
       
        return exerciseCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       guard let dailyLog = dailyLog else {return ""}
        return dailyLog[section].name
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 159
    }
    

}

