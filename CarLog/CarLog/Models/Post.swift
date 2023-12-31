//
//  Post.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct Post: Codable {
    let id: String?
    let title: String?
    let content: String?
    let image: [URL?]
    let userEmail: String?
    let userName: String?
    let timeStamp: String?
    var emergency: [String:Bool]?
}
