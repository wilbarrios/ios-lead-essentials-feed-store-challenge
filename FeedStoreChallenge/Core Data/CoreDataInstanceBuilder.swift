//
//  CoreDataInstanceBuilder.swift
//  FeedStoreChallenge
//
//  Created by Wilmer Barrios on 24/01/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

internal final class CoreDataInstanceBuilder {
	
	private static let modelName = "FeedStoreDataModel"
	private let storeURL: URL
	
	internal init(storeURL: URL) {
		self.storeURL = storeURL
	}
	
	internal func build() throws -> NSManagedObjectContext {
		return try makeCDContext(storeURL: storeURL)
	}
	
	// MARK: helpers
	private func makeCDContext(storeURL: URL) throws -> NSManagedObjectContext {
		let model = try self.getCDObjectModel()
		let container = self.getCDContainer(storeURL: storeURL, model: model)
		try self.checkContainerIsLoadable(container)
		return container.newBackgroundContext()
	}
	
	private func checkContainerIsLoadable(_ container: NSPersistentContainer) throws {
		var loadError: Swift.Error?
		container.loadPersistentStores { loadError = $1 }
		try loadError.map { throw $0 }
	}
	
	private func getCDObjectModel() throws -> NSManagedObjectModel {
		guard let modelURL = Bundle(for: CoreDataInstanceBuilder.self).url(forResource: CoreDataInstanceBuilder.modelName, withExtension:"momd"),
			  let model = NSManagedObjectModel(contentsOf: modelURL) else {
			throw NSError()
		}
		return model
	}
	
	private func getCDContainer(storeURL: URL, model: NSManagedObjectModel) -> NSPersistentContainer {
		let description = NSPersistentStoreDescription(url: storeURL)
		let container = NSPersistentContainer(name: CoreDataInstanceBuilder.modelName, managedObjectModel: model)
		container.persistentStoreDescriptions = [description]
		return container
	}
}
