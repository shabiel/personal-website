ZZLEXXDD ;SLC/KER - Import - ICD-10-CM Cat - Load ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^LEX(757.03,        SACC 1.3
 ;    ^LEX(757.033,       SACC 1.3
 ;    ^ZZLEXX("ZZLEXXD"   SACC 1.3
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10088
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIK                ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    IX2^DIK             ICR  10013
 ;    IXALL^DIK           ICR  10013
 ;    $$DT^XLFDT          ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 Q
LOAD(X) ; Load Changes
 N ORD,UP,SF,NODE,SYS,LOAD,TYPE,TOT,TYT,NDS S LOAD=0,SYS="CM"
 ;   0   AD - Added
 K NDS S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD)) Q:'$L(ORD)  D
 . N N0,N1,N1,N2,N2,N3,N4,N5,ID,SRC,FRG,FRGID,CIEN,NIEN,ENTD,NDS,VEFF K NDS S ID="10D"
 . S ENTD=$$DT^XLFDT,FRG=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,0)) Q:'$L(FRG)
 . S SRC=$O(^LEX(757.03,"ASAB",ID,0)) Q:"^30^31^"'[("^"_SRC_"^")
 . S FRGID=ID_FRG S CIEN=$O(^LEX(757.033,"B",FRGID,0)) Q:CIEN>0
 . S NIEN=$O(^LEX(757.033," "),-1)+1,VEFF=$P($G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,1)),"^",2) Q:VEFF'?7N
 . S NDS(NIEN,0)=FRGID_"^"_FRG_"^"_ENTD_"^"_SRC
 . S N1=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,1)) Q:'$L(N1)  S N1=VEFF Q:N1'?7N  S N1=N1_"^1"
 . S NDS(NIEN,1,0)="^"_$$NI(1,0)_"^1^1",NDS(NIEN,1,1,0)=VEFF_"^1"
 . S N2=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,2)) Q:'$L(N2)
 . S NDS(NIEN,2,0)="^"_$$NI(2,0)_"^1^1",NDS(NIEN,2,1,0)=VEFF,NDS(NIEN,2,1,1)=N2
 . S N3=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,3))
 . I $L(N3) S NDS(NIEN,3,0)="^"_$$NI(3,0)_"^1^1",NDS(NIEN,3,1,0)=VEFF,NDS(NIEN,3,1,1)=N3
 . S N4=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,4))
 . I $L(N4) S NDS(NIEN,4,0)="^"_$$NI(4,0)_"^1^1",NDS(NIEN,4,1,0)=VEFF,NDS(NIEN,4,1,1)=N4
 . S N5=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,5,0)) S:$L(N5) N5=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,5,N5)) I $L(N5) D
 . . N NI,I,C S (I,C)=0 F  S I=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,5,I)) Q:+I'>0  D
 . . . N TX S TX=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"AD",ORD,5,I)) Q:'$L(TX)
 . . . N NI S C=C+1 S NDS(NIEN,5,1,1,C,0)=TX
 . . . S NI=$$NI(5,1) S:$L(NI) NDS(NIEN,5,1,1,0)="^"_NI_"^"_C_"^"_C
 . . S NI=$$NI(5,1) S:C>0&($L(NI)) NDS(NIEN,5,0)="^"_$$NI(4,0)_"^1^1"
 . . S NDS(NIEN,5,1,0)=VEFF
 . S DA=+($G(NIEN)),DIK="^LEX(757.033," I +DA>0 D
 . . M ^LEX(757.033)=NDS
 . . N DIK S DIK="^LEX(757.033," D IX1^DIK
 . . D INC(SYS,"AD")
 ;   1a  IA - Inactive
 S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IA",ORD)) Q:'$L(ORD)  D
 . N ID,COD,CIEN,SEFF,EFF,HIS,STA,NIEN,DA,DIK S ID="10D"
 . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . S SEFF=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IA",ORD)) Q:SEFF'?7N
 . S EFF=$O(^LEX(757.033,+CIEN,1,"B",9999999),-1) Q:EFF'?7N  Q:SEFF'>EFF
 . S HIS=$O(^LEX(757.033,+CIEN,1,"B",+EFF," "),-1)
 . S STA=$P($G(^LEX(757.033,+CIEN,1,+HIS,0)),"^",2) Q:STA'>0
 . S NIEN=+($O(^LEX(757.033,CIEN,1," "),-1))+1
 . S ^LEX(757.033,CIEN,1,NIEN,0)=(SEFF_"^0") D INC(SYS,"IA")
 . S ND=$$HN(CIEN,1) S:$L(ND) ^LEX(757.033,CIEN,1,0)=ND
 . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 ;   1b  RA - Re-Active
 S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"RA",ORD)) Q:'$L(ORD)  D
 . N ID,COD,CIEN,SEFF,EFF,HIS,STA,NIEN,DA,DIK S ID="10D"
 . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . S SEFF=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"RA",ORD)) Q:SEFF'?7N
 . S EFF=$O(^LEX(757.033,+CIEN,1,"B",9999999),-1) Q:EFF'?7N  Q:SEFF'>EFF
 . S HIS=$O(^LEX(757.033,+CIEN,1,"B",+EFF," "),-1)
 . S STA=$P($G(^LEX(757.033,+CIEN,1,+HIS,0)),"^",2) Q:STA>0
 . S NIEN=+($O(^LEX(757.033,CIEN,1," "),-1))+1
 . S ^LEX(757.033,CIEN,1,NIEN,0)=(SEFF_"^1") D INC(SYS,"RA")
 . S ND=$$HN(CIEN,1) S:$L(ND) ^LEX(757.033,CIEN,1,0)=ND
 . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 ;   2a  SN - New Name/Title (short text)
 ;   3a  LN - New Description (long text)
 ;   4a  EN - New Explanation
 F TYPE="SN","LN","EN" D
 . N NODE S NODE=$S(TYPE="SN":2,TYPE="LN":3,TYPE="EN":4,1:"")
 . N ORD S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD)) Q:'$L(ORD)  D
 . . N ID,COD,CIEN,EFF,HIS,STA,NIEN,DA,DIK,SND,SNT S ID="10D"
 . . S SND=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD))
 . . S SNT=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD,0))
 . . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . . S EFF=$O(^LEX(757.033,+CIEN,NODE,"B",9999999),-1) I SND>EFF,$L(SNT) D
 . . . N DA,DIK,NIEN S NIEN=$O(^LEX(757.033,CIEN,NODE," "),-1)+1
 . . . S DA=CIEN,DIK="^LEX(757.033," D IX2^DIK
 . . . S ^LEX(757.033,CIEN,NODE,NIEN,0)=SND D INC(SYS,TYPE)
 . . . S ^LEX(757.033,CIEN,NODE,NIEN,1)=SNT
 . . . S ND=$$HN(CIEN,NODE) S:$L(ND) ^LEX(757.033,CIEN,NODE,0)=ND
 . . . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 ;   2b  SR - Revised Name/Title (short text)
 ;   3b  LR - Revised Description (long text)
 ;   4b  ER - Revised Explanation
 F TYPE="SR","LR","ER" D
 . N NODE S NODE=$S(TYPE="SR":2,TYPE="LR":3,TYPE="ER":4,1:"")
 . N ORD S ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD)) Q:'$L(ORD)  D
 . . N ID,COD,CIEN,EFF,HIS,STA,NIEN,DA,DIK,SRD,SRT S ID="10D"
 . . S SRD=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD)),SRT=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),TYPE,ORD,0))
 . . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . . S EFF=$O(^LEX(757.033,+CIEN,NODE,"B",9999999),-1) Q:EFF'?7N  Q:SRD<EFF
 . . S HIS=$O(^LEX(757.033,+CIEN,NODE,"B",+EFF," "),-1)
 . . I SRD=EFF,+HIS>0,$L(SRT) D  Q
 . . . N ND,DA,DIK S DA=CIEN,DIK="^LEX(757.033," D IX2^DIK
 . . . S ^LEX(757.033,CIEN,NODE,HIS,0)=SRD D INC(SYS,TYPE)
 . . . S ^LEX(757.033,CIEN,NODE,HIS,1)=SRT
 . . . S ND=$$HN(CIEN,NODE) S:$L(ND) ^LEX(757.033,CIEN,NODE,0)=ND
 . . . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 . . I SRD>EFF,$L(SRT) D
 . . . N DA,DIK,ND,NIEN S NIEN=$O(^LEX(757.033,CIEN,NODE," "),-1)+1
 . . . S DA=CIEN,DIK="^LEX(757.033," D IX2^DIK
 . . . S ^LEX(757.033,CIEN,NODE,NIEN,0)=SRD D INC(SYS,TYPE)
 . . . S ^LEX(757.033,CIEN,NODE,NIEN,1)=SRT
 . . . S ND=$$HN(CIEN,NODE) S:$L(ND) ^LEX(757.033,CIEN,NODE,0)=ND
 . . . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 ;   5a  IN - New Inclusions
 S NODE=5,ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IN",ORD)) Q:'$L(ORD)  D
 . N ID,COD,CIEN,EFF,HIS,STA,NIEN,DA,DIK,SRD,SRI,SRT,SRC,SF,UP S ID="10D"
 . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . S SRD=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IN",ORD)),(SRC,SRI)=0 Q:SRD'?7N
 . S ^LEX(757.033,CIEN,NODE,1,0)=SRD
 . F  S SRI=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IN",ORD,SRI)) Q:+SRI'>0  D
 . . N SRT S SRT=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IN",ORD,SRI)) Q:'$L(SRT)  S SRC=SRC+1
 . . S ^LEX(757.033,CIEN,NODE,1,1,SRC,0)=SRT
 . S SF=$$HN(CIEN,NODE,1),^LEX(757.033,CIEN,NODE,1,1,0)=SF
 . S UP=$$HN(CIEN,NODE,0),^LEX(757.033,CIEN,NODE,0)=UP
 . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 . D INC(SYS,"IN")
 ;   5b  IR - Revised Inclusions
 S NODE=5,ORD="" F  S ORD=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IR",ORD)) Q:'$L(ORD)  D
 . N ID,COD,CIEN,SIEN,EFF,HIS,STA,NIEN,DA,DIK,SRD,SRI,SRT,SRC,SF,UP S ID="10D"
 . S COD=$TR(ORD," ",""),CIEN=$O(^LEX(757.033,"B",(ID_COD),0)) Q:+CIEN'>0
 . S SRD=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IR",ORD)),(SRC,SRI)=0 Q:SRD'?7N
 . S SIEN=$O(^LEX(757.033,CIEN,NODE,"B",SRD," "),-1)
 . S:+SIEN'>0 SIEN=$O(^LEX(757.033,CIEN,NODE," "),-1)+1 I SIEN>0 D  Q
 . . N RIEN,ORI,ORC,HN I $D(^LEX(757.033,CIEN,NODE,SIEN)) D
 . . . S RIEN=0 F  S RIEN=$O(^LEX(757.033,CIEN,NODE,SIEN,1,RIEN)) Q:+RIEN'>0  D
 . . . . N DA,DIK S DA(2)=CIEN,DA(1)=SIEN,DA=RIEN
 . . . . S DIK="^LEX(757.033,"_DA(2)_","_NODE_","_DA(1)_",1," D ^DIK
 . . S (ORI,ORC)=0 F  S ORI=$O(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IR",ORD,0,ORI)) Q:+ORI'>0  D
 . . . N ORN S ORN=$G(^ZZLEXX("ZZLEXXD","CAT","CHG",$G(SYS),"IR",ORD,0,ORI)) Q:'$L(ORI)
 . . . S ORC=+($G(ORC))+1 S ^LEX(757.033,CIEN,NODE,SIEN,1,ORC,0)=ORN
 . . S HN=$$HN(+CIEN,NODE,1) S ^LEX(757.033,CIEN,NODE,SIEN,1,0)=HN
 . . S ^LEX(757.033,CIEN,NODE,SIEN,0)=SRD
 . . S HN=$$HN(+CIEN,NODE,0) S ^LEX(757.033,CIEN,NODE,0)=HN
 . . D INC(SYS,"IR")
 . S DA=CIEN,DIK="^LEX(757.033," D IX1^DIK
 S ^ZZLEXX("ZZLEXXD","CAT","DT","LD","ON")=$$NOW^XLFDT
 S ^ZZLEXX("ZZLEXXD","CAT","DT","LC","ON")=$$NOW^XLFDT
 M ^ZZLEXX("ZZLEXXD","CAT","LOAD")=LOAD
 S TOT=0,TYT=0,TYPE="" F  S TYPE=$O(^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS",SYS,TYPE)) Q:'$L(TYPE)  D
 . S:TYPE'="TOT" TYT=TYT+($G(^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS",SYS,TYPE)))
 S:TYT>0 ^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS",SYS,"TOT")=TYT
 S ^ZZLEXX("ZZLEXXD","CAT","LOAD","TOT")=$G(^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS",("PC"_"S"),"TOT"))+$G(^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS","CM","TOT"))
 S ^ZZLEXX("ZZLEXXD","CAT","LOAD")=$G(^ZZLEXX("ZZLEXXD","CAT","LOAD","TOT"))
 S X=$G(^ZZLEXX("ZZLEXXD","CAT","LOAD","SYS",SYS,"TOT"))
 D F757033
 I $D(^ZZLEXX("ZZLEXXD","CAT","LOAD","TIM","BEG")) D
 . N BEG,END,ELP,HR S BEG=$G(^ZZLEXX("ZZLEXXD","CAT","LOAD","TIM","BEG")) Q:$P(BEG,".",1)'?7N
 . H 1 S ^ZZLEXX("ZZLEXXD","CAT","LOAD","TIM","ST3")=$$NOW^XLFDT H 2
 . S END=$$NOW^XLFDT,ELP=$$FMDIFF^XLFDT(END,BEG,3)
 . S HR=$$TM($P(ELP,":",1)) S:$L(HR)'=2 HR="0"_HR S:$L(HR)'=2 HR="0"_HR S $P(ELP,":",1)=HR
 . S ^ZZLEXX("ZZLEXXD","CAT","LOAD","TIM","END")=END
 . S ^ZZLEXX("ZZLEXXD","CAT","LOAD","TIM","ELP")=ELP
 Q X
 ; 
 ; Miscellaneous
F757033 ;   Reindex 757.033 CHARACTER POSITIONS
 N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="T757033^ZZLEXXDD"
 S ZTDESC="Re-index CHARACTER POSITIONS file #757.033" S ZTIO="",ZTDTH=$H D ^%ZTLOAD D HOME^%ZIS
 Q
T757033 ;   Reindex 757.033 (Tasked)
 S:$D(ZTQUEUED) ZTREQ="@" S ZTQUEUED=$G(ZTQUEUED) N DIK S DIK="^LEX(757.033," D IXALL^DIK K ZTQUEUED
 Q
INC(X,Y) ;   Increment Load Counter
 S LOAD=+($G(LOAD))+1 N SYS,TYP S SYS=$G(X),TYP=$G(Y) Q:'$L(SYS)  Q:'$L(TYP)
 S LOAD("SYS",SYS,TYP)=+($G(LOAD("SYS",SYS,TYP)))+1 S LOAD("TYP",TYP)=+($G(LOAD("TYP",TYP)))+1
 S LOAD("SYS",SYS,"TOT")=$G(LOAD("SYS",SYS,"TOT"))+1
 S LOAD("TOT")=$G(LOAD("TOT"))+1
 Q
HN(X,Y,Z) ;   Header Node
 N CIEN,SF,ND,CTR,LT,NI S CIEN=+($G(X)),ND=+($G(Y)),SF=+($G(Z)) S:+SF'>0 SF="" Q:CIEN'>0 ""  Q:"^1^2^3^4^5^"'[("^"_ND_"^") ""
 S LT=$$LT(CIEN,ND,SF) S:'$L(LT) LT="^0" S NI=$$NI(ND,SF),X="" S:$L(NI)&($L(LT)) X="^"_NI_"^"_LT
 Q X
NI(X,Y) ;   Header Node ID
 I +($G(Y))'>0 Q:+($G(X))=1 "757.331D"  Q:+($G(X))=2 "757.332D"  Q:+($G(X))=3 "757.043D"  Q:+($G(X))=4 "757.334D"  Q:+($G(X))=5 "757.335D"
 I +($G(Y))>0 Q:+($G(X))=5 "757.345"
 Q ""
LT(X,Y,Z) ;   Last/Total (IEN,NODE,SUBFILE)
 N CIEN,SF,ND,LAS,TOT,IEN S CIEN=+($G(X)),ND=+($G(Y)),SF=+($G(Z)) Q:CIEN'>0 ""  Q:"^1^2^3^4^5^"'[("^"_ND_"^") ""  Q:'$D(^LEX(757.033,+CIEN,ND)) ""
 S LAS="",(TOT,IEN)=0 F  S IEN=$O(^LEX(757.033,+CIEN,+ND,IEN)) Q:+IEN'>0  S LAS=IEN,TOT=TOT+1
 I +CIEN>0,+ND=5,SF>0 D
 . S LAS="",(TOT,IEN)=0 Q:'$D(^LEX(757.033,CIEN,+ND,+SF,1))
 . F  S IEN=$O(^LEX(757.033,CIEN,+ND,+SF,1,IEN)) Q:+IEN'>0  S LAS=IEN,TOT=TOT+1
 S:+LAS'>0 LAS="" S X=LAS_"^"_TOT
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
TN(X) ;   Type Name
 N TY S TY=$G(X) Q:TY="SN"!(TY="SR") "Name/Title"  Q:TY="LN"!(TY="LR") "Description/Definition"
 Q:TY="EN"!(TY="ER") "Explanations"  Q:TY="IN"!(TY="IR") "Inclusions/Synonyms"
 Q ""
NN(X) ;   Node Number
 N TY S TY=$G(X)  Q:TY="SN"!(TY="SR") 2  Q:TY="LN"!(TY="LR") 3  Q:TY="EN"!(TY="ER") 4  Q:TY="IN"!(TY="IR") 5
 Q ""
