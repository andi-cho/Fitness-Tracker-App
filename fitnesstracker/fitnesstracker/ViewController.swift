//
//  ViewController.swift
//  fitnesstracker
//
//  Created by Andi Cho on 2/14/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dailyLog: DailyLog?
    
    @IBAction func addLog(_ sender: Any) {
        self.performSegue(withIdentifier: "addLog", sender: self)
    }
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        /*
        let apiClient = APIClient.sharedinstance
        apiClient.getDailyLog { (currentDailyLog) in
    
            self.dailyLog = currentDailyLog
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        */
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyLog = dailyLog else {return 0}
        return dailyLog.exercises.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyLogCell", for: indexPath) as? ExerciseTableViewCell
        guard let exerciseCell = cell else {return UITableViewCell()}
        guard let dailyLog = dailyLog else {return UITableViewCell()}
        exerciseCell.exerciseNameLabel.text = dailyLog.exercises[indexPath.row].name
      //  exerciseCell.repCountLabel.text = "\(dailyLog.exercises[indexPath.row].set.reps)"
     //   exerciseCell.weightLabel.text = "\(dailyLog.exercises[indexPath.row].set.weights)"
       
        return exerciseCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 159
    }
    

}

