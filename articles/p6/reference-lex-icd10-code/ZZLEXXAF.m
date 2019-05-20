ZZLEXXAF ;SLC/KER - Import - ICD-10-CM - Code Listing ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^ZZLEXX("ZZLEXXA"   SACC 1.3
 ;    ^ZZLEXX("ZZLEXXACL" SACC 1.3
 ;               
 ; External References
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     CNT
 ;               
 Q
CL ; Code Listing
 N ACT,COL,ORD,TT S TT=0 F ACT="AD","IA","RA","RU","SR","FR","BR" S TT=TT+($G(CNT(ACT)))
 Q:'$D(^ZZLEXX("ZZLEXXA",$J))  W:TT'>0 ! W !," Code Listing "
 S COL=0 K ^ZZLEXX("ZZLEXXACL",$J)
 S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXA",$J,"ICD",ORD)) Q:'$L(ORD)  D
 . N ACT,COD,EFF,FIL,IEN,NEW
 . S ACT=$G(^ZZLEXX("ZZLEXXA",$J,"ICD",ORD,"AC")) Q:'$L(ACT)  Q:ACT="NC"
 . S COD=$TR(ORD," ","") Q:'$L(COD)
 . S FIL=$E((COD_"           "),1,10) Q:'$L(FIL)
 . S NEW=ACT S:NEW="SR"!(NEW="FR")!(NEW="BR") NEW="RV"
 . Q:"^AD^IA^RU^RV^RA^"'[("^"_NEW_"^")
 . I '$D(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW)) D
 . . S EFF=$G(^ZZLEXX("ZZLEXXA",$J,"ICD",ORD,"AD","LOAD")) Q:EFF'?7N
 . . S ^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"EFF")=("Effective "_$$FMTE^XLFDT(EFF))
 . S ^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"TOT")=$G(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"TOT"))+1
 . S ^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"ORD",ORD)=FIL
 F NEW="AD","IA","RU","RV","RA" D
 . N COL S COL=0 S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"ORD",ORD)) Q:'$L(ORD)  D
 . . N FIL S FIL=$G(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"ORD",ORD))
 . . S COL=COL+1 I COL=1 S IEN=$O(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"LIST"," "),-1)+1 D  Q
 . . . S ^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"LIST",IEN)="         "_FIL S COL=1
 . . S IEN=+($O(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"LIST"," "),-1))
 . . S ^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"LIST",IEN)=$G(^ZZLEXX("ZZLEXXACL",$J,"ICD",NEW,"LIST",IEN))_FIL
 . . S:COL>6 COL=0
 D CLOUT
 Q
CLOUT ; Code Listing Output
 N ACT S ACT="" F  S ACT=$O(^ZZLEXX("ZZLEXXACL",$J,"ICD",ACT)) Q:'$L(ACT)  D
 . N IEN,CAT,SEC,LIN,EFF,TOT
 . S CAT="" S:ACT="AD" CAT="Additions" S:ACT="IA" CAT="Inactivations" S:ACT="RU" CAT="Re-Used"
 . S:ACT="RV" CAT="Revisions" S:ACT="RA" CAT="Reactivations"
 . S SEC="ICD-10 Diagnosis "_CAT
 . S LIN="",$P(LIN,"-",$L(SEC))="-" S:$L(LIN) LIN="     "_LIN S:$L(SEC) SEC="     "_SEC
 . W:$L(CAT) !!,SEC,!,LIN,!
 . S TOT=$G(^ZZLEXX("ZZLEXXACL",$J,"ICD",ACT,"TOT")) S:+TOT'>0 TOT=""
 . S:+TOT>0 TOT="("_+TOT_" code"_$S(+TOT>1:"s",1:"")_")"
 . S EFF=$G(^ZZLEXX("ZZLEXXACL",$J,"ICD",ACT,"EFF"))
 . S:$G(TOT)["(" EFF=EFF_$J("",(51-$L(EFF)))_$J($G(TOT),11)
 . I $L(EFF) W !,"       ",EFF
 . S IEN=0 F  S IEN=$O(^ZZLEXX("ZZLEXXACL",$J,"ICD",ACT,"LIST",IEN)) Q:+IEN'>0  D
 . . W !,$$TR($G(^ZZLEXX("ZZLEXXACL",$J,"ICD",ACT,"LIST",IEN)))
 Q
KILL ;   Kill Global
 D KILL^ZZLEXXAA
 Q
TR(X) ;   Strip Trailing Spaces
 S X=$G(X) F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
