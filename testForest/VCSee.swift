//
//  ViewSee.swift
//  testForest
//
//  Created by DiNGo on 17.04.17.
//  Copyright © 2017 dingo. All rights reserved.
//

import UIKit
import CoreData

class VCSee: UIViewController {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var costText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var dataText: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let new = news[myIndex]
        titleText.text = new.value(forKey: "title") as? String
        costText.text = new.value(forKey: "cost") as? String
        descText.text = new.value(forKey: "desc") as? String
    }
    
    @IBAction func editButton(_ sender: Any) {
        //переход на редактирование
        performSegue(withIdentifier: "editNews", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editNews"){
            let VCEdit : VCEdit = segue.destination as! VCEdit
            VCEdit.buttonTag = 2
            VCEdit.myIndex1 = myIndex
        }
    }
}
