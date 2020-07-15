import Foundation
import UIKit

public final class OnboardingDecisionsViewController: OnboardingViewController {
  
  var tableView = UITableView()
  let cells = [["Abortion", "Abortion should be legalized for everyone."], ["Gun Control", "There needs to be stricter gun control."], ["Climate Change", "We must take steps to combat and slow the effects of climate change."], ["Immigration", "There should be more crackdowns on illegal immigration."], ["LGBTQ+ Rights", "We need to ensure more rights and freedoms for all LGBTQ+ people."]]
  var selectedPreference = [0, 0, 0, 0, 0]
  
  public override func loadView() {
    super.loadView()
    
    self.headerLabel.text = "Do you agree or disagree?"
    self.nextButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    self.footerLabel.text = "Answer questions to continue!"
    
    tableView.rowHeight = 150
    tableView.register(OnboardingDecisionsCell.self, forCellReuseIdentifier: "decisionsCell")
    tableView.delegate = self
    tableView.dataSource = self
    self.contentView.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
      ])
  }
  
  @objc func nextPage(_ sender: UIButton) {
    var userProfile = self.userProfile

    userProfile.append(selectedPreference) // Add data collected in this view controller
    
    let nextViewController = OnboardingLocationViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    nextViewController.userProfile = userProfile
    self.show(nextViewController, sender: self)
  }
}

