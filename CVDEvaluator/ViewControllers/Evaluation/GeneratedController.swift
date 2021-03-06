//
//  GeneratedController.swift
//  CVDEvaluator
//
//  Created by IgorKhomiak on 2/10/17.
//  Copyright © 2017 IgorKhomiak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class GeneratedController: BaseTableController, NVActivityIndicatorViewable {
	
	let unwindToEvaluationSegueID = "unwindToEvaluationSegueID"
	
	var cellExpanded:Bool = false
	
	@IBOutlet weak var datePicker: UIDatePicker!
	
	weak var shortcutModel: EvaluationItem?
	private var dateModel: EvaluationItem?
	
	override var createdID: String! { return "generated" }
	override var generatedID: String? { return pageForm.identifier }
	
	var isHeartSpecilaistManagement:Bool = false
	
	var isHeartSpecilaistManagementPop:Int?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if (isHeartSpecilaistManagement) {
			isHeartSpecilaistManagementPop? += 1
		}
		
		if (pageForm is HeartSpecialistManagement) {
			isHeartSpecilaistManagement = true
			isHeartSpecilaistManagementPop = 0
		}
		
		// print("--is this pah ??? \(pageForm is HeartSpecialistManagement) --- \(isHeartSpecilaistManagement)")
		
		//let classType = type(of:pageForm)
		//print("page class is %@", classType)
		
		if self.navigationItem.leftBarButtonItem == nil {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"),
				style: .plain, target: self, action: #selector(self.leftButtonAction(_:)))
		}
		
		// self.navigationItem.rightBarButtonItems?[0].action = #selector()
		
		self.title = pageForm.title
		
		self.tableView.dataSource = self
		
		for item in pageForm.items {
			let type = item.form.itemType
			if type == ItemType.date {
				dateModel = item
				break
			}
		}
		
		self.tableView.reloadData()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.toolbarItems = nil
		shortcutModel = nil
		
		if pageForm.identifier == "bioPAHMain", let form = pageForm as? BioPAHMain {
			if let selectedGender = form.gender.male.storedValue?.radioGroup?.selectedRadioItem {
				form.gender.subtitle = (selectedGender == form.gender.male.identifier) ? "Male".localized : "Female".localized
			}
		}
		
		let bottomSelectors: [Selector?] = [#selector(self.bottomRightButtonAction(_:)),
		                                    #selector(self.bottomRightButtonAction1(_:))]

		if ["nsr", "heartSpecialistManagement", "rhcInHSM"].contains(where: { $0 == pageForm.identifier }) {
			self.navigationController?.setToolbarHidden(false, animated: false)
			
			shortcutModel = DataManager.manager.evaluation!.outputInMain
			
			let dictInfo = ["rightBottom" : "Compute".localized]
			
			// toolbar
			let toolbar = CVDToolbar()
			toolbar.setup(dict: dictInfo, target: self, actions: bottomSelectors )
			toolbar.barTintColor = .white
			toolbar.sizeToFit()
			
			self.toolbarItems = toolbar.barItems
			
		} else if let id = CVDStyle.style.smartLink(from: pageForm.identifier) {
			
			self.navigationController?.setToolbarHidden(false, animated: false)
			
			let model = DataManager.manager.evaluation!.model(with: id)
			shortcutModel = model
			
			//phillips fix
			guard let shortcutModelTitle = shortcutModel?.title else {
				return
			}
			
			//let dictInfo = ["rightBottom" : shortcutModel!.title + ""]
			let dictInfo = ["rightBottom" : shortcutModelTitle + ""]
			
			
			let toolbar = CVDToolbar()
			toolbar.setup(dict: dictInfo, target: self, actions: bottomSelectors )
			toolbar.barTintColor = .white
			toolbar.sizeToFit()

			
			self.toolbarItems = toolbar.barItems
		
		} else {
			self.navigationController?.setToolbarHidden(true, animated: false)

		}

		self.tableView.reloadData()
	}
	

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if let alert = pageForm.form.alert {
			print(alert)
			// FIXME: add condition check to see what the alert says. If its one that Dr doesn't want refered, add here.
			let handler1: CVDHandler = {() in
				_ = self.navigationController?.popViewController(animated: true)
			}
			
			if alert == "Please use Heart Failure app for Refactory Heart Failure" {
				let okAction = CVDAction(title: "OK".localized, type: CVDActionType.cancel, handler: handler1, short: false)
				self.showCVDAlert(title: alert, message: nil, actions: [okAction])
				
			} else {
				let cancelAction = CVDAction(title: "Cancel".localized, type: CVDActionType.cancel, handler: handler1, short: false)
				
				let handler2 = createPahHandler(model: DataManager.manager.evaluation!.heartSpecialistManagement, navigation: self.navigationController)
				let navigateAction = CVDAction(title: "Refer".localized, type: CVDActionType.done, handler: handler2, short: false)
				self.showCVDAlert(title: alert, message: nil, actions: [navigateAction, cancelAction])
			}

			
			
			
			
		}
		
	}

	
	override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
