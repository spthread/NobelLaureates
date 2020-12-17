//
//  FindNobelLaureatesViewController+TableView.swift
//  NobelLaureates
//
//  Created by Surendra Patel on 17/12/20.
//

import UIKit

extension FindNobelLaureatesViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FindNobelLaureatesViewCell") as? FindNobelLaureatesViewCell else {
            fatalError()
        }
        let laureatesVM = models[indexPath.row]
        cell.name.text = laureatesVM.fullName
        cell.place.text = laureatesVM.place
        cell.year.text = laureatesVM.year
        cell.location.text = laureatesVM.location
        cell.customView.layer.cornerRadius = 10.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
