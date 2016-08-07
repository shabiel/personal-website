# How objective are drug-drug interactions?
A Review of the literature regarding classifyig drug interactions and mandatory alerting in EMRs

Sam Habiel, Pharm.D.

sam.habiel@gmail.com

@givethgoodmumps

---

## Objectives

 * Identify at least one public drug drug interaction source; and discuss why there is a public health need for one.
 * Discuss the problem with classifying severeties on drug-drug interactions.
 * Identify ways to reduce alert fatigue due to drug-related alerts.
---
## Hollywood view of drug interactions

<https://www.youtube.com/watch?v=viK121c8iZI>
---
## About me

 * Graduated in 2004 with Pharm.D.
 * Far more interested in computers than drugs.
---
## Do you know this interaction?

 * Ribavarin / Zidovudine

Rated as critical in the program that we were using.

Resulted in phone calls.

Rated as significant in the VA-NDF.
---
## How about?
 * HCTZ/Atenolol
 * ASA/Warfarin
 * Simvastatin/Fluconazole
 * ASA/MTX
 * BBs/SUs
 * Gemfibrozil/Simvastatin
 * MAOIs/Methylphenidate
---
## A borrowed slide
![Risperidone ixn](./risperidone.png)
---
## Black box warning contraindicated comedications
Ann Pharmacother. 2010 Jan. doi: 10.1345/aph.1M475. PMID: 20040698.

 * To determine the level of agreement in presence, clinical severity scores level of documentation ratings, and alert content among 3 leading drug interaction screening programs with regard to contraindicated comedications that are mentioned in black box warnings.

--

 * We identified 11 drugs with black box warnings that contained information on 59 unique contraindicated drug combinations, only 68% of which were covered by any source. Lexi-Comp detected the most interactions (n = 29) and DRUG-REAX the least (n = 18). Only 3 drug combinations were detected and rated as contraindicated or potentially life-threatening in all 3 databases. The severity scores and level of documentation ratings varied widely.
---
## Ability of pharmacy clinical decision-support software to alert users about clinically important drug-drug interactions
J Am Med Inform Assoc. 2011 Jan-Feb doi: 10.1136/jamia.2010.007609. PMID: 21131607

--

 * Researchers made on-site visits to 64 participating Arizona pharmacies between December 2008 and November 2009 to analyze the ability of pharmacy information systems and associated CDS to detect DDIs.
 * The sensitivity, specificity, positive predictive value, negative predictive value, and percentage of correct responses were measured for each of the pharmacy CDS systems.

--

 * Only 18 (28%) of the 64 pharmacies correctly identified eligible interactions and non-interactions. The median percentage of correct DDI responses was 89% (range 47-100%) for participating pharmacies. The median sensitivity to detect well-established interactions was 0.85 (range 0.23-1.0); median specificity was 1.0 (range 0.83-1.0); median positive predictive value was 1.0 (range 0.88-1.0); and median negative predictive value was 0.75 (range 0.38-1.0)

--

 * Community pharmacies failed to detect approximately one in 12 clinically significant DDIs, while hospital pharmacy systems failed to detect approximately one in four DDIs.

 * In addition, systems in other settings incorrectly categorized approximately one in seven of the DDIs evaluated.

---
## Pharmacist recognition of potential drug interactions
Am J Health Syst Pharm. 1999 Aug 1;56(15):1524-9. PMID: 10478990

* The subjects detected only 66% of the interactions in the 2-drug profiles, 34% of the interactions in the 4-drug profiles, 20% of the interactions in the 8-drug profiles, and 17% of the interactions in the 16-drug profile.

---

## Concordance of severity ratings provided in four drug interaction compendia
J Am Pharm Assoc (2003). 2004 Mar-Apr;44(2):136-41. PMID: 15098847.

 * Little agreement exists among commonly used drug interaction COMPENDIA for DDIs that were classified in fall 2001 as having the highest clinical relevance and importance.

---

## Comparison of critical drug-drug interaction listings: the Department of Veterans Affairs medical system and standard reference compendia
Clin Pharmacol Ther. 2010 Jan;87(1):48-51. doi: 10.1038/clpt.2009.198. PMID: 19890252

--

 * A list of critical DDIs, as defined by the VA, was compared with two standard commercially available compendia (Micromedex DRUG-REAX and Drug Interactions: Analysis and Management (DIAM)) in order to determine the level of agreement among the systems.
 * Of 982 DDIs classified as critical by the VA, only 136 DDIs (13.7%) were considered critical in all three systems.
 * VA has since switched to FDB, but made 44,000 changes to FDB data

---

## Inconsistencies and misleading information in officially approved prescribing information from three major drug markets.
Clin Pharmacol Ther. 2014 Nov;96(5):616-24. doi: 10.1038/clpt.2014.156. PMID: 25062063
 
 * Reciprocal warnings regarding drug-drug interactions that constitute contraindications were frequently missing in the SPCs of the drugs concerned (all countries >40%).

--

 * Most SPCs did not explicitly exclude adverse reactions considered not reasonably attributable to the use of the drug. 
 * Comparing SPCs of different generic brands of the same drug, only 60, 10, and 20% of the US, UK, and German SPCs, respectively, provided identical contraindications.

---

## Open source drug interaction compendia
<https://en.wikipedia.org/wiki/Open-source_software>

* Open-source software (OSS) is computer software with its source code made available with a license in which the copyright holder provides the rights to study, change, and distribute the software to anyone and for any purpose. Open-source software may be developed in a collaborative public manner.

--

* Advantage: Can actually study ALL interactions; not just pieces from here and there.
* Advantage: Typically internet based and available in multiple formats.

--

## What's out there?

--
## Toward a complete dataset of drug-drug interaction information from publicly available sources
J Biomed Inform. 2015 Jun;55:206-17. doi: 10.1016/j.jbi.2015.04.006. PMID: 25917055

* 15 Data sources

--
 * Crediblemeds.org
 * VA NDF-RT
 * ONC High Priority
 * ONC Non-interruptive
 * OSCAR
 * DDI Corpus 2011
 * DDI Corpus 2013
 * PK DDI Corpus

--
* NLM CV DDI Corpus
* KEGG DDI
* TWOSIDES
* DrugBank
* DIKB
* SemMedDB
* And... French ANSM dataset
(Agence nationale de sécurité du médicament et des produits de santé)

--
For us, we are most interested in the ANSM, ONC lists, and VA NDF. Overlap statistics are interesting:

 * ANSM/VA NDF: 40% (from Dr. Richard Boyce)
 * ANSM/ONC HP: 25% (from Dr. Richard Boyce)
 * VA NDF/ONC HP: 20% (study)
 * VA NDF/ONC NI: 1.3% (study)

