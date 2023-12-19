//
//  SelectPhotoAlertController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

enum TypeSelected {
    case camera
    case library
    case cancel
}

class SelectPhotoAlertController: NSObject {

    let controller: PlayerDetailsViewController?
    init(controller: PlayerDetailsViewController?) {
        self.controller = controller
    }
    
    func chooseImage(completion: @escaping(_ option: TypeSelected) -> Void) {
        let alertController = UIAlertController(title: "Select one of the following options", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default) { action in
                completion(.camera)
            }
            alertController.addAction(camera)
        }
        
        let library = UIAlertAction(title: "Photo Library", style: .default) { action in
            completion(.library)
        }
        alertController.addAction(library)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(.cancel)
        }
        alertController.addAction(cancel)
        
        controller?.present(alertController, animated: true)
    }
}
