//
//  LineLayout.swift
//  CollectionViewSwift
//
//  Created by QFWangLP on 16/6/24.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {
    
    private var layoutAttributes:[UICollectionViewLayoutAttributes] = []
    override func prepareLayout() {
        super.prepareLayout()
        scrollDirection = .Horizontal
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributes = []
        let superLayoutAttributes = super.layoutAttributesForElementsInRect(rect)
        let collectionViewCenterX = collectionView!.bounds.width * 0.5
        superLayoutAttributes?.forEach({ (attributes) in
            
            let copyLayout = attributes.copy() as! UICollectionViewLayoutAttributes
            print("\(collectionViewCenterX,copyLayout.center.x,collectionView!.contentOffset.x)")
            //和中心点的横向距离
            let deltaX     = abs(collectionViewCenterX - (copyLayout.center.x - collectionView!.contentOffset.x))
            
            // 计算屏幕内的cell的transform
            if deltaX < collectionView!.bounds.width {
                let scale = 1.0 - deltaX/collectionViewCenterX
                copyLayout.transform = CGAffineTransformMakeScale(scale, scale)
                print("+++++\(scale)")
            }
            layoutAttributes.append(copyLayout)
        })
        
        return layoutAttributes
        
    }
    /** 返回true将会标记collectionView的data为 'dirty'
     * collectionView检测到 'dirty'标记时会在下一个周期中更新布局
     * 滚动的时候实时更新布局
     */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true;
    }
    
    
    
    
}
