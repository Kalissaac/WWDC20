import Foundation
import UIKit

public final class OnboardingGenerationViewController: OnboardingViewController {
  
  let generationLogTextView = UITextView()
  var userInfluencedArticles: [[Article]] = []
  
  public override func loadView() {
    super.loadView()
    self.headerLabel.text = "Generating your profile"
    self.footerLabel.text = "Hang tight, we're creating a ballot just for you!"
    self.nextButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    
    generationLogTextView.backgroundColor = .clear
    generationLogTextView.isEditable = false
    self.contentView.addSubview(generationLogTextView)
    
    generationLogTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      generationLogTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
      generationLogTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
      generationLogTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
      generationLogTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8)
    ])
    
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addLog("Starting generation")
    Thread.sleep(forTimeInterval: 0.5)
    let userRating = generateProfile(with: self.userProfile)
    print("User rating (final): \(userRating)")
    userInfluencedArticles = generateArticles(with: userRating, forDistrict: self.userProfile[2] as! [Int])
    addLog("Generation complete")
    self.footerLabel.text = ""
    self.nextButton.isHidden = false
  }
  
  func addLog(_ string: String) {
    var oldText = generationLogTextView.attributedText.string
    oldText += "\(string)\n"
    generationLogTextView.attributedText = NSAttributedString(string: oldText)
  }
  
  func generateProfile(with userData: [[Any]]) -> Int {
    var userRating: Int = 0
    
    addLog("Calculating preliminary position")
    
    var userSpectrum = userData[0][0] as! Int
    if userSpectrum > 50 {
      userRating += userSpectrum
    } else {
      userSpectrum = 100 - userSpectrum
      userRating += (userSpectrum / -1)
    }
    addLog("Done preliminary position")
    
    print("User rating (preliminary): \(userRating)")
    
    
    // choice is either 1, 2, 3, or 4
    // 1: agree, 2: disagree, 3: strng. agree, 4: strng. disagree
    
    addLog("Calculating agree/disagree choices")
    
    let userDecisions = userData[1] as! [Int]
    var userDecisionsCumulativeRating = 0
    
    for (i, choice) in userDecisions.enumerated() {
      
      var weightedChoice = 0
      switch choice {
        case 1, 3:
          weightedChoice = choice * 5
        case 2, 4:
          weightedChoice = choice - 1
          weightedChoice = weightedChoice * 5
          weightedChoice = weightedChoice / -1
        default: break
      }
      
      
      switch i {
        case 3:
          weightedChoice = weightedChoice / -1
        default: break
      }
      
      userDecisionsCumulativeRating += weightedChoice
    }
        
    userRating += userDecisionsCumulativeRating
    addLog("Done agree/disagree choices")
        
    return userRating
  }
  
  func generateArticles(with userRating: Int, forDistrict location: [Int]) -> [[Article]] {
    
    addLog("Retrieving your district")
    
    var userState = State.california
    var userCounty = County.losAngeles
    var userCity = City.losAngeles
    
    for (i, state) in State.allCases.enumerated() {
      if i == location[0] {
        userState = state
        break
      }
    }
    for (i, county) in County.allCases.enumerated() {
      if i == location[1] {
        userCounty = county
        break
      }
    }
    for (i, city) in City.allCases.enumerated() {
      if i == location[2] {
        userCity = city
        break
      }
    }
    
    addLog("Identifying ballots relevant to you")
    let articles = getElectionInformation(state: userState, county: userCounty, city: userCity)
    
    addLog("Calculating position on different measures and candidates")
    
    for jurisdiction in articles {
      for article in jurisdiction {
        if article.type == .measure {
          let articleRating = article.rating!
          
          if abs(articleRating - userRating) <= 75 {
            article.setPosition(position: "YES")
          } else {
            article.setPosition(position: "NO")
          }
          
        } else if article.type == .office {
          var closestCandidate: Candidate?
          
          for candidate in article.candidates! {
            print("\(candidate.name): \(abs(candidate.rating - userRating))")
            if closestCandidate == nil {
              closestCandidate = candidate
            } else if abs(candidate.rating - userRating) < abs(closestCandidate!.rating - userRating) {
              closestCandidate = candidate
            }
          }
          
          article.setPosition(position: closestCandidate!.name)
        }
      }
    }

    return articles
  }
  
  
  @objc func nextPage(_ sender: UIButton) {
    let nextViewController = BallotViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    nextViewController.data = userInfluencedArticles
    self.show(nextViewController, sender: self)
  }
}