extension OnboardingDecisionsViewController: UITableViewDataSource, UITableViewDelegate {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cells.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "decisionsCell") as! OnboardingDecisionsCell
    
    cell.topicLabel.text = cells[indexPath.row][0]
    cell.statementLabel.text = cells[indexPath.row][1]
    
    cell.decisionsContainer.isUserInteractionEnabled = true
    cell.selectionStyle = .none
    
    cell.agreeButton.addTarget(self, action: #selector(decisionSelect(_:)), for: .touchUpInside)
    cell.agreeButton.tag = 100 + indexPath.row
    cell.agreeButton.isSelected = false
    
    cell.disagreeButton.addTarget(self, action: #selector(decisionSelect(_:)), for: .touchUpInside)
    cell.disagreeButton.tag = 200 + indexPath.row
    cell.disagreeButton.isSelected = false
    
    cell.stronglyAgreeButton.addTarget(self, action: #selector(decisionSelect(_:)), for: .touchUpInside)
    cell.stronglyAgreeButton.tag = 300 + indexPath.row
    cell.stronglyAgreeButton.isSelected = false
    
    cell.stronglyDisagreeButton.addTarget(self, action: #selector(decisionSelect(_:)), for: .touchUpInside)
    cell.stronglyDisagreeButton.tag = 400 + indexPath.row
    cell.stronglyDisagreeButton.isSelected = false
        
    switch selectedPreference[indexPath.row] {
      case 1:
        cell.agreeButton.isSelected = true
      case 2:
        cell.disagreeButton.isSelected = true
      case 3:
        cell.stronglyAgreeButton.isSelected = true
      case 4:
        cell.stronglyDisagreeButton.isSelected = true
      default: break
    }
    
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  @objc func decisionSelect(_ sender: UIButton) {
    
    let tag = String(sender.tag)
    let selectedButton = Int(tag.prefix(1))
    let selectedRow = Int(tag.suffix(2))
    
    selectedPreference[selectedRow!] = selectedButton!
    
    if selectedPreference.contains(0) == false {
      nextButton.isHidden = false
      self.footerLabel.text = ""
    }
    
    for view in sender.superview!.subviews {
      if let button = view as? UIButton {
        button.isSelected = false
      }      
    }
    sender.isSelected = true
  }
  
}


public final class OnboardingDecisionsCell: UITableViewCell {
  
  let topicLabel = UILabel()
  let statementLabel = UILabel()
  let decisionsContainer = UIView()
  let agreeButton = UIButton(type: .roundedRect)
  let stronglyAgreeButton = UIButton(type: .roundedRect)
  let disagreeButton = UIButton(type: .roundedRect)
  let stronglyDisagreeButton = UIButton(type: .roundedRect)
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(topicLabel)
    addSubview(statementLabel)
    decisionsContainer.addSubview(agreeButton)
    decisionsContainer.addSubview(stronglyAgreeButton)
    decisionsContainer.addSubview(disagreeButton)
    decisionsContainer.addSubview(stronglyDisagreeButton)
    
    setupTopicLabel()
    setupStatementLabel()
    setupDecisionButtons()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupTopicLabel() {
    topicLabel.font = UIFont.boldSystemFont(ofSize: 16)
    
    topicLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topicLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      topicLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      topicLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
      ])
  }
  
  func setupStatementLabel() {
    statementLabel.numberOfLines = 2
    
    statementLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      statementLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 2),
      statementLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
      statementLabel.trailingAnchor.constraint(equalTo: topicLabel.trailingAnchor)
    ])
  }
  
  func setupDecisionButtons() {
    decisionsContainer.isUserInteractionEnabled = true
    addSubview(decisionsContainer)
    
    decisionsContainer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      decisionsContainer.topAnchor.constraint(equalTo: statementLabel.bottomAnchor, constant: 8),
      decisionsContainer.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
      decisionsContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      decisionsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    ])
    
    
    setupAgreeButtons()
    setupDisagreeButtons()
  }
  
  func setupAgreeButtons() {
    agreeButton.setTitle("Agree", for: .normal)
    agreeButton.setTitleColor(.white, for: .normal)
    agreeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    agreeButton.backgroundColor = Colors.green
    agreeButton.layer.cornerRadius = 8
    agreeButton.tintColor = .clear
    
    var fullString = NSMutableAttributedString(attachment: NSTextAttachment(image: (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.white))!))
    fullString.append(NSAttributedString(string: " Agree"))
    agreeButton.setAttributedTitle(fullString, for: .selected)
    
    
    stronglyAgreeButton.setTitle("Strongly Agree", for: .normal)
    stronglyAgreeButton.setTitleColor(.white, for: .normal)
    stronglyAgreeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    stronglyAgreeButton.backgroundColor = Colors.green
    stronglyAgreeButton.layer.cornerRadius = 8
    stronglyAgreeButton.tintColor = .clear
    
    fullString = NSMutableAttributedString(attachment: NSTextAttachment(image: (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.white))!))
    fullString.append(NSAttributedString(string: " Strongly Agree"))
    stronglyAgreeButton.setAttributedTitle(fullString, for: .selected)
    
    
    agreeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      agreeButton.topAnchor.constraint(equalTo: decisionsContainer.topAnchor),
      agreeButton.leadingAnchor.constraint(equalTo: decisionsContainer.leadingAnchor, constant: 4),
      agreeButton.widthAnchor.constraint(equalTo: decisionsContainer.widthAnchor, multiplier: 0.49),
      agreeButton.heightAnchor.constraint(equalTo: decisionsContainer.heightAnchor, multiplier: 0.48)
    ])
    
    stronglyAgreeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stronglyAgreeButton.topAnchor.constraint(equalTo: decisionsContainer.topAnchor),
      stronglyAgreeButton.trailingAnchor.constraint(equalTo: decisionsContainer.trailingAnchor),
      stronglyAgreeButton.widthAnchor.constraint(equalTo: decisionsContainer.widthAnchor, multiplier: 0.49),
      stronglyAgreeButton.heightAnchor.constraint(equalTo: decisionsContainer.heightAnchor, multiplier: 0.48)
    ])
  }
  
  func setupDisagreeButtons() {
    disagreeButton.setTitle("Disagree", for: .normal)
    disagreeButton.setTitleColor(.white, for: .normal)
    disagreeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    disagreeButton.backgroundColor = Colors.red
    disagreeButton.layer.cornerRadius = 8
    disagreeButton.tintColor = .clear
    
    var fullString = NSMutableAttributedString(attachment: NSTextAttachment(image: (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.white))!))
    fullString.append(NSAttributedString(string: " Disagree"))
    disagreeButton.setAttributedTitle(fullString, for: .selected)
        
    stronglyDisagreeButton.setTitle("Strongly Disagree", for: .normal)
    stronglyDisagreeButton.setTitleColor(.white, for: .normal)
    stronglyDisagreeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    stronglyDisagreeButton.backgroundColor = Colors.red
    stronglyDisagreeButton.layer.cornerRadius = 8
    stronglyDisagreeButton.tintColor = .clear
    
    fullString = NSMutableAttributedString(attachment: NSTextAttachment(image: (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.white))!))
    fullString.append(NSAttributedString(string: " Strongly Disagree"))
    stronglyDisagreeButton.setAttributedTitle(fullString, for: .selected)
    
    disagreeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      disagreeButton.bottomAnchor.constraint(equalTo: decisionsContainer.bottomAnchor),
      disagreeButton.leadingAnchor.constraint(equalTo: decisionsContainer.leadingAnchor, constant: 4),
      disagreeButton.widthAnchor.constraint(equalTo: decisionsContainer.widthAnchor, multiplier: 0.49),
      disagreeButton.heightAnchor.constraint(equalTo: decisionsContainer.heightAnchor, multiplier: 0.48)
    ])
    
    stronglyDisagreeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stronglyDisagreeButton.bottomAnchor.constraint(equalTo: decisionsContainer.bottomAnchor),
      stronglyDisagreeButton.trailingAnchor.constraint(equalTo: decisionsContainer.trailingAnchor),
      stronglyDisagreeButton.widthAnchor.constraint(equalTo: decisionsContainer.widthAnchor, multiplier: 0.49),
      stronglyAgreeButton.heightAnchor.constraint(equalTo: decisionsContainer.heightAnchor, multiplier: 0.48)
    ])
  }
}
