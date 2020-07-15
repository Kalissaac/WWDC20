import Foundation
import UIKit

public final class BallotViewController: UIViewController {
  
  let superView = UIView()
  let headerView = UIView()
  let headerLabel = UILabel()
  let contentView = UIView()
  let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
  let cardViewController = BallotCardViewController()
  let tableHeaders = ["Measures", "Offices"]
  public var data: [[Article]] = []
  let footerView = UIView()
  let nextButton = UIButton(type: .roundedRect)
  
  public override func loadView() {
    super.loadView()
    
    contentView.backgroundColor = .white
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 12
    
    superView.addSubview(headerView)
    superView.addSubview(contentView)
    superView.addSubview(footerView)
    
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 8),
      headerView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      headerView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      headerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
      headerView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.10)
    ])
    
    headerLabel.text = "Your Ballot"
    headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
    headerView.addSubview(headerLabel)
    
    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
      headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -4),
      headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12)
    ])
    
    let subHeaderLabel = UILabel()
    subHeaderLabel.text = "Presidential Primaries – March 3, 2020"
    subHeaderLabel.font = UIFont.systemFont(ofSize: 16)
    headerView.addSubview(subHeaderLabel)
    
    subHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subHeaderLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
      subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
      subHeaderLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12)
    ])
    
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
      contentView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      contentView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      contentView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -8)
    ])
    
    
    tableView.rowHeight = 50
    tableView.delegate = self
    tableView.dataSource = self
    contentView.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    
    footerView.backgroundColor = Colors.purple
    footerView.layer.masksToBounds = true
    footerView.layer.cornerRadius = 12
    
    footerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      footerView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
      footerView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      footerView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -8),
      footerView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      footerView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.1)
    ])
    
    nextButton.setTitle("DONE VOTING", for: .normal)
    nextButton.setTitleColor(.white, for: .normal)
    nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    nextButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    footerView.addSubview(nextButton)
    
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nextButton.topAnchor.constraint(equalTo: footerView.topAnchor),
      nextButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
      nextButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
      nextButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor)
    ])
    
    self.view = superView
  }
  
  func introduceCardView(with data: Article) {
    let cardView = cardViewController.view!
    
    if !cardView.isDescendant(of: superView) { // if card view has not already been added to view
      cardViewController.delegate = self
      superView.addSubview(cardView)
      cardView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        cardView.topAnchor.constraint(equalTo: superView.topAnchor),
        cardView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
        cardView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
        cardView.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
      ])
    }
    cardView.isUserInteractionEnabled = true
    cardViewController.introduceCardView(with: data)
  }
  
  @objc func nextPage(_ sender: UIButton) {
    let nextViewController = FinishViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    self.show(nextViewController, sender: self)
  }
}

extension BallotViewController: UITableViewDataSource, UITableViewDelegate {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tableHeaders[section]
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
    cell.textLabel?.text = data[indexPath.section][indexPath.row].shortName
    cell.detailTextLabel?.text = data[indexPath.section][indexPath.row].currentPosition
    switch data[indexPath.section][indexPath.row].currentPosition {
      case "YES":
        cell.detailTextLabel?.textColor = .systemGreen
      case "NO":
        cell.detailTextLabel?.textColor = .systemRed
      default:
        cell.detailTextLabel?.textColor = .systemBlue
    }
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    introduceCardView(with: data[indexPath.section][indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension BallotViewController: BallotCardDelegate {
  
  func reloadTable(at indexPath: IndexPath) {
    tableView.reloadData()
  }
  
}

