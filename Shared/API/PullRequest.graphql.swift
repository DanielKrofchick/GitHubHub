// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PullRequestsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query PullRequests($owner: String!, $name: String!) {
      rateLimit {
        __typename
        ...RateLimitFragment
      }
      repository(owner: $owner, name: $name) {
        __typename
        name
        pullRequests(first: 100, states: OPEN) {
          __typename
          totalCount
          nodes {
            __typename
            ...PullRequestFragment
          }
        }
      }
    }
    """

  public let operationName: String = "PullRequests"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RateLimitFragment.fragmentDefinition)
    document.append("\n" + PullRequestFragment.fragmentDefinition)
    document.append("\n" + ActorFragment.fragmentDefinition)
    document.append("\n" + PullRequestReviewFragment.fragmentDefinition)
    document.append("\n" + ReviewRequestFragment.fragmentDefinition)
    return document
  }

  public var owner: String
  public var name: String

  public init(owner: String, name: String) {
    self.owner = owner
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("rateLimit", type: .object(RateLimit.selections)),
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateLimit: RateLimit? = nil, repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }, "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
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

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
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

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequests", arguments: ["first": 100, "states": "OPEN"], type: .nonNull(.object(PullRequest.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, pullRequests: PullRequest) {
        self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "pullRequests": pullRequests.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      /// A list of pull requests that have been opened in the repository.
      public var pullRequests: PullRequest {
        get {
          return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
        }
      }

      public struct PullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequestConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
          public static let possibleTypes: [String] = ["PullRequest"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PullRequestFragment.self),
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

            public var pullRequestFragment: PullRequestFragment {
              get {
                return PullRequestFragment(unsafeResultMap: resultMap)
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

public final class ReviewersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Reviewers($owner: String!, $name: String!, $number: Int!) {
      rateLimit {
        __typename
        ...RateLimitFragment
      }
      repository(owner: $owner, name: $name) {
        __typename
        pullRequest(number: $number) {
          __typename
          ...PullRequestFragment
        }
      }
    }
    """

  public let operationName: String = "Reviewers"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RateLimitFragment.fragmentDefinition)
    document.append("\n" + PullRequestFragment.fragmentDefinition)
    document.append("\n" + ActorFragment.fragmentDefinition)
    document.append("\n" + PullRequestReviewFragment.fragmentDefinition)
    document.append("\n" + ReviewRequestFragment.fragmentDefinition)
    return document
  }

  public var owner: String
  public var name: String
  public var number: Int

  public init(owner: String, name: String, number: Int) {
    self.owner = owner
    self.name = name
    self.number = number
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "number": number]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("rateLimit", type: .object(RateLimit.selections)),
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateLimit: RateLimit? = nil, repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }, "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
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

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
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

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequest", arguments: ["number": GraphQLVariable("number")], type: .object(PullRequest.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(pullRequest: PullRequest? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "pullRequest": pullRequest.flatMap { (value: PullRequest) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Returns a single pull request from the current repository by number.
      public var pullRequest: PullRequest? {
        get {
          return (resultMap["pullRequest"] as? ResultMap).flatMap { PullRequest(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "pullRequest")
        }
      }

      public struct PullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequest"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(PullRequestFragment.self),
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

          public var pullRequestFragment: PullRequestFragment {
            get {
              return PullRequestFragment(unsafeResultMap: resultMap)
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

public final class UserPullRequestsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query UserPullRequests($login: String!) {
      rateLimit {
        __typename
        ...RateLimitFragment
      }
      user(login: $login) {
        __typename
        login
        pullRequests(first: 20, states: [OPEN]) {
          __typename
          totalCount
          nodes {
            __typename
            ...PullRequestFragment
          }
        }
      }
    }
    """

  public let operationName: String = "UserPullRequests"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RateLimitFragment.fragmentDefinition)
    document.append("\n" + PullRequestFragment.fragmentDefinition)
    document.append("\n" + ActorFragment.fragmentDefinition)
    document.append("\n" + PullRequestReviewFragment.fragmentDefinition)
    document.append("\n" + ReviewRequestFragment.fragmentDefinition)
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
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateLimit: RateLimit? = nil, user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
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

    /// Lookup a user by login.
    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
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

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequests", arguments: ["first": 20, "states": ["OPEN"]], type: .nonNull(.object(PullRequest.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(login: String, pullRequests: PullRequest) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "pullRequests": pullRequests.resultMap])
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

      /// A list of pull requests associated with this user.
      public var pullRequests: PullRequest {
        get {
          return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
        }
      }

      public struct PullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequestConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
          public static let possibleTypes: [String] = ["PullRequest"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PullRequestFragment.self),
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

            public var pullRequestFragment: PullRequestFragment {
              get {
                return PullRequestFragment(unsafeResultMap: resultMap)
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

public final class UserPullRequestsCountQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query UserPullRequestsCount($login: String!) {
      rateLimit {
        __typename
        ...RateLimitFragment
      }
      user(login: $login) {
        __typename
        pullRequests(first: 0, states: [OPEN]) {
          __typename
          totalCount
        }
      }
    }
    """

  public let operationName: String = "UserPullRequestsCount"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RateLimitFragment.fragmentDefinition)
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
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateLimit: RateLimit? = nil, user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
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

    /// Lookup a user by login.
    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
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

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequests", arguments: ["first": 0, "states": ["OPEN"]], type: .nonNull(.object(PullRequest.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(pullRequests: PullRequest) {
        self.init(unsafeResultMap: ["__typename": "User", "pullRequests": pullRequests.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of pull requests associated with this user.
      public var pullRequests: PullRequest {
        get {
          return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
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
  }
}

public struct PullRequestFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PullRequestFragment on PullRequest {
      __typename
      id
      number
      title
      isDraft
      createdAt
      author {
        __typename
        ...ActorFragment
      }
      repository {
        __typename
        name
        owner {
          __typename
          login
        }
      }
      latestReviews(first: 20) {
        __typename
        totalCount
        nodes {
          __typename
          ...PullRequestReviewFragment
        }
      }
      reviewRequests(first: 20) {
        __typename
        totalCount
        nodes {
          __typename
          ...ReviewRequestFragment
        }
      }
    }
    """

  public static let possibleTypes: [String] = ["PullRequest"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("isDraft", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("author", type: .object(Author.selections)),
      GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
      GraphQLField("latestReviews", arguments: ["first": 20], type: .object(LatestReview.selections)),
      GraphQLField("reviewRequests", arguments: ["first": 20], type: .object(ReviewRequest.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, number: Int, title: String, isDraft: Bool, createdAt: String, author: Author? = nil, repository: Repository, latestReviews: LatestReview? = nil, reviewRequests: ReviewRequest? = nil) {
    self.init(unsafeResultMap: ["__typename": "PullRequest", "id": id, "number": number, "title": title, "isDraft": isDraft, "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "repository": repository.resultMap, "latestReviews": latestReviews.flatMap { (value: LatestReview) -> ResultMap in value.resultMap }, "reviewRequests": reviewRequests.flatMap { (value: ReviewRequest) -> ResultMap in value.resultMap }])
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

  /// Identifies the pull request number.
  public var number: Int {
    get {
      return resultMap["number"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the pull request title.
  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  /// Identifies if the pull request is a draft.
  public var isDraft: Bool {
    get {
      return resultMap["isDraft"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isDraft")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// The repository associated with this node.
  public var repository: Repository {
    get {
      return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "repository")
    }
  }

  /// A list of latest reviews per user associated with the pull request that are not also pending review.
  public var latestReviews: LatestReview? {
    get {
      return (resultMap["latestReviews"] as? ResultMap).flatMap { LatestReview(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "latestReviews")
    }
  }

  /// A list of review requests associated with the pull request.
  public var reviewRequests: ReviewRequest? {
    get {
      return (resultMap["reviewRequests"] as? ResultMap).flatMap { ReviewRequest(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "reviewRequests")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ActorFragment.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeBot(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeMannequin(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeUser(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
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

      public var actorFragment: ActorFragment {
        get {
          return ActorFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Repository: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Repository"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, owner: Owner) {
      self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

    /// The User owner of the repository.
    public var owner: Owner {
      get {
        return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "owner")
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
  }

  public struct LatestReview: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["PullRequestReviewConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int, nodes: [Node?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "PullRequestReviewConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
      public static let possibleTypes: [String] = ["PullRequestReview"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PullRequestReviewFragment.self),
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

        public var pullRequestReviewFragment: PullRequestReviewFragment {
          get {
            return PullRequestReviewFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }

  public struct ReviewRequest: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ReviewRequestConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int, nodes: [Node?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "ReviewRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
      public static let possibleTypes: [String] = ["ReviewRequest"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ReviewRequestFragment.self),
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

        public var reviewRequestFragment: ReviewRequestFragment {
          get {
            return ReviewRequestFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct PullRequestReviewFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PullRequestReviewFragment on PullRequestReview {
      __typename
      id
      state
      submittedAt
      author {
        __typename
        ...ActorFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["PullRequestReview"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
      GraphQLField("submittedAt", type: .scalar(String.self)),
      GraphQLField("author", type: .object(Author.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, state: PullRequestReviewState, submittedAt: String? = nil, author: Author? = nil) {
    self.init(unsafeResultMap: ["__typename": "PullRequestReview", "id": id, "state": state, "submittedAt": submittedAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
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

  /// Identifies the current state of the pull request review.
  public var state: PullRequestReviewState {
    get {
      return resultMap["state"]! as! PullRequestReviewState
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
    }
  }

  /// Identifies when the Pull Request Review was submitted
  public var submittedAt: String? {
    get {
      return resultMap["submittedAt"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "submittedAt")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ActorFragment.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeBot(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeMannequin(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeUser(login: String, avatarUrl: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
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

      public var actorFragment: ActorFragment {
        get {
          return ActorFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct ReviewRequestFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ReviewRequestFragment on ReviewRequest {
      __typename
      id
      requestedReviewer {
        __typename
        ...ActorFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["ReviewRequest"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, requestedReviewer: RequestedReviewer? = nil) {
    self.init(unsafeResultMap: ["__typename": "ReviewRequest", "id": id, "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> ResultMap in value.resultMap }])
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

  /// The reviewer that is requested.
  public var requestedReviewer: RequestedReviewer? {
    get {
      return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
    }
  }

  public struct RequestedReviewer: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mannequin", "Team", "User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ActorFragment.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeMannequin(login: String, avatarUrl: String) -> RequestedReviewer {
      return RequestedReviewer(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
    }

    public static func makeTeam() -> RequestedReviewer {
      return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
    }

    public static func makeUser(login: String, avatarUrl: String) -> RequestedReviewer {
      return RequestedReviewer(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
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

      public var actorFragment: ActorFragment? {
        get {
          if !ActorFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
          return ActorFragment(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap += newValue.resultMap
        }
      }
    }
  }
}
