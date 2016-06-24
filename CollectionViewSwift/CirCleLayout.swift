
//
//  CirCleLayout.swift
//  CollectionViewSwift
//
//  Created by QFWangLP on 16/6/24.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

import UIKit

class CirCleLayout: UICollectionViewLayout {
    private var layoutAttributes:[UICollectionViewLayoutAttributes] = []
    //圆心
    var center = CGPointZero
    //圆半径
    var radius:CGFloat = 0.0
    var totalNum = 0
    override func prepareLayout() {
        super.prepareLayout()
        //初始化需要的数据
        totalNum = collectionView!.numberOfItemsInSection(0)
        //每次计算前数据需要清0
        layoutAttributes = []
        center = CGPoint(x: Double(collectionView!.bounds.width * 0.5),y: Double(collectionView!.bounds.height * 0.5))
        radius = min(collectionView!.bounds.width, collectionView!.bounds.height) / 3.0
        print(radius)
        var indexPath: NSIndexPath
        for index   in 0..<totalNum {
            indexPath = NSIndexPath(forRow: index,inSection: 0)
            let attributes = layoutAttributesForItemAtIndexPath(indexPath)!
            layoutAttributes.append(attributes)
        }
    }
    
    // 因为返回的collectionViewContentSize使得collectionView不能滚动, 所以当旋转的时候才会触发, 故返回为true便于重新计算布局
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
     // Apple建议要重写这个方法, 因为某些情况下(delete insert...)系统可能需要调用这个方法来布局
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
        attributes.size = CGSize(width: 60.0, height: 60.0)
        //注意类型转换-当前cell角度
        /*
         cos180°等于-1
         答：余玄角为临边比上斜边的值
         当余玄角等于180时 临边和斜边的长相等 所以比出来结果为1
         但此时临边在X轴的负半轴 所以比出来的值为负的
         sin270°为什么等于-1呀：
         画个十字坐标轴 270度相当于-Y轴 也就是-1
         */
        let angel = 2 * CGFloat(M_PI) * CGFloat(indexPath.row) / CGFloat(totalNum)
        attributes.center = CGPointMake(center.x + radius*cos(angel), center.y + radius*sin(angel))
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size
    }
}
