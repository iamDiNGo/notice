//
//  ViewNew.swift
//  testForest
//
//  Created by DiNGo on 17.04.17.
//  Copyright © 2017 dingo. All rights reserved.
//

import UIKit
import CoreData

class VCEdit: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var costText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var buttonOk: UIBarButtonItem!
    
    var buttonTag = 0
    var myIndex1 = 0
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func buttonOk(_ sender: Any) {
        
        if buttonTag == 1{
            self.saveData(title: titleText.text!, cost: costText.text!, desc: descText.text!)
        }
        if buttonTag == 2{
            self.deleteData()
        }
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(buttonTag)
        if buttonTag == 1{
            self.buttonOk.title = "ОК"
        }
        if buttonTag == 2{
            
            let new = news[myIndex1]
            
            titleText.text = new.value(forKey: "title") as? String
            costText.text = new.value(forKey: "cost") as? String
            descText.text = new.value(forKey: "desc") as? String
        
            self.buttonOk.title = "Удалить"
        }
    }
    
    func saveData(title: String, cost: String, desc: String) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        //Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "Main", in: managedContext)
        //Создание нового объекта
        let new = NSManagedObject(entity: entity!, insertInto: managedContext)
        //Установка значении атрибутов

        new.setValue(title, forKey: "title")
        new.setValue(cost, forKey: "cost")
        new.setValue(desc, forKey: "desc")
        new.setValue(NSDate(), forKey: "date")
        //Запись объекта
        self.appDelegate.saveContext()
    }
    func deleteData() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        //Установка значения атрибута
        let data = news[myIndex]
        //Удаление
        managedContext.delete(data)
        //Запись объекта
        self.appDelegate.saveContext()
    }
}
