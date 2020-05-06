//
//  ViewController.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModelProtocol = ViewModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constant.mainTableViewCellIdentifier)
        let updateCallBack: ()->Void = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.registerUpdate(updateCallBack: updateCallBack)
        viewModel.loadData()
        setupTableView()
    }
    
    func setupTableView() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.getConfigure(viewModel: viewModel.getViewModelResult(index: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainTableViewCellIdentifier, for: indexPath) as! TableViewCell
        cell.getConfigure(viewModel: viewModel.getViewModelResult(index: indexPath.row))
        return cell
    }
}
