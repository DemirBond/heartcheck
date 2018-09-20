//
//  Diagnostics.swift
//  CVDEvaluator
//
//  Created by bogdankosh on 2/14/17.
//  Copyright © 2017 IgorKhomiak. All rights reserved.
//

import Foundation


// MARK: - Diagnostics

class Diagnostics: EvaluationItem {
	
	let ekg = EKG(literal: Presentation.ekg)
	let stressTesting = StressTesting(literal: Presentation.stressTesting)
	let echocardiography = Echocardiography(literal: Presentation.echocardiography)
	let chestXRay = ChestXRay(literal: Presentation.chestXRay)
	let hrct = HRCT(literal: Presentation.hrct)
	let rhc = RHC(literal: Presentation.rhc)
	let coronaryCalciumScore = EvaluationItem(literal: Presentation.coronaryCalciumScore)
	let total = EvaluationItem(literal: Presentation.total)

	override var items: [EvaluationItem] {
		return [
			ekg,
			stressTesting,
			echocardiography,
			chestXRay,
			hrct,
			rhc,
			coronaryCalciumScore,
			total
		]
	}
}


// MARK: - Diagnostics -> EKG

class EKG: EvaluationItem {
	
	let NSRInEKG = EvaluationItem(literal: Presentation.nsrInEKG)
	let svt = EvaluationItem(literal: Presentation.svt)
	let atrialFibrillationInEKG = EvaluationItem(literal: Presentation.atrialFibrillationInEKG)
	let atrialFlutter = AtrialFlutter(literal: Presentation.atrialFlutter)
	let prDuration  = EvaluationItem(literal: Presentation.prDuration)
	let qrsDuration = EvaluationItem(literal: Presentation.qrsDuration)
	let qrsAxisDegree = EvaluationItem(literal: Presentation.qrsaxisdegree)
	let qtcmsec = EvaluationItem(literal: Presentation.qtcmsec)
	
	let nonspecificSTAbnormality = EvaluationItem(literal: Presentation.nonspecificSTAbnormality)
	let stDeviation05mm = EvaluationItem(literal: Presentation.stDeviation05mm)
	let tWaveInversion1mm = EvaluationItem(literal: Presentation.tWaveInversion1mm)
	let lvh = EvaluationItem(literal: Presentation.lvh)
	let lowVoltageQRS = EvaluationItem(literal: Presentation.lowVoltageQRS)
	let abnormalQWaves = EvaluationItem(literal: Presentation.abnormalQWaves)
	let lbbb = LBBB(literal: Presentation.lbbb)
//	let completeLBBB = EvaluationItem(literal: Presentation.bifascicular)
//	let lahb = EvaluationItem(literal: Presentation.lahb)
//	let lphb = EvaluationItem(literal: Presentation.lphb)
	
	let wpw = EvaluationItem(literal: Presentation.wpw)
	let vpace = EvaluationItem(literal: Presentation.vpace)
	let rbbb = EvaluationItem(literal: Presentation.rbbb)
	let intraventicularBlock = EvaluationItem(literal: Presentation.intraventicularBlock)
	let atrialPrematureDepolarization = EvaluationItem(literal: Presentation.atrialPrematureDepolarization)
	let junctionalPrematureDepolarization = EvaluationItem(literal: Presentation.junctionalPrematureDepolarization)
	let frequentVentricularPacingOrEctopy = EvaluationItem(literal: Presentation.frequentVentricularPacingOrEctopy)
	let infrequentVentricularPacingOrEctopy = EvaluationItem(literal: Presentation.infrequentVentricularPacingOrEctopy)
	let firstDegreeAVBlock = EvaluationItem(literal: Presentation.firstDegreeAVBlock)
	let secondDegreeAVBlock = SecondDegreeAVBlock(literal: Presentation.secondDegreeAVBlock)
	let thirdDegreeAVBlock = EvaluationItem(literal: Presentation.thirdDegreeAVBlock)
	
	//EKG Seperated Categories
	let titleRhytm = EvaluationItem(literal: Presentation.ekgTitleRhtym)
	let titleConduction = EvaluationItem(literal: Presentation.ekgTitleConduction)
	let titleAbnormalVolt = EvaluationItem(literal: Presentation.ekgTitleAbnormalVolt)
	let titleEctopy = EvaluationItem(literal: Presentation.ekgTitleEctopy)
	let titleSTabnormal = EvaluationItem(literal: Presentation.ekgTitleSTAbnormality)
	
	
//	let urineNaMeqlInEKG = EvaluationItem(literal: Presentation.urineNaMeqlInEKG)
//	let serumOsmolalityInEKG = EvaluationItem(literal: Presentation.serumOsmolalityInEKG)
//	let stressTestingInEKG = EvaluationItem(literal: Presentation.stressTestingInEKG)

