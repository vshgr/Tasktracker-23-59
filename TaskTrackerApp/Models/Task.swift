//
//  Task.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum Permission: String {
    case privateTask = "private"
    case publicTask = "public"
}

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    
    var name: String
    var description: String
    var deadlineDate: Date
    var done: Bool
//    var groups: [String]
//    var permission: Permission
//    var owner: User
}

//extension Task {
//    init() {
//        id = "hihihi"
//        name = "Разработать дизайн курсового проекта для приложения - тасктрекера"
//        description = "Подготовить макеты в фигме для индивидуального/командного мини-проекта по созданию мобильного приложения по курсу. Необходимо сформулировать перечень функциональных требований к программе, построить use-case-диаграмму с покрытием прецедентами всех этих требований. Продумать все возможные сценарии использования и отразить их в виде вайрфреймов с проработанными макетами экранов приложения."
//        deadlineDate = Date.init(timeIntervalSince1970: 0)
//        done = false
////        groups = ["Курсовая работа", "Диплом", "Организация вечеринки", "Работа"]
////        permission = Permission.privateTask
////        owner = User()
//    }
//}

