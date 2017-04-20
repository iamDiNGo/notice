//
//  ViewController.swift
//  testForest
//
//  Created by DiNGo on 17.04.17.
//  Copyright © 2017 dingo. All rights reserved.
//

import UIKit
import CoreData

var news: [NSManagedObject] = []
var myIndex = 0

class VCMain: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = news[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = person.value(forKey: "title") as? String
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "VCSee", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "VCEdit"){
            let VCEdit: VCEdit = segue.destination as! VCEdit
            VCEdit.buttonTag = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        }
    
    func loadData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Main")
        //Сортировка по времени
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do{
            news = try managedContext.fetch(fetchRequest)
            //Перезагрузка таблицы
            DispatchQueue.main.async{
                self.myTableView.reloadData()
            }
        } catch let error as NSError {
            print("Поймал ошибку. \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindMain(segue: UIStoryboardSegue){
        
    }
}