//		if self.isMovingFromParentViewController && (DataManager.manager.evaluation?.isBioCompleted ?? false) {
//			let isValid = validatePage()
//			if isValid && generatedID != "outputInMain" {
//				DataManager.manager.saveCurrentEvaluation()
//			}
//		}
	}
	
	
	func validatePage() -> Bool {
		do {
			try pageForm.validateEvaluationItem()
			return true
			
		} catch let err {
			
			var actions = [CVDAction] ()
			actions.append(CVDAction(title: "OK".localized, type: CVDActionType.cancel, handler: nil, short: true))
			
			let alertTitle: String = "Cannot save this form".localized
			
			var alertDescription : String?
			switch err {
			case InputError.incorrectInput:
				alertDescription = "One of the fields contains unsupported characters. Please correct and try again.".localized
			case InputError.toLong:
				alertDescription = "Entering in one of the fields is too long. Please shorten it and try again.".localized
			case InputError.outOfBounds:
				alertDescription = "Entered numerical value into one of field exceeds the limits. Please set number between limits.".localized
			case InputError.emptyInput:
				alertDescription = "Required Fields cannot be empty. Please fill in all fields marked (*).".localized
				
			default:
				()
			}
			self.showCVDAlert(title: alertTitle, message: alertDescription, actions: actions)
			return false
		}
	}
	
	
	
	// MARK: - Actions

	@IBAction func selectDate(_ sender: UIDatePicker) {
		
		let date = sender.date
		
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/yyyy"
		let strDate = formatter.string(from: date)
		self.dateModel?.storedValue?.value = strDate
		
		if let path = dateModel?.modelIndexPath {
			let cell = tableView.cellForRow(at: path) as! DateCell
			cell.textField?.text = strDate
		}
	}

	
	override func leftButtonAction(_ sender: UIBarButtonItem) {
		if validatePage() {
			_ = self.navigationController?.popViewController(animated: true)
		}
	}
	
	
	override func rightListButtonAction(_ sender: UIBarButtonItem) {
		if validatePage() {
			
			if ( (isHeartSpecilaistManagement  && !(pageForm is HeartSpecialistManagement)) || (pageForm is PAH)  || (pageForm is PAH1) || (pageForm is PAH2) || (pageForm is PAH3)) {
				//print("--is this pah ??? \(pageForm is PAH)")
				
				// find controller to go back to
				let viewControllers = self.navigationController?.viewControllers
				for aViewController in viewControllers! {
					if (aViewController is GeneratedController) {
						let aaViewController = aViewController as! GeneratedController
						if(aaViewController.pageForm is HeartSpecialistManagement){
							self.navigationController!.popToViewController(aaViewController, animated: true);
						}
					}
				}
				
				return
			}
			
			performSegue(withIdentifier: unwindToEvaluationSegueID, sender: self.pageForm)
		}
	}
	
	
	override func rightMenuButtonAction(_ sender: UIBarButtonItem) {
		
		var actions = [MenuAction] ()
		
		if pageForm.title == DataManager.manager.evaluation!.outputInMain.title {
			actions.append(MenuAction(title: "Save Evaluation".localized, handler: {
				self.computeEvaluation(isSaveMode: true)
			}))
			
			actions.append(MenuAction(title: "Exit Evaluation", handler: {
				var actions = [CVDAction] ()
				actions.append(CVDAction(title: "Yes, I'm sure".localized, type: CVDActionType.done, handler: {
					self.navigationController?.popToRootViewController(animated: true)
				}, short: false, border: false))
				actions.append(CVDAction(title: "Cancel".localized, type: CVDActionType.cancel, handler: nil, short: false, border: false))
				
				self.showCVDAlert(title: "Exit Evaluation?".localized,
				                  message: "Are you sure you want to exit this evaluation?".localized,
				                  actions: actions)
			}))
		}
		else {
			actions.append(MenuAction(title: "Reset Fields", handler: {
				self.resetFields(items: self.pageForm.items)
				
				self.tableView.reloadData()
			}))
		}
		
		self.showDropMenu(actions: actions)
	}
	
	
	override func bottomRightButtonAction(_ sender: UIBarButtonItem) {
		if validatePage() && shortcutModel != nil && shortcutModel?.title != DataManager.manager.evaluation!.outputInMain.title{
			let storyboard = UIStoryboard(name: "Medical", bundle: nil)

			if generatedID == "bioPAHMain" {
				DataManager.manager.setPAHValue(pah: true)
				let controller = storyboard.instantiateViewController(withIdentifier: "HypertensionControllerID") as! HypertensionController
				controller.pageForm = shortcutModel!
				controller.isHeartSpecilaistManagement = self.isHeartSpecilaistManagement
				controller.isHeartSpecilaistManagementPop = self.isHeartSpecilaistManagementPop
				self.navigationController?.pushViewController(controller, animated: true)
			
			} else {
				let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
				controller.pageForm = self.shortcutModel!
				controller.isHeartSpecilaistManagement = self.isHeartSpecilaistManagement
				controller.isHeartSpecilaistManagementPop = self.isHeartSpecilaistManagementPop
				self.navigationController?.pushViewController(controller, animated: true)
			}
			
			//print(validatePage().description + " -- " + (shortcutModel?.title)! + " -- " + DataManager.manager.evaluation!.outputInMain.title)
			self.pageForm.form.status = .valued
			
		} else if validatePage() && shortcutModel != nil && shortcutModel?.title == DataManager.manager.evaluation!.outputInMain.title {
			self.computeEvaluation(isSaveMode: false)
			
		}
	}
	
	
	func resetFields(items: [EvaluationItem]) {
		for item: EvaluationItem in items {
			let type = item.form.itemType
			if type == ItemType.textLeft || type == ItemType.decimalLeft || type == ItemType.integerLeft {
				if let _: String = item.storedValue?.value {
					item.storedValue?.value = nil
				}
			}
			else if type == ItemType.check || type == ItemType.disclosureControl || type == ItemType.disclosureControlExpandable {
				if let _: Bool = item.storedValue?.isChecked {
					item.storedValue?.isChecked = false
				}
				if type == ItemType.disclosureControlExpandable {
					resetFields(items: item.items)
				}
			}
			else if type == ItemType.radio {
				if let _: String = item.storedValue?.radioGroup?.selectedRadioItem {
					item.storedValue?.radioGroup?.selectedRadioItem = nil
					
				}
			}
		}
	}
	
	
	func computeEvaluation(isSaveMode: Bool) {
		
		let model = DataManager.manager.evaluation!
		
		var alertTitle = "Cannot open output screen".localized
		if isSaveMode {
			alertTitle =  "Cannot save evaluation".localized
		}
		
		if generatedID == DataManager.manager.evaluation?.heartSpecialistManagement.rhcInHSM.identifier || generatedID == DataManager.manager.evaluation?.heartSpecialistManagement.identifier {
			DataManager.manager.setPAHValue(pah: true)
		} else {
			DataManager.manager.setPAHValue(pah: false)
		}
		
		self.startAnimating(CGSize(width:80, height:80), message: nil, messageFont: nil, type: NVActivityIndicatorType.ballPulse, color: UIColor(palette: ColorPalette.white), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR, textColor: nil)

		if (isSaveMode && !model.isSaved) ||
			(model.isSaved && DataManager.manager.isEvaluationChanged()) ||
			(!isSaveMode && DataManager.manager.isEvaluationChanged()) {
			
			if model.bio.name.storedValue?.value == nil ||
				model.bio.age.storedValue?.value == nil ||
				model.bio.gender.storedValue?.value == nil ||
				model.bio.sbp.storedValue?.value == nil ||
				model.bio.dbp.storedValue?.value == nil
			{
				let cancelAction = CVDAction(title: "Cancel".localized, type: CVDActionType.cancel, handler: nil, short: false)
				
				let storyboard = UIStoryboard(name: "Medical", bundle: nil)
				let alertDescription = "Please fill out the Bio form first".localized
				let handler1 = {() in
					if let controller = storyboard.instantiateViewController(withIdentifier: "BioControllerID") as? BioController {
						controller.pageForm = model.bio
						self.navigationController?.pushViewController(controller, animated: true)
					}
				}
				
				let navigateAction = CVDAction(title: "Open ".localized + model.bio.title, type: CVDActionType.done, handler: handler1, short: false)
				self.showCVDAlert(title: alertTitle, message: alertDescription, actions: [navigateAction, cancelAction])
				
				self.stopAnimating()
				
				return
			}
			
			let client: RestClient = RestClient.client
			let inputs = DataManager.manager.getEvaluationItemsAsRequestInputsString(evaluation: model)
			let saveMode: Bool = isSaveMode
			let uuid: String? = model.isSaved ? model.evaluationUUID : "0"
			let patientname: String = (model.bio.name.storedValue?.value)!
			let gender: Int = model.bio.gender.storedValue?.value == "male" ? 1 : 2
			
			let evaluationRequest = EvaluationRequest(uuid: uuid,
			                                          isSave: saveMode,
			                                          age: Int((model.bio.age.storedValue?.value)!)!,
			                                          isPAH:String(DataManager.manager.getPAHValue()),
			                                          name: patientname,
			                                          gender: gender,
			                                          SBP: Int((model.bio.sbp.storedValue?.value)!)!,
			                                          DBP: Int((model.bio.dbp.storedValue?.value)!)!,
			                                          inputs: inputs)
			//print("PAH:\t" + evaluation.isPAH + "\t Inputs:\t " + evaluation.inputs)
			
			client.computeEvaluation(evaluationRequest: evaluationRequest, success: { (response) in print(response)
				
				// cache current evaluation
				DataManager.manager.setEvaluationCache()
				
				// add pah value false
				DataManager.manager.setPAHValue(pah: false)
				
				if isSaveMode {
					let evaluationID: String = response["evaluationID"].stringValue
					if !evaluationID.isEmpty {
						model.isSaved = true
						model.evaluationUUID = evaluationID
						DataManager.manager.saveCurrentEvaluation()
					}
					else {
						model.isSaved = false
					}
				}
				else {
					let result = DataManager()
					result.setOutputEvaluation(response: response)
					
					if model.isSaved {
						DataManager.manager.saveCurrentCompute()
					}
				}
				
				self.stopAnimating()
				
				self.pageForm.form.status = .valued
				
				let storyboard = UIStoryboard(name: "Medical", bundle: nil)
				if isSaveMode {
					let controller = storyboard.instantiateViewController(withIdentifier: "TaskCompletedControllerID") as! TaskCompletedController
					controller.message = "Saved"
					controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
					self.present(controller, animated: false)// { controller.showMessage() }
				}
				else {
					let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
					controller.pageForm = self.shortcutModel!
					self.navigationController?.pushViewController(controller, animated: false)
				}
				
			}, failure: { error in print(error)
				
				var actions = [CVDAction] ()
				var alertTitle: String?
				var alertDescription : String?
				actions.append(CVDAction(title: "OK".localized, type: CVDActionType.cancel, handler: nil, short: true))
				alertTitle = isSaveMode ? "Failed to save evaluation".localized : "Failed to compute evaluation".localized
				alertDescription = error.localizedDescription
				
				self.stopAnimating()
				
				self.showCVDAlert(title: alertTitle!, message: alertDescription, actions: actions)
				
			})
		}
		else {
			self.stopAnimating()
			
			self.pageForm.form.status = .valued
			
			if !isSaveMode {
				let storyboard = UIStoryboard(name: "Medical", bundle: nil)
				let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
				controller.pageForm = self.shortcutModel!
				self.navigationController?.pushViewController(controller, animated: true)
			}
		}
	}
	
	
	
	//MARK: - EvaluationEditing protocol
	
	override func keyboardReturnDidPress(model: EvaluationItem) {
		guard nil != activeModel else { return }
		
		checkDependancies()
		
		repeat {
			if self.presentedViewController != nil {
				self.dismiss(animated: false, completion: nil)
			}
			
			let index = (modelChain as NSArray).index(of: activeModel!)
			if index < modelChain.count - 1 {
				activeModel = modelChain[index + 1]
			}
			else {
				self.hideKeyboard()
				return
			}
			
		} while nil != activeModel && activeModel!.form.isEnabled == false
		
		if let path = activeModel?.modelIndexPath {
			if let cell = tableView.cellForRow(at: path) as? GeneratedCell {
				activeField = cell.textField
				activeField?.isEnabled = true
				activeField?.becomeFirstResponder()
				
			} else {
				self.tableView.scrollToRow(at: path, at: UITableViewScrollPosition.middle, animated: false)
				if let cell = tableView.cellForRow(at: path) as? GeneratedCell {
					activeField = cell.textField
					activeField?.isEnabled = true
					activeField?.becomeFirstResponder()
				}
			}
		}
	}
	

	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pageForm.items.count
	}
	
	
	
	// MARK: - Table view delegates
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let itemModel = pageForm.items[indexPath.row]


		let cellType = itemModel.form.itemType
		let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier(), for: indexPath) as! GeneratedCell
		cell.delegate = self
		if cellType == .date {
			cell.textField?.inputView = self.datePicker
		}
		
		cell.cellModel = itemModel
		
		cell.updateCell()

		// Laboratories only logic
		//let classType = type(of:pageForm)
		//print("page class is %@", classType)
		//print("page class is %@", pageForm )
		if (pageForm is Laboratories) {
			//print(" we at laboratories one cell -")
			//print("    - cell title \(String(describing: cell.cellModel?.title)) -  at row \( indexPath.row) ")
			//print("    - cell id \(String(describing: itemModel.identifier)) -  at row \( indexPath.row) ")
			
			/*if let title = cell.cellModel?.identifier{
				print("  cell title \(title) at row %d", indexPath.row)
			}
			else {
				print("  cell title nl")
			}*/
		}
		
		/////
		
		switch itemModel.form.itemType {
			
		case .textLeft, .textRight, .integerLeft, .integerRight, .decimalLeft, .decimalRight:
			cell.selectionStyle = .none
			cell.textField?.borderStyle = UITextBorderStyle.none
			
		case .disclosureControl where itemModel.storedValue!.isChecked == false:
			cell.selectionStyle = .none
			
		case .disclosureControlWithCheck where itemModel.storedValue!.isChecked == false:
			cell.selectionStyle = .none
			
		case .disclosureRadio where itemModel.storedValue?.radioGroup!.selectedRadioItem != itemModel.identifier:
			
			cell.selectionStyle = .none
			
		case .disclosureVieved, .disclosureControl, .disclosureControlWithCheck, .disclosureSimple, .disclosureRadio, .disclosureWeather: // .disclosureControlExpandable is left out on purpose!
			cell.selectionStyle = .gray
		
		case .partnerCard:
			()
			
		default:
			cell.selectionStyle = .none
		}
		return cell
		
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let itemModel = pageForm.items[indexPath.row]
		switch itemModel.form.itemType {
			
		case .disclosureSimple, .disclosureVieved, .disclosureWeather,
		     .disclosureControl, // where itemModel.storedValue!.isChecked,
			  .disclosureControlWithCheck,
		     .disclosureRadio where itemModel.storedValue?.radioGroup!.selectedRadioItem == itemModel.identifier:
			
			if pageForm.identifier == "bioPAHMain" || validatePage() {
				let storyboard = UIStoryboard(name: "Medical", bundle: nil)
				
				if itemModel.identifier == identifierBy(literal: Presentation.pah) {
					let controller = storyboard.instantiateViewController(withIdentifier: "HypertensionControllerID") as! HypertensionController
					controller.pageForm = itemModel
					self.navigationController?.pushViewController(controller, animated: true)
				} else {
					let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
					controller.pageForm = itemModel
					controller.isHeartSpecilaistManagementPop = self.isHeartSpecilaistManagementPop
					//if (isHeartSpecilaistManagement) {
						controller.isHeartSpecilaistManagement = self.isHeartSpecilaistManagement
					//}
					self.navigationController?.pushViewController(controller, animated: true)
				}
			}
			
			hideKeyboard()
		 
		case .disclosureControlExpandable:
			//let cell = tableView.cellForRow(at: indexPath) as! RightIntegerCellExpandable
			//cellExpanded = !cellExpanded
			let cell = tableView.cellForRow(at: indexPath) as! DisclosureControlCellExpandable			
			itemModel.isExpanded = !itemModel.isExpanded
			cell.updateDisclosureIcon()
			tableView.beginUpdates()
			tableView.endUpdates()
			
		/*
		case .integerRightExpandable:
			//let cell = tableView.cellForRow(at: indexPath) as! RightIntegerCellExpandable
			//cellExpanded = !cellExpanded
			itemModel.isExpanded = !itemModel.isExpanded
			tableView.beginUpdates()
			tableView.endUpdates()
		*/
			
		default:
			()
			//print("not selected")
		}
	}
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let itemModel = pageForm.items[indexPath.row]
		
		if (itemModel.form.itemType == .disclosureSimpleExpandable) {
			if cellExpanded {
				return 150
			}
			else {
				return 55
			}
		}
		
		if (itemModel.form.itemType == .disclosureControlExpandable) {
			if itemModel.isExpanded {
				if itemModel.subCellsCount == 3{
					return 200
				}
				else if  itemModel.subCellsCount == 2{
					return 150
				}
				else { //if  itemModel.subCellsCount == 1{
					return 100
				}
			}
			else {
				return 55
			}
			
		}
		
		if (itemModel.form.itemType == .integerRightExpandable) {
				if itemModel.isExpanded {
					return 230
				}
				else {
					return 55
				}
			
		}
		
		if pageForm.title == DataManager.manager.evaluation!.outputInMain.title {
			if itemModel.subtitle == "No Result" {
				return 0
			}
		}
		
		return itemModel.calculateCellHeight(forWidth: self.view.frame.size.width)
	}
	
}
