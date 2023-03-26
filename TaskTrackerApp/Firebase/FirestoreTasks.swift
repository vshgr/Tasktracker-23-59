//
//  FirestoreTasks.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 19.03.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


extension AppViewModel {    
    func insertTask(email: String, task: Task) {
        var ref: DocumentReference? = nil
        ref = db.collection("users").document(auth.currentUser?.email ?? "").collection("tasks").addDocument(data: [
            "name": task.name,
            "description": task.description,
            "deadlineDate": task.deadlineDate
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getTasks() {
        db.collection("users").document(auth.currentUser?.email ?? "").collection("tasks").addSnapshotListener { (querySnapshot, error) in
            guard let tasks = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tasks = tasks.map { queryDocumentSnapshot -> Task in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let deadlineDate = data["deadlineDate"] as? Timestamp ?? Timestamp()
                let date = deadlineDate.dateValue()
//                let deadlineDate = data["deadlineDate"] as? Date ?? Date()
                return Task(id: id, name: name, description: description, deadlineDate: date)
            }
        }
    }
    
    func getUserTasksByEmail(email: String) -> [Task] {
        db.collection("users").document(email).collection("tasks").addSnapshotListener { (querySnapshot, error) in
            guard let tasks = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.anotherTasks = tasks.map { queryDocumentSnapshot -> Task in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let deadlineDate = data["deadlineDate"] as? Timestamp ?? Timestamp(date: Date())
                let date = deadlineDate.dateValue()
                return Task(id: id, name: name, description: description, deadlineDate: date)
            }
        }
        for elem in anotherTasks {
            print(elem.name)
        }
        return anotherTasks
    }
    
    func fetchUserTask(email: String) {
        db.collection("users").document(email).collection("tasks").addSnapshotListener { (querySnapshot, error) in
            guard let tasks = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.anotherTasks = tasks.map { queryDocumentSnapshot -> Task in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let deadlineDate = data["deadlineDate"] as? Timestamp ?? Timestamp(date: Date())
                let date = deadlineDate.dateValue()
                return Task(id: id, name: name, description: description, deadlineDate: date)
            }
        }
    }
    
    func getTasksByEmail(email: String) {
        db.collection("users").document(email).collection("tasks").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.anotherTasks = snapshot.documents.map { d in
                            return Task(id: d.documentID, name: d["name"] as? String ?? "", description: d["name"] as? String ?? "", deadlineDate: d["deadlineDate"] as? Date ?? Date())
                        }
                    }
                }
            } else {
                
            }
        }
    }
    
    func getTaskByID (id: String) -> Task {
        var ret = Task()
        for task in tasks {
            if task.id == id {
                ret = task
            }
        }
        return ret
    }
    
    func getAnotherUserTaskById(id: String, email: String) -> Task {
        var ret = Task()
        for task in getUserTasksByEmail(email: email) {
            if task.id == id {
                ret = task
            }
        }
        return ret
    }
    
    func deleteTask(id: String) {
        db.collection("users").document(auth.currentUser?.email ?? "").collection("tasks").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
