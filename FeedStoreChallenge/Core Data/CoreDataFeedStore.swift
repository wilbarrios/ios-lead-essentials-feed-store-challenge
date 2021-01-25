//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Wilmer Barrios on 23/01/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataFeedStore: FeedStore {
	
	typealias StoredFeedData = (feed: [CDFeedImageItem], timestamp: Date)
	
	private let context: NSManagedObjectContext
	
	public init(contextBuilder: CDContextBuilder) throws {
		switch contextBuilder.build() {
		case .success(let context):
			self.context = context
		case .failure(let e):
			throw e
		}
	}
	
	// MARK: FeedStore extension
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		let context = self.context
		context.perform {
			let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDFeedImage.fetchRequest()
			let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
			do {
				try context.execute(batchDeleteRequest)
				completion(nil)
			} catch let e {
				completion(e)
			}
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let context = self.context
		context.perform {
			let feed_data: [CDFeedImageItem] = feed.toCD(context: context)
			let storeFeed = CDFeedImage(context: context)
			storeFeed.feed_data = NSOrderedSet(array: feed_data)
			storeFeed.feed_timestamp = timestamp
			do {
				try context.save()
				completion(nil)
			} catch let e {
				completion(e)
			}
		}
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		let context = self.context
		context.perform {
			let fetchRequest: NSFetchRequest<CDFeedImage> = CDFeedImage.fetchRequest()
			do {
				let data = try context.fetch(fetchRequest)
				let mappedData = self.map(data)
				guard !mappedData.items.isEmpty else { completion(.empty); return }
				completion(.found(feed: mappedData.items, timestamp: mappedData.timestamp))
			} catch let error as NSError {
				completion(.failure(error))
				print("Could not fetch. \(error), \(error.userInfo)")
			}
		}
	}
	
	// MARK: Helpers
	private func map(_ data: [CDFeedImage]) -> (items: [LocalFeedImage], timestamp: Date) {
		var result = [StoredFeedData]()
		for feed in data {
			guard let feedData = feed.feed_data.array as? [CDFeedImageItem] else { continue }
			result.append((feedData, feed.feed_timestamp))
		}
		guard !result.isEmpty else { return ([], Date())}
		let mappedData = result.last!.feed.toLocal()
		let fetchedTimestamp = result.last!.timestamp
		return (mappedData, fetchedTimestamp)
	}
}

// MARK: Mapping extensions
internal extension Array where Element == CDFeedImageItem {
	func toLocal() -> [LocalFeedImage] {
		map({ LocalFeedImage(id: $0.image_id, description: $0.image_description, location: $0.image_location, url: $0.image_url ) })
	}
}

internal extension Array where Element == LocalFeedImage {
	func toCD(context: NSManagedObjectContext) -> [CDFeedImageItem] {
		map(
			{ local in
				let n = CDFeedImageItem(context: context)
				n.image_description = local.description
				n.image_id = local.id
				n.image_location = local.location
				n.image_url = local.url
				return n
			}
		)
	}
}
