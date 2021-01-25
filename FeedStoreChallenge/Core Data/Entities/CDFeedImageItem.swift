//
//  CDFeedImageItem.swift
//  FeedStoreChallenge
//
//  Created by Wilmer Barrios on 24/01/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

public class CDFeedImageItem: NSManagedObject {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CDFeedImageItem> {
		return NSFetchRequest<CDFeedImageItem>(entityName: "CDFeedImageItem")
	}

	@NSManaged public var image_id: UUID
	@NSManaged public var image_description: String?
	@NSManaged public var image_location: String?
	@NSManaged public var image_url: URL
}
