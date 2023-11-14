

import UIKit

class TableViewCell: UITableViewCell {
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var stackViewLabel: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.addArrangedSubview(textLabel1)
        stack.addArrangedSubview(textLabel2)
        stack.addArrangedSubview(textLabel3)
        stack.addArrangedSubview(textLabel4)
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackViewLabel)
        constraintStack()
    }
    func constraintStack(){
        stackViewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        stackViewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        stackViewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        textLabel1.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 2).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(modelCell: ModelsTwoString){
        textLabel1.text = modelCell.personFirstName
        textLabel2.text = modelCell.personSecondName
        textLabel3.text = modelCell.personCountry
        textLabel4.text = String(modelCell.personBirth)
        
    }
    
}

