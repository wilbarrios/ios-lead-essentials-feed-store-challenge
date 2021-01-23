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
    @NSManaged public var feed_data: NSOrderedSet?

}

// MARK: Generated accessors for feed_data
extension CDFeedImage {

    @objc(insertObject:inFeed_dataAtIndex:)
    @NSManaged public func insertIntoFeed_data(_ value: CDFeedImageItem, at idx: Int)

    @objc(removeObjectFromFeed_dataAtIndex:)
    @NSManaged public func removeFromFeed_data(at idx: Int)

    @objc(insertFeed_data:atIndexes:)
    @NSManaged public func insertIntoFeed_data(_ values: [CDFeedImageItem], at indexes: NSIndexSet)

    @objc(removeFeed_dataAtIndexes:)
    @NSManaged public func removeFromFeed_data(at indexes: NSIndexSet)

    @objc(replaceObjectInFeed_dataAtIndex:withObject:)
    @NSManaged public func replaceFeed_data(at idx: Int, with value: CDFeedImageItem)

    @objc(replaceFeed_dataAtIndexes:withFeed_data:)
    @NSManaged public func replaceFeed_data(at indexes: NSIndexSet, with values: [CDFeedImageItem])

    @objc(addFeed_dataObject:)
    @NSManaged public func addToFeed_data(_ value: CDFeedImageItem)

    @objc(removeFeed_dataObject:)
    @NSManaged public func removeFromFeed_data(_ value: CDFeedImageItem)

    @objc(addFeed_data:)
    @NSManaged public func addToFeed_data(_ values: NSOrderedSet)

    @objc(removeFeed_data:)
    @NSManaged public func removeFromFeed_data(_ values: NSOrderedSet)

}

extension CDFeedImage : Identifiable {

}
