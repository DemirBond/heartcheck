//
//  BaseTableController.swift
//  CVDEvaluator
//
//  Created by IgorKhomiak on 2/2/17.
//  Copyright © 2017 IgorKhomiak. All rights reserved.
//  Updated by EvrimGuler on 5/9/2017, 5/19/2017

import UIKit


class BaseTableController: UITableViewController, BuildAppearance, EvaluationEditing, FontChanging {
	
	var activeField: UITextField?
	var activeModel: EvaluationItem?
	var isCancelled = false
	
	var modelChain = [EvaluationItem]()
	var pageForm = EvaluationItem()
	
	var createdID: String! { return nil }
	var generatedID: String? { return nil }
	
	weak var styleController: StyleController?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupAppearance()
		evaluateResponderChain()
		checkDependancies()
		
		if pageForm.form.status == .open {
			pageForm.form.status = .viewed
		}
		
		//self.tableView.bounces = false
		self.tableView.showsVerticalScrollIndicator = false
		//self.tableView.backgroundColor = UIColor(palette: ColorPalette.hanPurple)
		self.tableView.backgroundColor = UIColor(palette: ColorPalette.white)
		
	}
	
	
	func setupAppearance() {
		
		self.clearsSelectionOnViewWillAppear = true
		
		self.view.backgroundColor = UIColor(palette: ColorPalette.snow)
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
		self.tableView.tableFooterView = UIView()
		
		let applyStyle = { (style: ControllerStyle) -> Void in
			guard let appearanceInfo = style.styleInfo() else { return }
			
			// TopBar
			let topSelectors: [Selector?] = [#selector(self.leftButtonAction(_:)),
			                                 #selector(self.rightTextButtonAction(_:)),
			                                 #selector(self.rightListButtonAction(_:)),
			                                 #selector(self.rightMenuButtonAction(_:))]
			let cvdTopbar = CVDTopbar(dict: appearanceInfo, target: self, actions: topSelectors)
			if nil != cvdTopbar.title {
				self.navigationItem.title = cvdTopbar.title
			}
			if nil != cvdTopbar.tintColor {
				self.navigationController?.navigationBar.tintColor = cvdTopbar.tintColor
			}
			if nil != cvdTopbar.leftBarItem {
				self.navigationItem.leftBarButtonItem = cvdTopbar.leftBarItem
			}
			
			var rightBarItems: [UIBarButtonItem] = []
			if nil != cvdTopbar.rightMenuBarItem {
				rightBarItems.append(cvdTopbar.rightMenuBarItem!)
			}
			if nil != cvdTopbar.rightListBarItem {
				rightBarItems.append(cvdTopbar.rightListBarItem!)
			}
			if nil != cvdTopbar.rightTextBarItem {
				rightBarItems.append(cvdTopbar.rightTextBarItem!)
			}
			self.navigationItem.rightBarButtonItems = rightBarItems
			
			// BottomBar
			let bottomSelectors: [Selector?] = [#selector(self.bottomRightButtonAction(_:)),
			                                    #selector(self.bottomRightButtonAction1(_:))]
			let cvdToolbar = CVDToolbar()
			cvdToolbar.setup(dict: appearanceInfo, target: self, actions: bottomSelectors)
			cvdToolbar.barTintColor = .white
			cvdToolbar.sizeToFit()
			self.toolbarItems = cvdToolbar.barItems
			
			self.navigationController?.toolbar.layer.shadowColor = UIColor(palette: ColorPalette.warmGrey)?.cgColor
			self.navigationController?.toolbar.layer.shadowOffset = CGSize(width: 1.0, height: -2.0)
			self.navigationController?.toolbar.layer.shadowRadius = 2.0
			self.navigationController?.toolbar.layer.shadowOpacity = 0.8
			self.navigationController?.toolbar.layer.masksToBounds = false
			
		}
		
		// get  User Interface Info
		if let styleID = self.generatedID, let style = ControllerStyle(rawValue: styleID) {
			applyStyle(style)
		} else if  let styleID = self.createdID , let style = ControllerStyle(rawValue: styleID) {
			applyStyle(style)
		}
	}
	
	
	func evaluateResponderChain() {
		
		var models = [EvaluationItem]()
		
		for (index, item) in pageForm.items.enumerated() {
			
			if [.textRight, .textLeft, .integerRight, .integerLeft, .decimalRight, .decimalLeft, .mail, .password, .date].contains(where: { $0 == item.form.itemType }) {
				item.modelIndexPath = IndexPath(row: index, section: 0)
				models.append(item)
			}
		}
		
		self.modelChain = models
	}
	
	
	func checkDependancies() {
		
		for depended in pageForm.items {
			guard let dependsOn = depended.dependancy?.dependsOn else { continue }
			
			for item in pageForm.items {
				if item.identifier == dependsOn {
					if let path = item.modelIndexPath {
						if let cell = tableView.cellForRow(at: path) as? GeneratedCell {
							let field = cell.textField
							item.storedValue?.value = field?.text
						}
					}
					
					if let str = item.storedValue?.value, let storedVal = Double(str),
						let minValue = depended.dependancy?.dependMinValue,
						let maxValue = depended.dependancy?.dependMaxValue {
						depended.form.isEnabled = storedVal >= minValue && storedVal <= maxValue
					}
					
					if let path = depended.modelIndexPath {
						if let cell = tableView.cellForRow(at: path) as? GeneratedCell {
							let field = cell.textField
							field?.isEnabled = depended.form.isEnabled
							cell.titleLabel?.textColor = depended.form.isEnabled ? CVDStyle.style.defaultFontColor : UIColor.lightGray
						}
					}
					
				}
			}
		}
	}
	
	
	func showCVDAlert(title: String, message: String?, actions: [CVDAction]) {
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		
		let controller = storyboard.instantiateViewController(withIdentifier: "CVDAlertControllerID") as! CVDAlertController
		controller.titleMessage = title
		controller.descriptionMessage = message
		controller.addActions(actions)
		
		controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		self.present(controller, animated: false)
	}
	
	
	func showDropMenu(actions: [MenuAction]) {
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		
		let controller = storyboard.instantiateViewController(withIdentifier: "SideMenuControllerID") as! SideMenuController
		controller.addActions(actions)
		
		controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		self.present(controller, animated: false)
	}
	
	
	
	// MARK: - Actions
	
	@IBAction func doneAction(_ sender: AnyObject) {
		hideKeyboard()
	}
	
	
	func leftButtonAction(_ sender: UIBarButtonItem) { /* tooverride */}
	func rightTextButtonAction(_ sender: UIBarButtonItem) {
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "StyleControllerID") as! StyleController
		controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		self.present(controller, animated: false) { () }
		styleController = controller
	}
	func rightListButtonAction(_ sender: UIBarButtonItem) { /* tooverride */}
	func rightMenuButtonAction(_ sender: UIBarButtonItem) { /* tooverride */}
	
	func bottomRightButtonAction(_ sender: UIBarButtonItem) { /* tooverride */}
	func bottomRightButtonAction1(_ sender: UIBarButtonItem) { /* tooverride */}
	
	
	func hideKeyboard() {
		activeField?.resignFirstResponder()
		self.activeField = nil
		self.activeModel = nil
		tableView.reloadData()
	}
	
	
	func createHandler(model: EvaluationItem, navigation: UINavigationController? ) -> CVDHandler {
		
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		let handler = {() in
			let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
			controller.pageForm = model
			navigation?.pushViewController(controller, animated: true)
		}
		return handler
	}
	
	
	func createPahHandler(model: EvaluationItem, navigation: UINavigationController? ) -> CVDHandler {
		
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		let handler = {() in
			let controller = storyboard.instantiateViewController(withIdentifier: "GeneratedControllerID") as! GeneratedController
			controller.pageForm = model
			navigation?.pushViewController(controller, animated: true)
			DataManager.manager.setPAHValue(pah: true)
			
			//DDataManager.manager.resetAllPAHItems()
			
			DataManager.manager.equalizeAllItems()
		}
		return handler
	}
	
	
	// MARK: - FontChanging delegate
	
	func userDidChoose(font: UIFont, withSize size: CGFloat) {
		CVDStyle.style.currentFont = font
		CVDStyle.style.currentFontSize = size
		
		styleController?.updateSelection()
		self.tableView.reloadData()
	}

	
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 0
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 0
	}
	
	
	
	//MARK: - EvaluationEditing protocol
	
	func evaluationFieldDidBeginEditing(_ textField: UITextField, model: EvaluationItem) {
		self.activeField = textField
		self.activeModel = model
		self.pageForm.form.status = .valued
	}
	
	
	func evaluationFieldTogglesDropDown() {
		tableView.beginUpdates()
		tableView.endUpdates()
	}
	
	
	func keyboardReturnDidPress(model: EvaluationItem){
	}

	
	func evaluationValueDidChange(model: EvaluationItem) {
		self.pageForm.form.status = .valued
		self.tableView.reloadData()
	}
	
	
	func evaluationValueDidEnter(_ textField: UITextField, model: EvaluationItem) {
		Timer.scheduledTimer(timeInterval: 0.1,
		                     target: self,
		                     selector: #selector(self.checkDependancies),
		                     userInfo: nil,
		                     repeats: false)

	}
	
	
	func evaluationValueDidNotValidate(model: EvaluationItem, message: String, description: String?) {
		
		guard !isCancelled else { return }
		let storyboard = UIStoryboard(name: "Medical", bundle: nil)
		
		let controller = storyboard.instantiateViewController(withIdentifier: "MessageControllerID") as! MessageController
		controller.message = message
		controller.descriptionMessage = description
		controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		self.present(controller, animated: false) { controller.showMessage() }
	}
	
}