	override var items: [EvaluationItem] {
		return [
			prDuration,
			qrsDuration,
			qrsAxisDegree,
			qtcmsec,
			
			titleRhytm,
				NSRInEKG,
				svt,
				atrialFibrillationInEKG,
				atrialFlutter,
			
			titleConduction,
				firstDegreeAVBlock,
				secondDegreeAVBlock,
				thirdDegreeAVBlock,
				lbbb,
				rbbb,
				intraventicularBlock,
			
			titleAbnormalVolt,
				lowVoltageQRS,
				abnormalQWaves,
				wpw,
				vpace,
				lvh,
			
			titleEctopy,
				junctionalPrematureDepolarization,
				frequentVentricularPacingOrEctopy,
				atrialPrematureDepolarization,
				infrequentVentricularPacingOrEctopy,
			
			
			titleSTabnormal,
				stDeviation05mm,
				tWaveInversion1mm,
				nonspecificSTAbnormality,
			

			

		]
	}
}


// MARK: - Diagnostics -> EKG -> AtrialFlutter

class AtrialFlutter: EvaluationItem {
	
	let typicalAF = EvaluationItem(literal: Presentation.typicalAF)
	let atypicalAF = EvaluationItem(literal: Presentation.atypicalAF)
	
	override var items: [EvaluationItem] {
		return [typicalAF, atypicalAF]
	}
}

// MARK: - Diagnostics -> EKG -> LBBB

class LBBB: EvaluationItem {
	let completeLBBB = EvaluationItem(literal: Presentation.bifascicular)
	let lahb = EvaluationItem(literal: Presentation.lahb)
	let lphb = EvaluationItem(literal: Presentation.lphb)
	
	override var items: [EvaluationItem] {
		return [completeLBBB, lahb, lphb]
	}
	
}



// MARK: - Diagnostics -> EKG -> SecondDegreeAVBlock

class SecondDegreeAVBlock: EvaluationItem {
	
	let type1 = EvaluationItem(literal: Presentation.type1)
	let type2 = EvaluationItem(literal: Presentation.type2)
	
	override var items: [EvaluationItem] {
		return [type1, type2]
	}
}


// MARK: - Diagnostics -> Stress Testing

class StressTesting: EvaluationItem {
	
	let dukeTreadmillScore = EvaluationItem(literal: Presentation.dukeTreadmillScore)
	let serumStressSummedScore = EvaluationItem(literal: Presentation.serumStressSummedScore)
	let stressDifferenceScore = EvaluationItem(literal: Presentation.stressDifferenceScore)
	let percentIschemicMyocardiumonMPS = EvaluationItem(literal: Presentation.percentIschemicMyocardiumonMPS)
	let stressTestTID = EvaluationItem(literal: Presentation.stressTestTID)
	let significantDysfunction = EvaluationItem(literal: Presentation.significantDysfunction)
	let exTimeMin = EvaluationItem(literal: Presentation.exTimeMin)
	let maxSTMm = EvaluationItem(literal: Presentation.maxSTMm)
	let anginaIndex = AnginaIndex(literal: Presentation.anginaIndex)
	let stElevation = EvaluationItem(literal: Presentation.stElevation)
	let abnormalBPResponse = EvaluationItem(literal: Presentation.abnormalBPResponse)
	let ventricularTachycardia = EvaluationItem(literal: Presentation.ventricularTachycardia)
	let prolongSTDepression = EvaluationItem(literal: Presentation.prolongSTDepression)
	let fixedPerfusionDefects = FixedPerfusionDefects(literal: Presentation.fixedPerfusionDefects)
	let dseIschemicThreshold = EvaluationItem(literal: Presentation.dseIschemicThreshold)
	let dseOrStressMRI = EvaluationItem(literal: Presentation.dseOrStressMRI)
	let artifactualUninterpretableImages = EvaluationItem(literal: Presentation.artifactualUninterpretableImages)
	let akineticDyskineticWMA = EvaluationItem(literal: Presentation.akineticDyskineticWMA)
	
	let titleNuclearImaging = EvaluationItem(literal: Presentation.stTitleNuclearImaging)
	let titleDobutaminStress = EvaluationItem(literal: Presentation.stTItleDobutaminStressEcho)
	let titleETT = EvaluationItem(literal: Presentation.stTitleETT)
	
	override var items: [EvaluationItem] {
		return [
			titleETT,
				exTimeMin,
				maxSTMm,
				dukeTreadmillScore,
				stElevation,
				abnormalBPResponse,
				ventricularTachycardia,
				prolongSTDepression,
				anginaIndex,
			
			titleNuclearImaging,
				serumStressSummedScore,
				stressDifferenceScore,
				percentIschemicMyocardiumonMPS,
				fixedPerfusionDefects,
				stressTestTID,
				artifactualUninterpretableImages,
			
			titleDobutaminStress,
				dseIschemicThreshold,
				dseOrStressMRI,
				significantDysfunction,
				akineticDyskineticWMA,
			

			
		]
	}
}


// MARK: - Diagnostics -> Stress Testing -> AnginaIndex

class AnginaIndex: EvaluationItem {
	
	let noAnginaDuringExercise = EvaluationItem(literal: Presentation.noAnginaDuringExercise)
	let nonLimitingAngina = EvaluationItem(literal: Presentation.nonLimitingAngina)
	let exerciseLimitingAngina = EvaluationItem(literal: Presentation.exerciseLimitingAngina)
	
