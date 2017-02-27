//
//  ViewController.swift
//  HitData
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  //properties
  var database = DataBase()
  
  //outlet
  @IBOutlet weak var tableView: UITableView!
  
  //MARK: View life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "The List"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    database.fetchData()
    tableView.reloadData()
    
  }
  
  
  //add new detail button actions
  @IBAction func addName(_ sender: UIBarButtonItem) {
    
    guard let detailPage = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageVC else{ return
    }
    
    detailPage.pageViewMode = .addNew
    
    self.navigationController?.pushViewController(detailPage, animated: true)
    
  }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource,UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return database.people.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let person = database.people[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    cell.textLabel?.text = person.name
    
    return cell
    
  }
  
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    
    return true
  }
  
  
  //delete/ edit on swipe on row
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
      let update = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
        
        guard let detailPage = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageVC else{ return
        }
        
        let row = indexPath.row
        
        detailPage.pageViewMode = .isInEditMode
        
        detailPage.updateAt = row
        
        detailPage.person = self.database.people[row]
        
        self.navigationController?.pushViewController(detailPage, animated: true)
        print("Edit")
      }
      
      let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
        self.database.deleteData(self.database.people[index.row])
        self.database.people.remove(at: index.row)
        self.tableView.reloadData()
        
      }
      return [delete, update]
    }
  
  
  // display attributes of the entity selected
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let detailPage = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageVC else{ return
    }
    
    detailPage.info = indexPath.row
    detailPage.person = self.database.people[indexPath.row]
    detailPage.pageViewMode = .isInPreviewMode
    self.navigationController?.pushViewController(detailPage, animated: true)
    
  }

}
