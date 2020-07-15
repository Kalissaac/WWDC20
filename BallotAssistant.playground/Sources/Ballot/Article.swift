import Foundation

public class Article {
  public var shortName: String
  public var name: String
  public var type: ArticleTypes
  public var jurisdiction: ArticleJurisdictions
  public var currentPosition: String?
  
  public var rating: Int?
  public var arguments: [[String]]?
  public var positions: [String]?
  
  public var candidates: [Candidate]?
  
  init(shortName: String, name: String, type: ArticleTypes, jurisdiction: ArticleJurisdictions, currentPosition: String?, rating: Int?, arguments: [[String]]?, positions: [String]?) {
    self.shortName = shortName
    self.name = name
    self.type = type
    self.jurisdiction = jurisdiction
    self.currentPosition = currentPosition
    self.rating = rating
    self.arguments = arguments
    self.positions = positions
  }
  
  init(shortName: String, name: String, type: ArticleTypes, jurisdiction: ArticleJurisdictions, currentPosition: String?,  candidates: [Candidate]?) {
    self.shortName = shortName
    self.name = name
    self.type = type
    self.jurisdiction = jurisdiction
    self.currentPosition = currentPosition
    self.candidates = candidates
  }
  
  public func setPosition(position: String) {
    self.currentPosition = position
  }
}

public enum ArticleTypes: String, CustomStringConvertible {
  case proposition, measure, office
  public var description: String {
    return self.rawValue.firstCapitalized
  }
}

public enum ArticleJurisdictions: String, CustomStringConvertible {
  case federal, state, county, city
  public var description: String {
    return self.rawValue.firstCapitalized
  }
}

public enum ArticleParties: String, CustomStringConvertible {
  case democratic, republican, independent, libertarian, green
  public var description: String {
    return self.rawValue.firstCapitalized
  }
}

public struct Candidate {
  public var name: String
  public var rating: Int
  public var party: ArticleParties
}
