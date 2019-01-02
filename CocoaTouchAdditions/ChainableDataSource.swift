//
//  ChainableDataSource.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/20/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public typealias IndexPathTransform = Transform<IndexPath, IndexPath>

/// A base class to override to create data source objects that can be chained together to provide individual pieces of functionality such as filtering or collapsing sections. By overriding this class you only have to override the methods that you want to change and the hassle of passing on the to wrapped data source is done for you.
open class ChainableDataSource: NSObject, UICollectionViewDataSource {
    
    public var previousDataSource: UICollectionViewDataSource?
    
    /// `apply` takes an indexPath that is raw as viewed by this data source and transforms it so that is raw as viewed by `previousDataSource`. `previousDataSource` should not need any knowledge of any transforms that happen after it. `undo` is used to take an IndexPath returned by previousDataSource and convert it to raw as viewed by this dataSource.
    public var indexTransform: IndexPathTransform = .identity
    
    public struct Defaults {
        public var numberOfSections: Int = 0
        public var numberOfItems: Int = 0
        /// Default is nil to force a crash. There is no reason to pass an empty supplementaryView by default.
        public var viewForSupplementaryElementOfKindAtIndexPath: UICollectionReusableView! = nil
        /// Default is nil to force a crash. There is no reason to pass an empty cell by default.
        public var cellForItemAtIndexPath: UICollectionViewCell! = nil
        public var canMoveItemAtIndexPath: Bool = false
        public var indexTitles: [String]? = nil
        /// Default is nil to force a crash. There is no reason to pass a canned IndexPath by default. This would only be called if someone implemented the indexTitles... method.
        public var indexPathForIndexTitle: IndexPath! = nil
    }
    public var defaults: Defaults = Defaults()
    
    public init(sourcingFrom dataSource: UICollectionViewDataSource? = nil) {
        previousDataSource = dataSource
    }
    
    public init(sourcingFrom dataSource: UICollectionViewDataSource, defaults: Defaults) {
        previousDataSource = dataSource
        self.defaults = defaults
    }
    
    /// If recursive, apply the transform for all previous data sources.
    public func transform(_ indexPath: IndexPath, recursively: Bool = false) -> IndexPath {
        // Allow parent to tranform first.
        var parentIndexPath = indexPath
        if recursively, let previousDataSource = previousDataSource as? ChainableDataSource {
            parentIndexPath = previousDataSource.transform(indexPath, recursively: true)
        }
        return indexTransform.apply(parentIndexPath)
    }
    
    /// If recursive, apply the transform for all previous data sources.
    public func transform(_ section: Int, recursively: Bool = false) -> Int {
        return transform(IndexPath(item: 0, section: section), recursively: recursively).section
    }
    
    /// If recursive, apply the transform for all previous data sources.
    public func untransform(_ indexPath: IndexPath, recursively: Bool = false) -> IndexPath {
        // Allow parent to tranform first.
        var parentIndexPath = indexPath
        if recursively, let previousDataSource = previousDataSource as? ChainableDataSource {
            parentIndexPath = previousDataSource.untransform(indexPath, recursively: true)
        }
        return indexTransform.undo(parentIndexPath)
    }
    
    /// If recursive, apply the transform for all previous data sources.
    public func untransform(_ section: Int, recursively: Bool = false) -> Int {
        return untransform(IndexPath(item: 0, section: section), recursively: recursively).section
    }
    
    // MARK: Required data source implementations.
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previousDataSource?.collectionView(collectionView, numberOfItemsInSection: transform(section)) ?? defaults.numberOfItems
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return previousDataSource?.collectionView(collectionView, cellForItemAt: transform(indexPath)) ?? defaults.cellForItemAtIndexPath
    }
    
    // MARK: Not required data source implementations.
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return previousDataSource?.numberOfSections?(in: collectionView) ?? defaults.numberOfSections
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return previousDataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: transform(indexPath)) ?? defaults.viewForSupplementaryElementOfKindAtIndexPath
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return previousDataSource?.collectionView?(collectionView, canMoveItemAt: transform(indexPath)) ?? defaults.canMoveItemAtIndexPath
    }
    
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        previousDataSource?.collectionView?(collectionView, moveItemAt: transform(sourceIndexPath), to: transform(destinationIndexPath))
    }
    
    /// Index in the returned array is raw and does not have a transform applied.
    open func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return previousDataSource?.indexTitles?(for: collectionView) ?? defaults.indexTitles
    }
    
    /// Index is raw and does not have a transform applied.
    open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return previousDataSource?.collectionView?(collectionView, indexPathForIndexTitle: title, at: index) ?? defaults.indexPathForIndexTitle
    }
}

