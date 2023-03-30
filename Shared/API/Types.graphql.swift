// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The possible states of a pull request review.
public enum PullRequestReviewState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A review that has not yet been submitted.
  case pending
  /// An informational review.
  case commented
  /// A review allowing the pull request to merge.
  case approved
  /// A review blocking the pull request from merging.
  case changesRequested
  /// A review that has been dismissed.
  case dismissed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "PENDING": self = .pending
      case "COMMENTED": self = .commented
      case "APPROVED": self = .approved
      case "CHANGES_REQUESTED": self = .changesRequested
      case "DISMISSED": self = .dismissed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .pending: return "PENDING"
      case .commented: return "COMMENTED"
      case .approved: return "APPROVED"
      case .changesRequested: return "CHANGES_REQUESTED"
      case .dismissed: return "DISMISSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestReviewState, rhs: PullRequestReviewState) -> Bool {
    switch (lhs, rhs) {
      case (.pending, .pending): return true
      case (.commented, .commented): return true
      case (.approved, .approved): return true
      case (.changesRequested, .changesRequested): return true
      case (.dismissed, .dismissed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PullRequestReviewState] {
    return [
      .pending,
      .commented,
      .approved,
      .changesRequested,
      .dismissed,
    ]
  }
}
