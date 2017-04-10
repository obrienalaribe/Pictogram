//
//  PhotoSelectorControllerCollectionViewController.swift
//  Pictogram
//
//  Created by Obrien Alaribe on 07/04/2017.
//  Copyright © 2017 obrien. All rights reserved.
//

import UIKit
import Photos

private let cellId = "Cell"
private let headerId = "headerId"

class PhotoSelectorControllerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var selectedImage : UIImage?
    var images = [UIImage]()
    var assets = [PHAsset]()
    var header : PhotoSelectorHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)

        self.collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = .white
        setupNavigationButtons()
        
        fetchPhotos()
    }

    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = BrandColours.primary
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action:  #selector(handleNext))
    }
    
    fileprivate func assetFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        return fetchOptions
    }
    
    fileprivate func fetchPhotos() {
        print("fetching photos")
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetFetchOptions())
        
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects({ (asset, count, stop) in
                
                print(count)
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                //request image from device with a target asset size
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        //fetch low quality thumbnail and hold asset reference for requesting higher quality for header later
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    
                    //lecture 14 (user photo selection)
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            //calling ui code on main thread
                            self.collectionView?.reloadData()
                        }
                    }
                })
            })
        }
       
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleNext() {
        let memeEditorController = MemeEditorController()
        memeEditorController.selectedImage = header?.photoImageView.image
        navigationController?.pushViewController(memeEditorController, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // need this for header to be displayed
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
       
        //hold reference to header to pass on high res image to next view
        self.header = header
        
        //get index of the selected image
        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]

                //request high res image asset
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
                    header.photoImageView.image = image
                })

            }
        }
        
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
    
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
   
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.selectedImage = images[indexPath.item]
        collectionView.reloadData()
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        return true
    }


    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
