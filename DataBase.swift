//
//  DataBase.swift
//  HitList
//
//  Created by Appinventiv on 25/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class DataBase{
  
  var people = [Person]()
  
  var name = String()
  var age = Int16()
  var email = String()
  var dob = String()
  var phNumber = Int64()
  
  func saveData() {
     
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
           }
     
         let managedContext = appDelegate.persistentContainer.viewContext
    
         let entity = NSEntityDescription.entity(forEntityName: "Person" , in: managedContext)!
     
         let person = Person(entity: entity , insertInto: managedContext)
     
         person.name = name
     
         person.age =  age
     
         person.email = email
     
         person.dob = dob
    
         person.phoneNumber = phNumber
         do {
       
             try managedContext.save()
       
             people.append(person)
       
           } catch let error as NSError {
         
                 print("Could not save. \(error), \(error.userInfo)")
           
             }
     
       }
   
   func fetchData(){
     
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("no Delegate !")
         }
     
       let managedContext = appDelegate.persistentContainer.viewContext
     
       let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
     
       do {
       
           people = try managedContext.fetch(fetchRequest)
           
         } catch let error as NSError {
          
         print("Could not fetch. \(error), \(error.userInfo)")
           
           }
         
       }
  
   func deleteData(_ deleteSpecificData : Person) {
    
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("no Delegate !")
        }
     
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(deleteSpecificData)
     
              do {
                
             try managedContext.save()
              } catch _ {
            
            print("Could not delete")
      
      }
    
    }
  
  func updateData(_ forPerson : Person, _ index: Int){
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
    }
  
    let managedContext = appDelegate.persistentContainer.viewContext
  
    people[index].name = forPerson.name
  
    people[index].age = forPerson.age
  
    people[index].dob = forPerson.dob
  
    people[index].email = forPerson.email
    
    people[index].phoneNumber = forPerson.phoneNumber
    do {
  
      try managedContext.save()
  
    } catch let error as NSError {
  
      print("Could not save. \(error), \(error.userInfo)")
  
    }
  
  }
}
