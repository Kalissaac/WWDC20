import Foundation
import UIKit

protocol BallotCardDelegate {
  
  func reloadTable(at indexPath: IndexPath)
  
}

public final class BallotCardViewController: UIViewController {
  
  let superView = UIView()
  let cardView = UIView()
  public var cardViewVerticalPositionConstraint: NSLayoutConstraint!
  public let cardViewBackground = UIView()
  let titleLabel = UILabel()
  let voteLabel = UILabel()
  let icon = UIView()
  let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
  let tableHeaders = ["Change Vote", "Info", "Arguments"]
  let tableCells = [["Change Vote"], ["Name", "Type", "Jurisdiction"]]
  var articleData: Article?
  var senderTableView: UITableView?
  var delegate: BallotCardDelegate?
  
  public override func loadView() {
    super.loadView()
    
    let cardViewDismissGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissCardView))
    cardViewDismissGesture.direction = .down
    cardView.addGestureRecognizer(cardViewDismissGesture)
    cardView.backgroundColor = .white
    cardView.layer.masksToBounds = true
    cardView.layer.cornerRadius = 12
    cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    superView.addSubview(cardView)
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cardView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      cardView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      cardView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.666)
    ])
    cardViewVerticalPositionConstraint = cardView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 512)
    cardViewVerticalPositionConstraint.isActive = true
    
    cardViewBackground.backgroundColor = .darkGray
    cardViewBackground.alpha = 0
    cardViewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissCardView)))
    superView.addSubview(cardViewBackground)
    
    cardViewBackground.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cardViewBackground.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      cardViewBackground.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      cardViewBackground.topAnchor.constraint(equalTo: superView.topAnchor),
      cardViewBackground.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
    ])
    
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    titleLabel.numberOfLines = 2
    cardView.addSubview(titleLabel)
    
    voteLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .medium)
    voteLabel.numberOfLines = 2
    voteLabel.textAlignment = .right
    voteLabel.textColor = .systemGreen
    cardView.addSubview(voteLabel)
    
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: voteLabel.leadingAnchor)
    ])
    
    voteLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      voteLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      voteLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.3),
      voteLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
    ])
    
    
    tableView.delegate = self
    tableView.dataSource = self
    cardView.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
    ])
    
    self.view = superView
  }
  
  public func introduceCardView(with data: Article) {
    superView.bringSubviewToFront(cardView)
    articleData = data
    titleLabel.text = articleData!.shortName
    
    if let position = articleData!.currentPosition {
      voteLabel.text = "Vote \(position)"
      switch position {
        case "YES":
          voteLabel.textColor = .systemGreen
        case "NO":
          voteLabel.textColor = .systemRed
        default:
          voteLabel.textColor = .systemBlue
      }
    } else {
      voteLabel.text = ""
    }
    tableView.reloadData()
    superView.layoutIfNeeded()
    UIView.animate(withDuration: 0.333, animations: {
      self.cardViewBackground.alpha = 0.5
      self.cardViewVerticalPositionConstraint.constant = 0
      self.superView.layoutIfNeeded()
    })
  }
  
  @objc func dismissCardView() {
    UIView.animate(withDuration: 0.333, animations: {
      self.cardViewBackground.alpha = 0
      self.cardViewVerticalPositionConstraint.constant = 512
      self.superView.isUserInteractionEnabled = false
      self.superView.layoutIfNeeded()
    })
  }
}

extension BallotCardViewController: UITableViewDataSource, UITableViewDelegate {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return tableHeaders.count
  }
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tableHeaders[section]
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 2 {
      if articleData?.type == .measure && (articleData?.arguments?.count ?? 0) > 0 {
        return articleData?.arguments!.count ?? 1
      } else {
        return 1
      }
    } else {
      return tableCells[section].count
    }
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
    if articleData == nil {
      return cell
    }
    if indexPath.section == 0 {
      cell.textLabel?.text = tableCells[indexPath.section][indexPath.row]
      cell.accessoryType = .disclosureIndicator
    } else if indexPath.section == 1 {
      cell.textLabel?.text = tableCells[indexPath.section][indexPath.row]
      switch indexPath.row {
        case 0:
          cell.detailTextLabel?.text = articleData!.name
        case 1:
          cell.detailTextLabel?.text = articleData!.type.description
        case 2:
          cell.detailTextLabel?.text = articleData!.jurisdiction.description
        default:
          cell.detailTextLabel?.text = ""
      }
    } else if indexPath.section == 2 {
      if let argument = articleData?.arguments?[indexPath.row] {
        if argument.count >= 2 {
          cell.textLabel?.text = argument[0]
          cell.detailTextLabel?.text = argument[1]
        }
      } else {
        cell.textLabel?.text = "No data available"
      }
      cell.accessoryType = .disclosureIndicator
    }
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
      case 0:
        let alert = UIAlertController(title: "How do you want to vote?", message: "These are all of your available positions/candidates.", preferredStyle: .actionSheet)
        if articleData!.type == .measure {
          for position in articleData!.positions! {
            alert.addAction(UIAlertAction(title: position, style: .default, handler: { action in
              self.articleData?.setPosition(position: position)
              self.voteLabel.text = "Vote \(position)"
              switch position {
                case "YES":
                  self.voteLabel.textColor = .systemGreen
                case "NO":
                  self.voteLabel.textColor = .systemRed
                default:
                  self.voteLabel.textColor = .systemBlue
              }
              self.delegate!.reloadTable(at: indexPath)
            }))
          }
        } else if articleData!.type == .office {
          for candidate in articleData!.candidates! {
            alert.addAction(UIAlertAction(title: candidate.name, style: .default, handler: { action in
              self.articleData?.setPosition(position: candidate.name)
              self.voteLabel.text = "Vote \(candidate.name)"
              self.voteLabel.textColor = .systemBlue
            }))
          }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
      
      case 1:
        if indexPath.row == 0 {
          let alert = UIAlertController(title: "Full Title", message: articleData!.name, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
          self.present(alert, animated: true)
      }
      
      case 2:
        if articleData!.type == .measure && (articleData?.arguments?.count ?? 0) > 0 {
          let argument = articleData!.arguments![indexPath.row]
          let alert = UIAlertController(title: argument[0], message: argument[1], preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        } else {
          let alert = UIAlertController(title: "No data available", message: "Unfortunately, no data is available for this item on the ballot.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
          self.present(alert, animated: true)
      }
      
      default: break
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
