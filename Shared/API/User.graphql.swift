// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query User($login: String!) {
      user(login: $login) {
        __typename
        ...ActorFragment
      }
      rateLimit {
        __typename
        ...RateLimitFragment
      }
    }
    """

  public let operationName: String = "User"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + ActorFragment.fragmentDefinition)
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
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
        GraphQLField("rateLimit", type: .object(RateLimit.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil, rateLimit: RateLimit? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "rateLimit": rateLimit.flatMap { (value: RateLimit) -> ResultMap in value.resultMap }])
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

    /// The client's rate limit information.
    public var rateLimit: RateLimit? {
      get {
        return (resultMap["rateLimit"] as? ResultMap).flatMap { RateLimit(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "rateLimit")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

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

      public init(login: String, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
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
  }
}

public final class LoginQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Login {
      viewer {
        __typename
        login
      }
    }
    """

  public let operationName: String = "Login"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

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

      public init(login: String) {
        self.init(unsafeResultMap: ["__typename": "User", "login": login])
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
}

public struct ActorFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ActorFragment on Actor {
      __typename
      login
      avatarUrl
    }
    """

  public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeBot(login: String, avatarUrl: String) -> ActorFragment {
    return ActorFragment(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
  }

  public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> ActorFragment {
    return ActorFragment(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
  }

  public static func makeMannequin(login: String, avatarUrl: String) -> ActorFragment {
    return ActorFragment(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
  }

  public static func makeOrganization(login: String, avatarUrl: String) -> ActorFragment {
    return ActorFragment(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
  }

  public static func makeUser(login: String, avatarUrl: String) -> ActorFragment {
    return ActorFragment(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The username of the actor.
  public var login: String {
    get {
      return resultMap["login"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "login")
    }
  }

  /// A URL pointing to the actor's public avatar.
  public var avatarUrl: String {
    get {
      return resultMap["avatarUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }
}
