//
//  AddTemplateViewController.swift
//  fitnesstracker
//
//  Created by Katie Wilcox on 4/4/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class AddTemplateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var templates : [Template] = []
    @IBOutlet var addTableView: UITableView! //change this name templateTableView
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTableView.delegate = self
        addTableView.dataSource = self

        //Hardcoding some templates
        var sets = [Set(reps: 2, weights: 100), Set(reps: 4, weights: 10)]
        var exercise = Exercise(name: "Squat")
        exercise.sets = sets
        var temp1 = Template(name: "Squat", exercise: exercise)
      //  var temp2 = Template(name: "Bench", exercise: Exercise(name: "Bench"))
      //  var temp3 = Template(name: "Pull Ups", exercise: Exercise(name: "Pull Ups"))
        
        templates.append(temp1)
    //    templates.append(temp2)
    //    templates.append(temp3)
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseTemplateCell", for: indexPath)
        cell.textLabel?.text = templates[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "customizeTemplateSegue", sender: self)
        
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeTemplateSegue" {
            let destination = segue.destination as? AddExerciseViewController
            if let addexerciseVC = destination, let index = addTableView.indexPathForSelectedRow?.row{
                addexerciseVC.template = templates[index]
            }
        }
    }
    

}
