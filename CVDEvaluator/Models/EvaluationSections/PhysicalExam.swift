//
//  PhysicalExam.swift
//  CVDEvaluator
//
//  Created by bogdankosh on 2/13/17.
//  Copyright © 2017 IgorKhomiak. All rights reserved.
//

import Foundation


// MARK: - Physical Exam

class PhysicalExam: EvaluationItem {
	
	let neckveins = EvaluationItem(literal: Presentation.neckveins)
	let jugularVenousDistentionInPhysicalExam = EvaluationItem(literal: Presentation.jugularVenousDistentionInPhysicalExam)
	let bruitInPhysicalExam = EvaluationItem(literal: Presentation.bruitInPhysicalExam)
	let displacedPMIInPhysicalExam = EvaluationItem(literal: Presentation.displacedPMIInPhysicalExam)
	let leftSidedS3S4Gallop = EvaluationItem(literal: Presentation.leftSidedS3S4Gallop)
	let leftSidedS4Gallop = EvaluationItem(literal: Presentation.leftSidedS4Gallop)
	let frictionRubInPhysicalExam = EvaluationItem(literal: Presentation.frictionRubInPhysicalExam)
	let distantInPhysicalExam = EvaluationItem(literal: Presentation.distantInPhysicalExam)
	
	let heartMurmurInPhysicalExam = HeartMurmurInPhysicalExam(literal: Presentation.heartMurmurInPhysicalExam)
	
	let newRalesInPhysicalExam = EvaluationItem(literal: Presentation.newRalesInPhysicalExam)
	let pulmonaryEdemaInPhysicalExam = EvaluationItem(literal: Presentation.pulmonaryEdemaInPhysicalExam)
	let diminishedBreathSoundsInPhysicalExam = EvaluationItem(literal: Presentation.diminishedBreathSoundsInPhysicalExam)
	let rhonchiInPhysicalExam = EvaluationItem(literal: Presentation.rhonchiInPhysicalExam)
	let percussionInPhysicalExam = EvaluationItem(literal: Presentation.percussionInPhysicalExam)
	let thoraxInPhysicalExam = EvaluationItem(literal: Presentation.thoraxInPhysicalExam)	
	let abdominalTendernessInPhysicalExam = EvaluationItem(literal: Presentation.abdominalTendernessInPhysicalExam)
	let hepatojulularRefluxInPhysicalExam = EvaluationItem(literal: Presentation.hepatojulularRefluxInPhysicalExam)
	let ascitesInPhysicalExam = EvaluationItem(literal: Presentation.ascitesInPhysicalExam)
	let anyCNSSymptomsInPhysicalExam = EvaluationItem(literal: Presentation.anyCNSSymptomsInPhysicalExam)
	
	let abdominalBruit = EvaluationItem(literal: Presentation.abdominalbruitInPhysicalExam)
	let abnormalRightPulse = EvaluationItem(literal: Presentation.abnormalRightPulse)
	let abnormalLeftPulse = EvaluationItem(literal: Presentation.abnormalLeftPulse)
	
	let cyanosisInPhysicalExam = SectionCyanosis(literal: Presentation.cyanosisInPhysicalExam)
	
	let coldClammyExtremitiesInPhysicalExam = EvaluationItem(literal: Presentation.coldClammyExtremitiesInPhysicalExam)
	let clubbingInPhysicalExam = EvaluationItem(literal: Presentation.clubbingInPhysicalExam)
	let jaundiceSkinFindings = EvaluationItem(literal: Presentation.jaundiceSkinFindings)
	let edemaInPhysicalExam = EvaluationItem(literal: Presentation.edemaInPhysicalExam)
	let differenceinSBPInPhysicalExam = EvaluationItem(literal: Presentation.differenceinSBPInPhysicalExam)
	let costovertebralFindings = EvaluationItem(literal: Presentation.costovertebralFindings)
	
	// title labels
	let neckLabel = EvaluationItem(literal: Presentation.peneckLabel)
	let heartLabel = EvaluationItem(literal: Presentation.peheartLabel)
	let pAndTLabel = EvaluationItem(literal: Presentation.pepandtLabel)
	let abdominalLabel = EvaluationItem(literal: Presentation.peabdominalLabel)
	let GULabel = EvaluationItem(literal: Presentation.peGULabel)
	let sAndELabel = EvaluationItem(literal: Presentation.peSandELabel)
	let cnsLabel = EvaluationItem(literal: Presentation.pecnsLabel)
	let vascularLabel = EvaluationItem(literal: Presentation.pevascularLabel)

	
	
