// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class RepositoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Repositories($login: String!) {
      rateLimit {
        __typename
        ...RateLimitFragment
      }
      organization(login: $login) {
        __typename
        login
        repositories(first: 70) {
          __typename
          nodes {
            __typename
            ...RepositoryFragment
          }
        }
      }
    }
    """

  public let operationName: String = "Repositories"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RateLimitFragment.fragmentDefinition)
    document.append("\n" + RepositoryFragment.fragmentDefinition)
    return document
  }

  public var login: String

  public init(login: String) {
    self.login = login
  }

  public var variables: GraphQLMap? {
    return ["login": login]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("rateLimit", type: .object(RateLimit.selections)),
        GraphQLField("organization", arguments: ["login": GraphQLVariable("login")], type: .object(Organization.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateLimit: RateLimit? = nil, organization: Organization? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }, "organization": organization.flatMap { (value: Organization) -> ResultMap in value.resultMap }])
    }

    /// The client's rate limit information.
    public var rateLimit: RateLimit? {
      get {
        return (resultMap["rateLimit"] as? ResultMap).flatMap { RateLimit(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "rateLimit")
      }
    }

    /// Lookup a organization by login.
    public var organization: Organization? {
      get {
        return (resultMap["organization"] as? ResultMap).flatMap { Organization(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "organization")
      }
    }

    public struct RateLimit: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RateLimit"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(RateLimitFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(limit: Int, cost: Int, remaining: Int, resetAt: String, used: Int) {
        self.init(unsafeResultMap: ["__typename": "RateLimit", "limit": limit, "cost": cost, "remaining": remaining, "resetAt": resetAt, "used": used])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var rateLimitFragment: RateLimitFragment {
          get {
            return RateLimitFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public struct Organization: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Organization"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("repositories", arguments: ["first": 70], type: .nonNull(.object(Repository.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, repositories: Repository) {
        self.init(unsafeResultMap: ["__typename": "Organization", "login": login, "repositories": repositories.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The organization's login name.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// A list of repositories that the user owns.
      public var repositories: Repository {
        get {
          return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositories")
        }
      }

      public struct Repository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(RepositoryFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositoryFragment: RepositoryFragment {
              get {
                return RepositoryFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct RepositoryFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RepositoryFragment on Repository {
      __typename
      id
      name
      pushedAt
      owner {
        __typename
        login
      }
      pullRequests(first: 0, states: OPEN) {
        __typename
        totalCount
      }
    }
    """

  public static let possibleTypes: [String] = ["Repository"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("pushedAt", type: .scalar(String.self)),
      GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
      GraphQLField("pullRequests", arguments: ["first": 0, "states": "OPEN"], type: .nonNull(.object(PullRequest.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, pushedAt: String? = nil, owner: Owner, pullRequests: PullRequest) {
    self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "pushedAt": pushedAt, "owner": owner.resultMap, "pullRequests": pullRequests.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// Identifies when the repository was last pushed to.
  public var pushedAt: String? {
    get {
      return resultMap["pushedAt"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "pushedAt")
    }
  }

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "owner")
    }
  }

  /// A list of pull requests that have been opened in the repository.
  public var pullRequests: PullRequest {
    get {
      return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Organization", "User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }

  public struct PullRequest: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["PullRequestConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}

public struct RateLimitFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RateLimitFragment on RateLimit {
      __typename
      limit
      cost
      remaining
      resetAt
      used
    }
    """

  public static let possibleTypes: [String] = ["RateLimit"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("limit", type: .nonNull(.scalar(Int.self))),
      GraphQLField("cost", type: .nonNull(.scalar(Int.self))),
      GraphQLField("remaining", type: .nonNull(.scalar(Int.self))),
      GraphQLField("resetAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("used", type: .nonNull(.scalar(Int.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(limit: Int, cost: Int, remaining: Int, resetAt: String, used: Int) {
    self.init(unsafeResultMap: ["__typename": "RateLimit", "limit": limit, "cost": cost, "remaining": remaining, "resetAt": resetAt, "used": used])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The maximum number of points the client is permitted to consume in a 60 minute window.
  public var limit: Int {
    get {
      return resultMap["limit"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "limit")
    }
  }

  /// The point cost for the current query counting against the rate limit.
  public var cost: Int {
    get {
      return resultMap["cost"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "cost")
    }
  }

  /// The number of points remaining in the current rate limit window.
  public var remaining: Int {
    get {
      return resultMap["remaining"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "remaining")
    }
  }

  /// The time at which the current rate limit window resets in UTC epoch seconds.
  public var resetAt: String {
    get {
      return resultMap["resetAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "resetAt")
    }
  }

  /// The number of points used in the current rate limit window.
  public var used: Int {
    get {
      return resultMap["used"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "used")
    }
  }
}
