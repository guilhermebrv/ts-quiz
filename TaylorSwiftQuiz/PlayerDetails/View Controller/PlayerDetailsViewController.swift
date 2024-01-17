//
//  PlayerDetailsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 23/09/2023.
//

import UIKit
import PhotosUI
import CoreData

class PlayerDetailsViewController: UIViewController {
    
    private var viewModel: PlayerDetailsViewModel = PlayerDetailsViewModel()
    private var screen: PlayerDetailsView?
    private var alertController: SelectPhotoAlertController?
    private var cameraPicker: UIImagePickerController = UIImagePickerController()
	private var selectedPhoto: Bool = false
        
    override func loadView() {
        screen = PlayerDetailsView()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.createNewPlayer()
        signProtocols()
        dismissKeyBoard()
        alertController = SelectPhotoAlertController(controller: self)
    }
	
}

extension PlayerDetailsViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
        screen?.playerNameTextField.delegate = self
        cameraPicker.delegate = self
    }
    private func animationMinCharacters() {
        screen?.alertMaxCharactersLabel.text = "Minimum of 5 characters!"
        screen?.alertMaxCharactersLabel.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.screen?.alertMaxCharactersLabel.alpha = 0.7
        }
    }
    private func animationMaxCharacters() {
        screen?.alertMaxCharactersLabel.text = "Maximum characters reached!"
        screen?.alertMaxCharactersLabel.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.screen?.alertMaxCharactersLabel.alpha = 0.7
        }
    }
}

extension PlayerDetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        let maxCharacterLimit = 13
        let minCharacterLimit = 5
        
        if updatedText.count > maxCharacterLimit {
            animationMaxCharacters()
            return false
        }
        if textField.text?.count ?? 0 < minCharacterLimit {
             animationMinCharacters()
             return true
        }
        screen?.alertMaxCharactersLabel.alpha = 0.0
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let current = textField.text
        let minCharacterLimit = 5
        
        screen?.nextStepButton.isEnabled = false
        screen?.playerNameLabel.text = "Hello, \n\(current ?? "player")!"
        if let text = textField.text, text.isEmpty {
            screen?.alertMaxCharactersLabel.alpha = 0.0
            screen?.playerNameLabel.text = "Hello, \nplayer!"
        } else if let text = textField.text, text.count < minCharacterLimit {
            animationMinCharacters()
        } else {
            screen?.nextStepButton.isEnabled = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PlayerDetailsViewController: PlayerDetailsViewProtocol {
    func tappedChooseImage() {
        if let button = screen?.playerChooseImageButton {
            tappedButtonEffect(button: button)
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
        if let button = screen?.nextStepButton {
            tappedButtonEffect(button: button)
        }
        let nextScreen = ChooseDifficultyViewController()
        self.navigationController?.pushViewController(nextScreen, animated: true)
        viewModel.savePlayerName(name: screen?.playerNameTextField.text ?? "", id: UUID())
		if selectedPhoto == false {
			UserDataModel.shared.newPlayer?.photo = "custom"
		}
    }
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
						if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
							let base64String = imageData.base64EncodedString()
							self?.viewModel.savePlayerPhoto(photo: base64String)
							self?.selectedPhoto = true
						}
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
				if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
					let base64String = imageData.base64EncodedString()
					viewModel.savePlayerPhoto(photo: base64String)
					selectedPhoto = true
				}
            }
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

