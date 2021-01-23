//
//  CDFeedImage+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Wilmer Barrios on 23/01/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFeedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFeedImage> {
        return NSFetchRequest<CDFeedImage>(entityName: "CDFeedImage")
    }

    @NSManaged public var feed_timestamp: Date?
    @NSManaged public var feed_data: CDFeedImageItem?

}

extension CDFeedImage : Identifiable {

}
