//
//  Notification.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 14/04/26.
//
import Foundation

struct NotificationModel: Codable, Hashable {
    var id: Int?
    var title: String?
    var message: String?
    var timestamp: Date?
    var type: String?
    var read: Bool?
}

struct NotificationResponse: Codable, Hashable {
    var notifications: [NotificationModel]?
}

