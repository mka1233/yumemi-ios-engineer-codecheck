//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [Repository] = []
    
    var task: URLSessionTask?
    var word: String?
    var urlString: String = ""
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let word = searchBar.text else { return }
        urlString = "https://api.github.com/search/repositories?q=\(word)"
        guard let url = URL(string: urlString) else { return }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            if let error = err {
                print(error)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(SearchRepositoryData.self, from: data)
                let items = decodeData.items
                self?.repositories = items
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        task?.resume()
        searchBar.resignFirstResponder()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail" {
            let detail = segue.destination as? ResultViewController
            detail?.searchVC = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.full_name
        cell.detailTextLabel?.text = repository.language ?? "unknown"
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}
