//
//  PlayerDetailsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 23/09/2023.
//

import UIKit
import PhotosUI


class PlayerDetailsViewController: UIViewController {
    
    var screen: PlayerDetailsView?
    
    var alertController: SelectPhotoAlertController?
        
    var cameraPicker: UIImagePickerController = UIImagePickerController()
        
    override func loadView() {
        screen = PlayerDetailsView()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configCameraPicker()
        alertController = SelectPhotoAlertController(controller: self)
        screen?.delegate(delegate: self)
        screen?.playerNameTextField.delegate = self
    }
    
    func configCameraPicker() {
        cameraPicker.delegate = self
    }
}

extension PlayerDetailsViewController {
    
}

extension PlayerDetailsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    func presentPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider else { return }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let selectedImage = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.screen?.playerChooseImageButton.setBackgroundImage(selectedImage, for: .normal)
                    }
                } else { return }
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            if let selectedImage = info[.originalImage] as? UIImage {
                self.screen?.playerChooseImageButton.setBackgroundImage(selectedImage, for: .normal)
                self.screen?.playerChooseImageButton.imageView?.contentMode = .scaleToFill
            }
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

extension PlayerDetailsViewController: PlayerDetailsViewProtocol, UITextFieldDelegate {
    func tappedChooseImage() {
        screen?.playerChooseImageButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.screen?.playerChooseImageButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        
        self.alertController?.chooseImage(completion: { option in
            switch option {
            case .camera:
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.cameraPicker.sourceType = .camera
                    self.present(self.cameraPicker, animated: true)
                } else {
                    self.presentPHPicker()
                }
            case .library:
                self.presentPHPicker()
            case .cancel:
                break
            }
        })
        }
    
    func tappedNextStepButton() {
        let nextScreen = ChooseDifficultyVC()
            self.navigationController?.pushViewController(nextScreen, animated: true)
        
        screen?.nextStepButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.screen?.nextStepButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        
        TemporaryDataStorage.shared.playerName = screen?.playerNameTextField.text ?? ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)

        let maxCharacterLimit = 13
        let minCharacterLimit = 5
        
        if updatedText.count > maxCharacterLimit {
            screen?.animationMaxCharacters()
            return false
        }
        
       if textField.text?.count ?? 0 < minCharacterLimit {
            screen?.animationMinCharacters()
            return true
       }
        
        screen?.alertMaxCharactersLabel.alpha = 0.0
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let current = textField.text
        let minCharacterLimit = 5
        
        if let text = textField.text, text.isEmpty {
            screen?.playerNameLabel.text = "Hello, \nplayer!"
            screen?.nextStepButton.isEnabled = false
            screen?.alertMaxCharactersLabel.alpha = 0.0
        } else if let text = textField.text, text.count < minCharacterLimit {
            screen?.playerNameLabel.text = "Hello, \n\(current ?? "player")!"
            screen?.animationMinCharacters()
            screen?.nextStepButton.isEnabled = false
        } else {
            screen?.playerNameLabel.text = "Hello, \n\(current ?? "player")!"
            screen?.nextStepButton.isEnabled = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