	override var items: [EvaluationItem] {
		return [
			noAnginaDuringExercise,
			nonLimitingAngina,
			exerciseLimitingAngina
		]
	}
}


// MARK: - Diagnostics -> Stress Testing -> Fixed Perfusion Defects

class FixedPerfusionDefects: EvaluationItem {
	
	let viabilityPresent = EvaluationItem(literal: Presentation.viabilityPresent)
	
	override var items: [EvaluationItem] {
		return [viabilityPresent]
	}
}


// MARK: - Diagnostics -> Echocardiography

class Echocardiography: EvaluationItem {
	
	let pericardialEffusion = EvaluationItem(literal: Presentation.pericardialEffusion)
	let rwma = EvaluationItem(literal: Presentation.rwma)
	let enlargedLAOrLVH = EvaluationItem(literal: Presentation.enlargedLAOrLVH)
	let ea05AndDTMore280ms = EvaluationItem(literal: Presentation.ea05AndDTMore280ms)
	let gradeMore2DiastolicDysfunction = EvaluationItem(literal: Presentation.gradeMore2DiastolicDysfunction)
	let respiratoryIVSShift = EvaluationItem(literal: Presentation.respiratoryIVSShift)
	let mitralEVariation = EvaluationItem(literal: Presentation.mitralEVariation)
	let hepaticVeinExpDiastolicReversal = EvaluationItem(literal: Presentation.hepaticVeinExpDiastolicReversal)
	let enlargedRA = EvaluationItem(literal: Presentation.enlargedRA)
	let enlargedRV = EvaluationItem(literal: Presentation.enlargedRV)
	let midsystolicNotch = EvaluationItem(literal: Presentation.midsystolicNotch)
	let lvLaterealAnnulusEE = EvaluationItem(literal: Presentation.lvLaterealAnnulusEE)
	let lvefInEchocardiography = EvaluationItem(literal: Presentation.lvefInEchocardiography)
	let trjVelocityMsec = EvaluationItem(literal: Presentation.trjVelocityMsec)
	
	let titleLVFunc = EvaluationItem(literal: Presentation.echoTitleLVFunc)
	let titleRVFunc = EvaluationItem(literal: Presentation.echoTitleRVFunc)
	let titlePericardium = EvaluationItem(literal: Presentation.echoTitlePericardium)
	
	override var items: [EvaluationItem] {
		return [
			titleLVFunc,
				lvefInEchocardiography,
				rwma,
				lvLaterealAnnulusEE,
				enlargedLAOrLVH,
				ea05AndDTMore280ms,
				gradeMore2DiastolicDysfunction,
				
			titleRVFunc,
				trjVelocityMsec,
				enlargedRA,
				enlargedRV,
				midsystolicNotch,
				
			titlePericardium,
				pericardialEffusion,
				respiratoryIVSShift,
				mitralEVariation,
				hepaticVeinExpDiastolicReversal,

		]
	}
}


// MARK: - Diagnostics -> Chest X-Ray

class ChestXRay: EvaluationItem {
	
	let rightPleuralEffusion = EvaluationItem(literal: Presentation.rightPleuralEffusion)
	let leftPleuralEffusion = EvaluationItem(literal: Presentation.leftPleuralEffusion)
	let pulmonaryEdema = EvaluationItem(literal: Presentation.pulmonaryEdema)
	let enlargedCardiacSolhouette = EvaluationItem(literal: Presentation.enlargedCardiacSolhouette)
	let widenedMediasteneum = EvaluationItem(literal: Presentation.widenedMediasteneum)
	let pneumothorax = EvaluationItem(literal: Presentation.pneumothorax)
	let infiltrate = EvaluationItem(literal: Presentation.infiltrate)
	let consolidation = EvaluationItem(literal: Presentation.consolidation)
	
	override var items: [EvaluationItem] {
		return [
			rightPleuralEffusion,
			leftPleuralEffusion,
			pulmonaryEdema,
			enlargedCardiacSolhouette,
			widenedMediasteneum,
			pneumothorax,
			infiltrate,
			consolidation
		]
	}
}


// MARK: - Diagnostics -> High Resolution CT

class HRCT: EvaluationItem {
	
	let ground = EvaluationItem(literal: Presentation.ground)
	let septal = EvaluationItem(literal: Presentation.septal)
	let reticular = EvaluationItem(literal: Presentation.reticular)
	let nodular = EvaluationItem(literal: Presentation.nodular)
	let consolidate = EvaluationItem(literal: Presentation.consolidate)
	let honey = EvaluationItem(literal: Presentation.honey)
	let bronch = EvaluationItem(literal: Presentation.bronch)
	let medias = EvaluationItem(literal: Presentation.medias)
	let pleuralthick = EvaluationItem(literal: Presentation.pleuralthick)
	
	override var items: [EvaluationItem] {
		return [
			ground,
			septal,
			reticular,
			nodular,
			consolidate,
			honey,
			bronch,
			medias,
			pleuralthick
		]
	}
}

// MARK: - Diagnostics -> RHC

class RHC: EvaluationItem {
	
}
