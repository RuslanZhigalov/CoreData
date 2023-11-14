

import UIKit
import CoreData
class myTableViewController: UITableViewController {
    var resultContrs: NSFetchedResultsController<NSFetchRequestResult>?
    let modelCore = ModelCoresData(containers: "Person")
    let identificatorCeell = "dadasd"
    private var tableView1: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView1)
        start2Entity()
        tableView1.delegate = self
        tableView1.dataSource = self
        start()
        resultContrs = modelCore.tableStr(keySort: "name", entityName: "Person")
        
    }
    func start2Entity() {
        let modelCore1 = ModelCoresData(containers: "Person")
        let cor = modelCore1.startCoreData(entityForName: "Person")
        let manageObject = Person(entity: cor.0, insertInto: cor.1)
        manageObject.name = "Vasya"
        manageObject.lastname = "Petrovich"
        manageObject.country = "Russia"
        manageObject.birth = 3
        modelCore1.saveContext()
    }
    func start(){
        tableView1.register(TableViewCell.self, forCellReuseIdentifier: identificatorCeell)

        tableView1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100
        ).isActive = true
        tableView1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = resultContrs?.sections{
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificatorCeell, for: indexPath) as? TableViewCell
        let person = resultContrs?.object(at: indexPath) as? Person
        cell?.configure(modelCell: ModelsTwoString(personFirstName: person?.name ?? "No name", personSecondName: person?.lastname ?? "No lastname", personCountry: person?.country ?? "No country", personBirth: Int(person?.birth ?? 0)))
        return cell ?? UITableViewCell()
    }
    
}
