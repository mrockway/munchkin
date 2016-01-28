//
//  SecondViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var dueDate = NSDate()
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDateSelector: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateSelector.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        // Do any additional setup after loading the view.
    }

    
    func datePickerChanged(datePicker:UIDatePicker) {
        dueDate = datePicker.date
        
        dueDateLabel.text = "Due Date: \(dueDate)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
