//
//  MockAPI.swift
//  LWY
//
//  Created by ant on 2018/5/24.
//  Copyright © 2018年 com.cornerant. All rights reserved.
//

import UIKit
import Moya
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let MockAPIProvider = MoyaProvider<MockAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum MockAPI {
    case data

}

extension MockAPI: TargetType {
    public var baseURL: URL { return URL(string: "http://static.youshikoudai.com")! }
    public var path: String {
        switch self {
        case .data:
            return "/mockapi/data"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    public var validationType: ValidationType {
        switch self {
        case .data:
            return .successCodes
        default:
            return .none
        }
    }
    public var sampleData: Data {
        switch self {
        case .data:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
