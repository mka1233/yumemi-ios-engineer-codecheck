//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabal: UILabel!
    
    var searchVC: SearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = searchVC.repositories[searchVC.index]
        
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stargazers_count)"
        watchersLabel.text = "\(repository.watchers_count)"
        forksLabel.text = "\(repository.forks_count)"
        issuesLabal.text = "\(repository.open_issues_count)"
        getImage()
    }
    
    func getImage(){
        
        let repository = searchVC.repositories[searchVC.index]
        
        titleLabel.text = repository.full_name
        let owner = repository.owner
        let imageURL = owner.avatar_url
        guard let imageURL = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, res, err) in
            if let error = err {
                print(error)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }.resume()
        
    }
    
}
