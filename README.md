# CollectionViewSwift

```swift
class ViewController: UIViewController,WaterFallLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collection: UICollectionView!
    
    var flag:NSString = "NO"
    
    var cellCount = 10
    private lazy var cellHeight:[CGFloat] = {
        var array:[CGFloat] = []
        for _ in 0..<self.cellCount{
            array.append(CGFloat(arc4random()%150 + 40))
        }
        print(array);
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        //线性
        //setLineLayout()
        //瀑布流
        setWaterFallLayout()
        //圆型
        //setCirCleLayout()
    }
    
    func setLineLayout(){
        let layout = LineLayout()
        layout.itemSize = CGSize(width: 100.0,height:100.0)
        collection?.collectionViewLayout = layout
        collection?.backgroundColor = UIColor.blueColor()
    }
    
    func setWaterFallLayout(){
        let layout = WaterFallLayout()
        layout.delegate = self
        layout.numberOfColums = 5
        collection?.collectionViewLayout = layout
        collection?.backgroundColor = UIColor.blackColor()
        flag = "YES"
    }
    
    func setCirCleLayout() -> Void {
        let layout = CirCleLayout()
        collection?.collectionViewLayout = layout
        collection?.backgroundColor = UIColor.yellowColor()
    }
    
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return cellHeight[indexPath.row]
    }
   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row % 2 == 0 {
            //偶数
            cellCount -= 1
            if flag.isEqual("YES") {
                self.cellHeight.removeAtIndex(indexPath.row)
            }
            collectionView.performBatchUpdates({
                collectionView.deleteItemsAtIndexPaths([indexPath])
                }, completion:nil)
        }else{
            cellCount += 1
            if flag.isEqual("YES") {
                self.cellHeight.append(CGFloat(arc4random() % 150 + 40))
            }
            collectionView.performBatchUpdates({
                collectionView.insertItemsAtIndexPaths([indexPath])
                }, completion: nil)
        }
    }

}

```
###感谢关注
> <font color = #ffb200>有任何建议或想法请加QQ:578545715,你的点赞是我前行最大动力~!</font>

###效果图
![image](https://github.com/LeeFengHY/CollectionViewSwift/raw/master/images/1.jpg)
![image](https://github.com/LeeFengHY/CollectionViewSwift/raw/master/images/2.jpg)
![image](https://github.com/LeeFengHY/CollectionViewSwift/raw/master/images/3.jpg)
