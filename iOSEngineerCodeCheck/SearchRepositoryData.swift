//
//  SearchRepositoryData.swift
//  iOSEngineerCodeCheck
//
//  Created by kazukimorikami on 2022/10/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchRepositoryData: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    
    let full_name: String
    let language: String?
    let stargazers_count: Int
    let watchers_count: Int
    let forks_count: Int
    let open_issues_count: Int
    
    let owner: Owner
    
}

struct Owner: Codable {
    let avatar_url: String
}
