//
//  RealmService.swift
//  HolyWaterServices
//
//  Created by Artem Bilyi on 09.02.2024.
//

import Realm
import RealmSwift

public protocol RealmService {

    @discardableResult
    func saveObject<T: Object>(object: T) async -> Bool

    @discardableResult
    func deleteObject<T: Object>(object: T) async -> Bool

    func loadObject<T: Object>(completion: @escaping (T?) -> Void) async
}

public protocol RealmServiceWorkerContainer {
    var realmServiceWorker: RealmService { get }
}

public enum RealmPrimaryKey: String {
    case bookResponse
}

public actor ConcreteRealmActor: RealmService {

    private var realm: Realm!

    public init() async throws {
        realm = try await Realm(actor: self)
    }

    public func saveObject(object: some RealmSwiftObject) async -> Bool {
        do {
            try await realm.asyncWrite {
                realm.add(object, update: .modified)
            }
            return true
        } catch {
            return false
        }
    }

    public func deleteObject(object: some RealmSwiftObject) async -> Bool {
        do {
            try await realm.asyncWrite {
                realm.delete(object)
            }
            return true
        } catch {
            return false
        }
    }

    public func loadObject<T>(completion: @escaping (T?) -> Void) async where T: RealmSwiftObject {
        guard let object = realm.object(
            ofType: T.self,
            forPrimaryKey: RealmPrimaryKey.bookResponse.rawValue)
        else {
            completion(nil)
            return
        }
        completion(object)
    }
}