	override var items: [EvaluationItem] {
		return [
			// Neck Group
			neckLabel,
			neckveins,
			jugularVenousDistentionInPhysicalExam,
			bruitInPhysicalExam,
			
			// Heart Group
			heartLabel,
			heartMurmurInPhysicalExam,
			distantInPhysicalExam,
			leftSidedS3S4Gallop,
			leftSidedS4Gallop,
			frictionRubInPhysicalExam,
			displacedPMIInPhysicalExam,

			// Pulmonary and Thorax Group
			pAndTLabel,
			thoraxInPhysicalExam,
			percussionInPhysicalExam,
			newRalesInPhysicalExam,
			pulmonaryEdemaInPhysicalExam,
			rhonchiInPhysicalExam,
			diminishedBreathSoundsInPhysicalExam,
	
			// Abdominal
			abdominalLabel,
			abdominalTendernessInPhysicalExam,
			hepatojulularRefluxInPhysicalExam,
			ascitesInPhysicalExam,

			// GU
			GULabel,
			costovertebralFindings,
			
			
			// Skin and Extremities
			sAndELabel,
			coldClammyExtremitiesInPhysicalExam,
			cyanosisInPhysicalExam,
			edemaInPhysicalExam,
			clubbingInPhysicalExam,
			jaundiceSkinFindings,
			
			// CNS
			cnsLabel,
			anyCNSSymptomsInPhysicalExam,

			// Vascular
			vascularLabel,
			abnormalRightPulse,
			abnormalLeftPulse,
			abdominalBruit,
			
			
			// Extra
			differenceinSBPInPhysicalExam,
		
		]
	}
}


// MARK: - Physical Exam -> Heart Murmur

class HeartMurmurInPhysicalExam: EvaluationItem {
	
	let abnormalAuscultationLabel = EvaluationItem(literal: Presentation.abnormalAuscultationLabel)
	let s1Mitral = S1Mitral(literal: Presentation.s1Mitral)
	let s2Aortic = S2Aortic(literal: Presentation.s2Aortic)
	let p2Pulmonic = P2Pulmonic(literal: Presentation.p2Pulmonic)
	let s1Tricuspid = S1Tricuspid(literal: Presentation.s1Tricuspid)
	let murmur = Murmur(literal: Presentation.murmur)
//	let systolicMurmur = SystolicMurmur(literal: Presentation.systolicMurmur)
//	let diastolicMurmur = DiastolicMurmur(literal: Presentation.diastolicMurmur)
	
	override var items: [EvaluationItem] {
		return [
			abnormalAuscultationLabel,
			s1Mitral,
			s2Aortic,
			p2Pulmonic,
			s1Tricuspid,
			murmur
		]
	}
	
	class S1Mitral: EvaluationItem {
		
		let blnS1MitralLoud = EvaluationItem(literal: Presentation.blnS1MitralLoud)
		let blnS1MitralNormal = EvaluationItem(literal: Presentation.blnS1MitralNormal)
		let blnS1MitralSoft = EvaluationItem(literal: Presentation.blnS1MitralSoft)
		
		override var items: [EvaluationItem] {
			return [
				blnS1MitralLoud,
				blnS1MitralNormal,
				blnS1MitralSoft
			]
		}
	}
	
	class S2Aortic: EvaluationItem {
		
		let blnS2AorticLoud = EvaluationItem(literal: Presentation.blnS2AorticLoud)
		let blnS2AorticNormal = EvaluationItem(literal: Presentation.blnS2AorticNormal)
		let blnS2AorticSoft = EvaluationItem(literal: Presentation.blnS2AorticSoft)
		
		override var items: [EvaluationItem] {
			return [
				blnS2AorticLoud,
				blnS2AorticNormal,
				blnS2AorticSoft
			]
		}
	}
	
	class P2Pulmonic: EvaluationItem {
		
