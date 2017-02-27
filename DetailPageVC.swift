//
//  DetailPageVC.swift
//  HitList
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class DetailPageVC: UIViewController {
  
    //properties
    var dataBase = DataBase()
    var placeHolderText = ["Name", "Age", "Date of Birth", "Email", "Ph. Number"]
  
    var pageViewMode = ListViewMode.isInPreviewMode
    var info = Int()
  
    var person : Person!
    var updateAt = Int()
  
    //outlet
    @IBOutlet var detailTableView: UITableView!
  
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
      detailTableView.dataSource = self
      detailTableView.delegate = self
      
      dataBase.fetchData()
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
    }
}


//MARK: UITableViewDataSource, UITableViewDelegate
extension DetailPageVC: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
    return placeHolderText.count
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCellID", for: indexPath) as? InfoCell else{fatalError("Cell Not Found")
    }
    
    
    infoCell.infoLabel.text = placeHolderText[indexPath.row]
    
    infoCell.infoTextField.delegate = self
    
    //displaying text field placeholders on the basis of view mode open
    if pageViewMode == .addNew{
      
      infoCell.infoTextField.isEnabled = true
      infoCell.infoTextField.placeholder = placeHolderText[indexPath.row]

    } else if pageViewMode == .isInPreviewMode {
      
      infoCell.infoTextField.isEnabled = false
      
      switch indexPath.row {
        
      case 0: infoCell.infoTextField.text = person.name
      
      case 1: infoCell.infoTextField.text = String(person.age)
        
      case 2: infoCell.infoTextField.text = String(person.dob!)
        
      case 3: infoCell.infoTextField.text = person.email
        
      case 4: infoCell.infoTextField.text = String(person.phoneNumber)
        
      default: print("default")
      }
      
    }else {
      
      infoCell.infoTextField.isEnabled = true
      
      switch indexPath.row {
        
      case 0: infoCell.infoTextField.text = person.name
        
      case 1: infoCell.infoTextField.text = String(person.age)
        
      case 2: infoCell.infoTextField.text = String(person.dob!)
        
      case 3: infoCell.infoTextField.text = person.email
        
      case 4: infoCell.infoTextField.text = String(person.phoneNumber)
        
      default: print("default")
      }
    }
    
    return infoCell
  }
  
  //MARK: text Field Did End Editing
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    guard let infoCell = textField.getTableCell as? InfoCell else{ return
    }
    
    let indexPath = self.detailTableView.indexPath(for: infoCell)!
    
    if pageViewMode == .addNew{
      
      switch indexPath.row {
      case 0: dataBase.name = infoCell.infoTextField.text!
        
      case 1: dataBase.age = Int16(infoCell.infoTextField.text!)!
        
      case 2: dataBase.dob = infoCell.infoTextField.text!
        
      case 3: dataBase.email = infoCell.infoTextField.text!
        
      case 4: dataBase.phNumber = Int64(infoCell.infoTextField.text!)!
        
      default: print("default")
      }

    }else{
      
      switch indexPath.row {
      case 0: person.name = infoCell.infoTextField.text!
        
      case 1: person.age = Int16(infoCell.infoTextField.text!)!
        
      case 2: person.dob = infoCell.infoTextField.text!
        
      case 3: person.email = infoCell.infoTextField.text!
        
      case 4: person.phoneNumber = Int64(infoCell.infoTextField.text!)!
        
      default: print("default")
      }
      
    }
  
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 80
  }
  
  
}


extension DetailPageVC{
  
  //MARK: Done Button Tapped
  func  doneTapped(_ doneButton: UIBarButtonItem ) {
    
    detailTableView.endEditing(true)

    if pageViewMode == .addNew  {
      
      dataBase.saveData()
    }else if pageViewMode == .isInEditMode{
      dataBase.updateData(person ,updateAt)
    }
    self.detailTableView.reloadData()
    _ = self.navigationController?.popViewController(animated: true)
  }
}


//MARK: InfoCell: UITableViewCell
class InfoCell: UITableViewCell{
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var infoTextField: UITextField!
    
    
}
