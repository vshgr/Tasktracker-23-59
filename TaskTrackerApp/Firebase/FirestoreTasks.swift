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
                let done = data["done"] as? Bool ?? false
                return Task(id: id, name: name, description: description, deadlineDate: date, done: done)
            }
        }
    }
    
    func fetchFriendsTasks(email: String) {
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
                let deadlineDate = data["deadlineDate"] as? Timestamp ?? Timestamp()
                let date = deadlineDate.dateValue()
                let done = data["done"] as? Bool ?? false
                return Task(id: id, name: name, description: description, deadlineDate: date, done: done)
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
        
        if !anotherTasks.isEmpty {
            for task in anotherTasks {
                if task.id == id {
                    ret = task
                }
            }
        }
        return ret
    }
    
    func getAnotherUserTaskById(id: String) -> Task {
        var ret = Task()
        for task in anotherTasks {
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
    
    func isTaskInSelfTasks(taskID: String) -> Bool {
        return self.tasks.contains(where: {
            $0.id == taskID
        })
    }
    
    func addUserTaskToSelf(task: Task) {
        self.tasks.append(task)
    }
    
    func setTaskDone(taskID: Int, isDone: Bool) {
        self.tasks[taskID].done = isDone
    }
}
