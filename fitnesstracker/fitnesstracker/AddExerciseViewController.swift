//
//  AddExerciseViewController.swift
//  fitnesstracker
//
//  Created by Katie Wilcox on 4/9/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var customizeExerciseTableView: UITableView!
    
    var template : Template!
    var sets : [Set] = [] //data source

    override func viewDidLoad() {
        super.viewDidLoad()
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
