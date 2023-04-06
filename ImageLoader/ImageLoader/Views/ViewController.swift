//
//  ViewController.swift
//  ImageLoader
//
//  Created by Mac mini on 06/04/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var gridCollectionView: UICollectionView!
    var productsData: [MainDataSource]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APICaller.shared.getJsonResult() { result in
            switch result{
            case .success(let homeData):
                self.productsData = homeData
                print("########### \(self.productsData)")
                DispatchQueue.main.async {
                    self.gridCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        print(productsData)
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        self.gridCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
    }

}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ProductCollectionViewCell",
            for: indexPath) as?
                ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = URL(string: productsData![indexPath.row].image ?? "")
        cell.gridImage.kf.setImage(with: url)
        cell.gridTitle.text = productsData![indexPath.row].title
        
        return cell
        
    }
    
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}

