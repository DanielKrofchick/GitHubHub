//
//  Network.swift
//  GitHubHub
//
//  Created by Daniel Krofchick on 2022-06-09.
//

import Foundation

class API {
    static let domain = "api.github.com"

    func user(_ user: String? = nil) {
        URLSession.shared
            .dataTask(
                with: URL(string: "https://api.github.com/users/\(user ?? "")")!,
                completionHandler: { data, response, error in
                    print(data, response, error)

                    if let data = data {
                        self.decode(User.self, from: data)
                    }
                }
            )
            .resume()
    }

    func repos(user: String? = nil, repo: String? = nil) {
        URLSession.shared
            .dataTask(
                with: URL(string: "https://api.github.com/users/\(user ?? "")/repos/\(repo ?? "")")!,
                completionHandler: { data, response, error in
                    print(data, response, error)

                    if let data = data {
                        self.decode(Repo.self, from: data)
                    }
                }
            )
            .resume()
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let string = String(data: jsonData, encoding: .utf8)
        else { return nil }

        print(string)

        if let object = try? JSONDecoder().decode(T.self, from: jsonData)  {
            print(object)
            return object
        } else {
            print("decode error")
            return nil
        }
    }
}

struct User: Decodable {
    let login: String
}

struct Repo: Decodable {
}
