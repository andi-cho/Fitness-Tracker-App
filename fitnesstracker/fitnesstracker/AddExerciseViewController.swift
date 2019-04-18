//
//  AddExerciseViewController.swift
//  fitnesstracker
//
//  Created by Katie Wilcox on 4/9/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func addSet(_ sender: Any) {
         let alertController = UIAlertController(title: "New Set", message: "Input weight and number of reps.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Weight"
            })
        alertController.addTextField(configurationHandler: { (textField2) in
            textField2.placeholder = "Reps"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (alertAction) in
            
            let textField = alertController.textFields![0] as UITextField
            let textField2 = alertController.textFields![1] as UITextField
            
            var set = Set(reps: Int(textField2.text!)!, weights: Int(textField.text!)!)
            
            self.appendSet(set: set)
        })
    alertController.addAction(cancelAction)
    alertController.addAction(saveAction)
    
    self.present(alertController, animated: true, completion: nil)
    }
    
    func appendSet(set: Set){
        sets.append(set)
        customizeExerciseTableView.reloadData()
    }
    
    
    @IBOutlet weak var customizeExerciseTableView: UITableView!
    
    var template : Template!
    var exerciseName: String!
    var sets : [Set] = [] //data source

    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseName = template.name
        self.title = template.name
        customizeExerciseTableView.delegate = self
        customizeExerciseTableView.dataSource = self
       sets = template.exercise.sets
        customizeExerciseTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as? SetTableViewCell
        guard let setCell = cell
            else{
                return UITableViewCell()
        }
        setCell.setUpCell(set: sets[indexPath.row])
        return setCell
    }
    
    @IBAction func addToLog(_ sender: Any) {
        var exerciseParam = ExerciseParameters(name: exerciseName)
        exerciseParam.sets = sets
        
        let jsonData = try! JSONEncoder().encode(exerciseParam)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        let apiClient = APIClient.sharedinstance
        apiClient.createExercise(jsonData: jsonData, completion: { (response) in
            //check if error, display an error message
            //otherwise go
            if (response == "Done."){
                self.displayLog()
            }else{
                //create an alert
                print("you fucked up")
            }
        })
        
        
        //send request
        //go to daily log screen
        //reload data
        
    }

    func displayLog(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "displayLogSegue", sender: self)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
