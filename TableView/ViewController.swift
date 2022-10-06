//
//  ViewController.swift
//  TableView
//
//  Created by Finn Christoffer Kurniawan on 02/10/22.
//

import UIKit

class ViewController: UIViewController {

    
    private let table : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private var models = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModels()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
    }
    
    private func setUpModels() {
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Food1", imageName: "food1"),
            CollectionTableCellModel(title: "Food2", imageName: "food2"),
            CollectionTableCellModel(title: "Food3", imageName: "food3"),
            CollectionTableCellModel(title: "Food4", imageName: "food4"),
            CollectionTableCellModel(title: "Food5", imageName: "food5"),
            CollectionTableCellModel(title: "Food6", imageName: "food6"),
            CollectionTableCellModel(title: "Food7", imageName: "food7"),
            CollectionTableCellModel(title: "Food8", imageName: "food8"),
            CollectionTableCellModel(title: "Food9", imageName: "food9"),
            CollectionTableCellModel(title: "Food10", imageName: "food10"),
            CollectionTableCellModel(title: "Food11", imageName: "food11"),
            CollectionTableCellModel(title: "Food12", imageName: "food12"),
            ],
            rows: 2))
        
        models.append(.list(models: [
            ListCellModel(title: "First Thing"),
            ListCellModel(title: "Second Thing"),
            ListCellModel(title: "Another Thing"),
            ListCellModel(title: "Other Thing"),
            ListCellModel(title: "More Thing"),
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}

extension ViewController :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case.list(let models): return models.count
        case.collectionView(_, _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case.list(let models):
            let model = models[indexPath.row]
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        case.collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_): return 50
        case .collectionView(_, let rows): return 180 * CGFloat(rows)
        }
    }
}

extension ViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("Selected \(model.title)")
    }
}