		let blnP2PulmonicLoud = EvaluationItem(literal: Presentation.blnP2PulmonicLoud)
		let blnP2PulmonicNormal = EvaluationItem(literal: Presentation.blnP2PulmonicNormal)
		let blnP2PulmonicSoft = EvaluationItem(literal: Presentation.blnP2PulmonicSoft)
		
		override var items: [EvaluationItem] {
			return [
				blnP2PulmonicLoud,
				blnP2PulmonicNormal,
				blnP2PulmonicSoft
			]
		}
	}
	
	class S1Tricuspid: EvaluationItem {
		
		let blnP2TricuspidLoud = EvaluationItem(literal: Presentation.blnP2TricuspidLoud)
		let blnP2TricuspidNormal = EvaluationItem(literal: Presentation.blnP2TricuspidNormal)
		let blnP2TricuspidSoft = EvaluationItem(literal: Presentation.blnP2TricuspidSoft)
		
		override var items: [EvaluationItem] {
			return [
				blnP2TricuspidLoud,
				blnP2TricuspidNormal,
				blnP2TricuspidSoft
			]
		}
	}
	
	class Murmur: EvaluationItem {
		
		let systolicMurmur = SystolicMurmur(literal: Presentation.systolicMurmur)
		let diastolicMurmur = DiastolicMurmur(literal: Presentation.diastolicMurmur)
		
		override var items: [EvaluationItem] {
			return [
				systolicMurmur,
				diastolicMurmur
			]
		}
	}
	
	class SystolicMurmur: EvaluationItem {
		
		let blnCresDecres = CrescendoDecrescendo(literal: Presentation.blnCresDecres)
		let blnPlateuShaped = PlateuShaped(literal: Presentation.blnPlateuShaped)
		let blnsquat = EvaluationItem(literal: Presentation.blnsquat)
		let blnejectionsound = EvaluationItem(literal: Presentation.blnejectionsound)
		let blnsystolicclick = EvaluationItem(literal: Presentation.blnsystolicclick)
		
		override var items: [EvaluationItem] {
			return [
				blnCresDecres,
				blnPlateuShaped,
				blnsquat,
				blnejectionsound,
				blnsystolicclick
			]
		}
	}
	
	class CrescendoDecrescendo: EvaluationItem {
		
		let blnEarlyMidSysPeak = EvaluationItem(literal: Presentation.blnEarlyMidSysPeak)
		let blnLateSysPeak = EvaluationItem(literal: Presentation.blnLateSysPeak)
		
		override var items: [EvaluationItem] {
			return [
				blnEarlyMidSysPeak,
				blnLateSysPeak
			]
		}
	}
	
	class PlateuShaped: EvaluationItem {
		
		let blnHalosystolic = EvaluationItem(literal: Presentation.blnHalosystolic)
		let blnPansystolic = EvaluationItem(literal: Presentation.blnPansystolic)
		let blnMidsystolic = EvaluationItem(literal: Presentation.blnMidsystolic)
		
		override var items: [EvaluationItem] {
			return [
				blnHalosystolic,
				blnPansystolic,
				blnMidsystolic
			]
		}
	}
	
	class DiastolicMurmur: EvaluationItem {
		
		let blnDescrescendo = EvaluationItem(literal: Presentation.blnDescrescendo)
		let blnRumble = EvaluationItem(literal: Presentation.blnRumble)
		let mitralOpeningSnap = EvaluationItem(literal: Presentation.mitralOpeningSnap)
		
		let diffusePain = EvaluationItem(literal: Presentation.diffusePain)
		let localizedPain = EvaluationItem(literal: Presentation.localizedPain)
		
		let seperator = EvaluationItem(literal: Presentation.separator)
		
		override var items: [EvaluationItem] {
			return [
				blnDescrescendo,
				blnRumble,
				mitralOpeningSnap,
				
				seperator,
				
				diffusePain,
				localizedPain
				
			]
		}
	}
}


// MARK: - Physical Exam -> Cyanosis

class SectionCyanosis: EvaluationItem {
	
	let centralSectioncyanosis = EvaluationItem(literal: Presentation.centralSectioncyanosis)
	let peripheralSectioncyanosis = EvaluationItem(literal: Presentation.peripheralSectioncyanosis)
	
	override var items: [EvaluationItem] {
		return [
			centralSectioncyanosis,
			peripheralSectioncyanosis
		]
	}
}


