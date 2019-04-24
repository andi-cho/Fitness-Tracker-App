//
//  CalendarViewController.swift
//  fitnesstracker
//
//  Created by Andi Cho on 4/20/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateHeader: JTAppleCollectionReusableView  {
    @IBOutlet var monthTitle: UILabel!
}

class CalendarViewController: UIViewController {
    @IBOutlet var calendarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        // Do any additional setup after loading the view.
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
