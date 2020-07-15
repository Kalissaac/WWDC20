import Foundation

public enum State: CaseIterable, CustomStringConvertible {
  case california
  
  public var description: String {
    switch self {
      case .california:
        return "California"
    }
  }
}

public enum County: CaseIterable, CustomStringConvertible {
  case losAngeles
  
  public var description: String {
    switch self {
      case .losAngeles:
        return "Los Angeles County"
    }
  }
}

public enum City: CaseIterable, CustomStringConvertible {
  case losAngeles
  
  public var description: String {
    switch self {
      case .losAngeles:
        return "Los Angeles City"
    }
  }
}


let californiaArticles = [
  [
  Article(shortName: "Proposition 13", name: "AUTHORIZES BONDS FOR FACILITY REPAIR, CONSTRUCTION, AND MODERNIZATION AT PUBLIC PRESCHOOLS, K–12 SCHOOLS, COMMUNITY COLLEGES, AND UNIVERSITIES. LEGISLATIVE STATUTE.", type: .measure, jurisdiction: .state, currentPosition: nil, rating: 126, arguments: [["YES", "A YES vote on this measure means: The state could sell $15 billion in general obligation bonds to fund school, community college, and university facility projects. In addition, school districts and community college districts would be authorized to issue more local bonds, and school districts would have new limits on their ability to levy developer fees."], ["NO", "A NO vote on this measure means: The state could not sell $15 billion in general obligation bonds to fund education facility projects. The state also would not make changes to school districts’ and community college districts’ existing local borrowing limits or the existing rules for school districts to levy developer fees."], ["PRO", "YES on PROP. 13 funds essential repairs to make California public schools safer and healthier. Removal of toxic mold and asbestos from aging classrooms. More school nurse facilities. Cleaner drinking water. Fire and earthquake safety upgrades. Strong taxpayer controls. Endorsed by frefghters, doctors, nurses, and teachers. For California’s children. YesonProp13.com"], ["CON", "This measure authorizes $15 billion in borrowing, costing taxpayers $27 billion including interest, to build and repair schools. Borrowing is nearly twice as expensive as paying for school construction from the regular budget, which has a huge $21 billion surplus. This is just more government waste. Vote no."]], positions: ["YES", "NO"])
  ],
  [
    Article(shortName: "Presidential Primaries", name: "Presidential Primaries", type: .office, jurisdiction: .county, currentPosition: nil, candidates: [Candidate(name: "(D) SANDERS", rating: 160, party: .democratic), Candidate(name: "(D) BIDEN", rating: 50, party: .democratic), Candidate(name: "(R) TRUMP", rating: -150, party: .republican)])
  ]
]

let losAngelesArticles = [
  [
    Article(shortName: "Measure FD", name: "LOS ANGELES COUNTY FIRE DISTRICT 911 FIREFIGHTER/PARAMEDIC EMERGENCY RESPONSE MEASURE", type: .measure, jurisdiction: .county, currentPosition: nil, rating: 92, arguments: [["No data available", "Unfortunately, no data is available for this item on the ballot."]], positions: ["YES", "NO"]),
    Article(shortName: "Measure R", name: "LOS ANGELES COUNTY SHERIFF CIVILIAN OVERSIGHT COMMISSION ORDINANCE", type: .measure, jurisdiction: .county, currentPosition: nil, rating: 74, arguments: [["No data available", "Unfortunately, no data is available for this item on the ballot."]], positions: ["YES", "NO"])
  ],
  []
]

let losAngelesCityArticles = [
  [],
  [
    Article(shortName: "District 2", name: "City Council - District 2", type: .office, jurisdiction: .city, currentPosition: nil, candidates: [Candidate(name: "(I) KREKORIAN", rating: 38, party: .independent), Candidate(name: "(I) MELENDEZ", rating: 14, party: .independent), Candidate(name: "(I) JONES", rating: -8, party: .independent)])
  ]
]

public func getElectionInformation(state: State, county: County, city: City) -> [[Article]] {
  var articles: [[Article]] = [[], []] // Sorted by type: measures and offices
  
  articles[0].append(contentsOf: californiaArticles[0])
  articles[1].append(contentsOf: californiaArticles[1])
  
  articles[0].append(contentsOf: losAngelesArticles[0])
  articles[1].append(contentsOf: losAngelesArticles[1])
  
  articles[0].append(contentsOf: losAngelesCityArticles[0])
  articles[1].append(contentsOf: losAngelesCityArticles[1])
  
  return articles
}
