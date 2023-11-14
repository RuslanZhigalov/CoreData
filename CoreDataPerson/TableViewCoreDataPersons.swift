import UIKit
import CoreData
class TableViewController: UIViewController {
    var resultContrs: NSFetchedResultsController<NSFetchRequestResult>?
    let modelCore = ModelCoresData(containers: "Person")
    let identificator = "identificatorCell"
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private var button1: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Person Person", for: .normal)
        btn.subtitleLabel?.numberOfLines = .max
        btn.titleLabel?.numberOfLines = .max
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var navBarStack: UIStackView = {
        lazy var stack = UIStackView()
        stack.addArrangedSubview(button1)
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        start2()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.titleView = navBarStack
        start()
        resultContrs = modelCore.tableStr(keySort: "name", entityName: "Person")
        resultContrs?.delegate = self
        do{
            try resultContrs?.performFetch()
        }catch{
            print(error)
        }
        
        
    }
    func start2(){
        let modelCore1 = ModelCoresData(containers: "Person")
        let cor = modelCore1.startCoreData(entityForName: "Person")
        let manageObject = Person(entity: cor.0, insertInto: cor.1)
        manageObject.name = "Petya"
        manageObject.lastname = "Petrovich"
        manageObject.country = "USA"
        manageObject.birth = 3
        modelCore1.saveContext()
    }

    func start(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: identificator)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100
        ).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = resultContrs?.sections{
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificator, for: indexPath) as? TableViewCell
        let person = resultContrs?.object(at: indexPath) as? Person
        cell?.configure(modelCell: ModelsTwoString(personFirstName: person?.name ?? "No name", personSecondName: person?.lastname ?? "No lastname", personCountry: person?.country ?? "No country", personBirth: Int(person?.birth ?? 0)))
        return cell ?? UITableViewCell()
    }
    
    
}
