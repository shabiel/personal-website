ZZLEXXCM ;SLC/KER - Import - Conflicts - Misc ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^UTILITY($J         ICR  10011
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;    ^ZZLEXX("ZZLEXXCM"  SACC 1.3
 ;               
 ; External References
 ;    ^%ZIS               ICR  10086
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZISC              ICR  10089
 ;    $$DEL^%ZISH         ICR   2320
 ;    $$LIST^%ZISH        ICR   2320
 ;    $$STATUS^%ZISH      ICR   2320
 ;    CLOSE^%ZISH         ICR   2320
 ;    OPEN^%ZISH          ICR   2320
 ;    ENDR^%ZISS          ICR  10088
 ;    KILL^%ZISS          ICR  10088
 ;    $$OS^%ZOSV          ICR   3522
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    ^DIWP               ICR  10011
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$HTFM^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     ASX
 ;               
DIR(X,N,H,S) ; Host File Directory
 W !,"DIR",!
 ZW X,N,H,S
 N ASIZE,BYTE,CNT,CON,CRE,CT,EDT,FDTS,FI,FILESPEC,FN,FULL
 N HAS,HDR,I,ID,NOT,OK,PATH,SCREEN,SEG,SIZE,SUB,TMP,TXT,UFN,Y
 S SUB=$$LR_"S" K ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR"),^ZZLEXX("ZZLEXXCM",$J,"TEMP")
 S PATH=$G(X) Q:'$L(PATH)  S NOT=$G(N),HAS=$G(H) S FILESPEC=""
 S SCREEN("*.TXT")="",SCREEN("*.txt")=""
 S Y=$$LIST^%ZISH(PATH,"SCREEN","^ZZLEXX(""ZZLEXXCM"",$J,""DEVICE"",""TEMP"")")
 S:'$D(ASX) HDR="File Name"_$J(" ",33)_"Dated"_$J(" ",11)_" Bytes"
 S:$D(ASX) HDR="File Name"_$J(" ",43)_"Dated"_$J(" ",7)_" Bytes"
 S CT=0,FN="" F  S FN=$O(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","TEMP",FN)) Q:'$L(FN)  D
 . N ASIZE,BYTE,CRE,CNT,CON,EDT,FDTS,FI,I,OK,SEG,SIZE,TMP,TXT,UFN
 . S OK=1 I $L($G(NOT)) D
 . . N UFN,I S UFN=$$UP^XLFSTR(FN),CON=0 F I=1:1 Q:'$L($P(NOT,";",I))  S:FN[$P(NOT,";",I) OK=0
 . Q:'OK  S OK=1 I $L($G(HAS)) D
 . . N CON,CNT,UFN,SEG,I S UFN=$$UP^XLFSTR(FN),HAS=$$UP^XLFSTR(HAS),CON=0,CNT=0
 . . F I=1:1 S SEG=$P(HAS,";",I) Q:'$L(SEG)  S CNT=CNT+1 S:UFN[SEG CON=CON+1
 . . S:CNT>0&(CON'=CNT) OK=0
 . Q:'OK  S FULL=FN S:$L(PATH) FULL=PATH_FN
 . S FDTS=$$FDTS(FULL) Q:+FDTS'>0
 . S CRE=$P(FDTS,"^",1),(TMP,EDT)=$P(FDTS,"^",2)
 . S SIZE=$P(FDTS,"^",3),ASIZE=$$CSIZE(SIZE)
 . S BYTE=$J(" ",(7-$L(SIZE)))_SIZE
 . S FI=FN S:FN[";" FI=$P(FN,";",1) S ID=FI S:ID["." ID=$P(ID,".",1)
 . Q:$D(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","B",FI))
 . S TMP=$P(TMP," ",1)
 . S:'$D(ASX) CT=CT+1,TXT=FI,TXT=TXT_$J(" ",(40-$L(TXT)))_TMP
 . S:$D(ASX) CT=CT+1,TXT=FI,TXT=TXT_$J(" ",(50-$L(TXT)))_TMP
 . S TXT=TXT_$J(" ",(13-$L(TMP)))_BYTE
 . S TMP=CRE
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT)=TXT
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"NAME")=FI
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"SIZE")=SIZE
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"ASIZ")=ASIZE
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"BYTE")=BYTE
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"DATE")=CRE
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",CT,"EDAT")=EDT
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",0)=CT
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","B",FI,CT)=""
 . S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","C",FN,CT)=""
 S ^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","H")=HDR
 K ^ZZLEXX("ZZLEXXCM",$J,"TEMP")
 Q
CSIZE(X) ;   Host File Condensed Size
 N ID S ID="" S X=+($G(X)) Q:X'>0 "" S:X'>1024 X=X,ID=" B "
 S:X>1024 X=(X/1024),ID=" KB" S:X>1000 X=(X/1000),ID=" MB" S:X>1000 X=(X/1000),ID=" GB"
 S:ID=" B " X=X_ID S:ID'=" B " X=$FN(X,"",1)_ID
 S:$L(X) X=$J(" ",(10-$L(X)))_X
 Q X
FDTS(X) ;   Host File Dates and Size
 N FOUT,FIL1,FIL2,FIL3,EDAT,IDAT,FDAT,FDES,FSYS,I,FOPEN,FEX,ST,TYPE,SIZE,CRE,MOD,ERR,PATH,FN
 S FOUT=$G(X),SIZE=0 Q:'$L(FOUT) -1  S PATH=""
 S:FOUT["]" PATH=$P(FOUT,"]",1)_"]"
 S:FOUT["/" PATH=$P(FOUT,"/",1,($L(FOUT,"/")-1))_"/"
 S FN=FOUT S:$L(PATH)&(FN[PATH) FN=$P(FN,PATH,2)
 S FEX="S SIZE=$ZU(140,1,FOUT)" X FEX
 S FEX="S MOD=$ZU(140,2,FOUT)" X FEX
 S FEX="S CRE=$ZU(140,3,FOUT)" X FEX
 S SIZE=$G(SIZE) Q:SIZE'>0 "-1^No Data in file"
 S MOD=$G(MOD) S:+MOD>0 MOD=$$HTFM^XLFDT(MOD) S:$P(MOD,".",1)'?7N MOD=""
 S CRE=$G(CRE) S:+CRE>0 CRE=$$HTFM^XLFDT(CRE) S:$P(CRE,".",1)'?7N CRE=""
 S X=CRE_"^"_$$ED(CRE)_"^"_SIZE
 Q X
 ; 
SEL(X) ; Host File Selection
 N SEL,FND,SUB S SUB=$$LR_"S" S FND=+($G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",0))) Q:+FND'>0 "-1^No hostfiles found/available"
 S:+FND=1 SEL=$$ONE S:+FND>1 SEL=$$MUL S X=$S(SEL>0:("1^"_$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",+SEL,"NAME"))),1:"-1^Hostfile selection not made")
 Q X
ONE(X) ;   One Host File Found
 N Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT,MAX,SUB S SUB=$$LR_"S" S MAX=+($G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",0))) Q:MAX'=1 "-1^No selection available"
 S DIR("A",1)=("  "_$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","H"))),DIR("A",2)=("  "_$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",1)))
 S DIR("A",3)=" ",DIR("A")="     Ok?  (Y/N)  ",DIR("B")="Yes",DIR(0)="YAO",(DIR("?"),DIR("??"))="^D ONEH^ZZLEXXCM"
 W ! D ^DIR S X=$S(+Y>0:1,1:0)
 Q X
ONEH ;   One Host File Found Help
 W !,?7,"Answer ""Yes"" to select this hostfile or ""No"" or ""^""",!,?7,"to exit without making a selection"
 Q
MUL(X) ;   Multiple Host Files Found
 N EXIT,IEN,LAST,SEL,MAX,HDR,SUB S SUB=$$LR_"S"
 S MAX=$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",0)) Q:MAX'>1 "-1^No selection available"
 S HDR="        "_$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR","H")) W !!," ",MAX," hostfiles found",!
 S SEL="",(LAST,EXIT,IEN)=0
 F  S IEN=$O(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",IEN)) Q:+IEN'>0!(+EXIT>0)  D  Q:+EXIT>0  Q:+SEL>0
 . N ENT,LEXT,LEXO S ENT=$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",IEN)),LAST=IEN
 . W:IEN#5=1 !,HDR W !," ",$J(IEN,4),".  ",ENT W:IEN#5=0 ! S:IEN#5=0 SEL=$$MULS(LAST)
 . S:SEL="^" EXIT=1
 I LAST#5'=0,+SEL'>0 W ! S SEL=$$MULS(LAST) S:SEL="^" EXIT=1
 S X="^" S:'EXIT&(+SEL>0) X=SEL S:+X'>0 X="^"
 Q X
MULS(X) ;   Multiple Host Files Prompt
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,MAX,LAST,SUB S SUB=$$LR_"S" S MAX=$G(^ZZLEXX("ZZLEXXCM",$J,"DEVICE","DIR",0)) Q:MAX'>1 "-1^No selection available"
 S LAST=+($G(X)) S:LAST>0 DIR("A")=" Select 1-"_LAST_" or '^' to exit:  "
 S (DIR("?"),DIR("??"))="Answer must be from 1 to "_LAST_", or <Return> to continue  "
 S DIR(0)="NAO^1:"_LAST_":0" D ^DIR Q:X="" X  S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X="^" Q:X="^" "^"
 I +Y>0,+Y'>LAST S X=+Y Q X
 Q -1
 ; 
 ; Device
OPEN(X,Y,Z) ;   Open Device
 N HFOK,HFP,HFN,HFH S HFP=$G(X)
 Q:'$L($G(HFP)) "0^Missing Hostfile Path"
 S HFN=$G(Y) Q:'$L($G(HFN)) "0^Missing Hostfile Name"
 S HFH=$$LR_$G(Z)
 D OPEN^%ZISH(HFH,HFP,HFN,"R")
 S HFOK=$G(POP) I HFOK D CLOSE Q ("0^Error opening"_HFN)
 I IO'[HFN D CLOSE Q ("0^Error opening Hostfile "_HFN)
 Q 1
CLOSE(X) ;   Close Device
 N HFH S HFH=$$LR_$G(X) D CLOSE^%ZISH(HFH)
 Q
EOF(X) ;   End of File
 U IO S X=$$STATUS^%ZISH U IO(0)
 Q X
PATH(X,Y) ;   Path
 N UCI,SYS,PAT,PATH S UCI=$G(X) S:'$L(UCI) UCI=$$LOC S SYS=$G(Y)
 S:'$L(SYS) SYS=$$SYS S SYS=$E(SYS,1)
 S SYS=$$UP^XLFSTR(SYS),(PAT,UCI)=$$UP^XLFSTR(UCI) Q:'$L(UCI) ""  Q:'$L(SYS) ""  Q:"^U^V^"'[("^"_SYS_"^") ""
 S PATH="USER$:["_UCI_"]" S:SYS'="V" PATH="/home/sftp/patches/" S:UCI="DEVCUR"&(PATH["[") PATH="VA5$:[BETA]"
 S X=PATH
 Q X
PIT(X)  ;   Path - Input Transform
 N TPATH,TFILE,TFSPEC,OUT,FILE,PATH,IOP S TPATH=$G(X),TFILE="ZZLEXXCM"_+($G(DUZ))_".DAT",TFSPEC=TPATH_TFILE
 D HOME^%ZIS S IOP="HFS",%ZIS("HFSNAME")=TFSPEC,%ZIS("HFSMODE")="W",%ZIS="0" D ^%ZIS S OUT=POP
 I OUT U:$L($G(IO(0))) IO(0) D ^%ZISC,HOME^%ZIS Q 0
 U IO W ! U:$L($G(IO(0))) IO(0) D ^%ZISC,HOME^%ZIS K FAR
 S PATH="" S:TPATH["]" PATH=$P(TPATH,"]",1)_"]",FILE=$P(TPATH,"]",2)
 S:TPATH["/" PATH=$P(TPATH,"/",1,($L(TPATH,"/")-1))_"/",FILE=$P(TPATH,"/",$L(TPATH,"/"))
 S FAR(TFILE)="",Y=$$DEL^%ZISH(TPATH,$NA(FAR)),X=1_"^"_Y K FAR
 D ^%ZISC,HOME^%ZIS K %ZIS
 Q X
 ; 
EFF(X) ; Effective Date
 N BEG,END,DIR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,TD,FY,YR,PD,FD,OF,Y
 S DIRB="" S TD=$$DT^XLFDT,YR=$$UP^XLFSTR($G(X)) I YR'?4N D
 . S YR=$P(YR,".TXT",1),YR=$E(YR,($L(YR)-3),$L(YR)) S:YR'?4N YR="" S:YR?4N YR=YR-1
 S OF=$E(TD,1,3)_"1001",BEG=TD,END=OF S:TD>OF BEG=OF,END=TD S OF=$$FMDIFF^XLFDT(END,BEG)
 S PD=$$FMADD^XLFDT(TD,-(365+OF)),FD=$$FMADD^XLFDT(TD,(365+OF)) S PD=$E(PD,1,3)_"1001",FD=$E(FD,1,3)_"1001"
 S:YR?4N DIRB="Oct 1, "_YR S FY=$P($G(X),".",1),FY=$E(FY,($L(FY)-3),$L(FY)) S:FY?4N YR=FY S:'$L(DIRB) DIRB="Oct 1, "_FY
 S:$L(DIRB) DIR("B")=DIRB S DIR("A")=" Enter the effective date:  "
 S (DIR("?"),DIR("??"))="^D EFFH^ZZLEXXCM",DIR("PRE")="S:X[""?"" X=""??"""
 S DIR(0)="DAO^"_PD_":"_FD_":EX" W ! D ^DIR Q:X["^" "^" Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) "^"
 S X=Y
 Q X
EFFH ;   Effective Date Help
 I $G(PD)?7N,$G(FD)?7N D  Q
 . W !,?4,"Enter an effective date between ",$$FMTE^XLFDT(PD)," and "
 . W !,?4,$$FMTE^XLFDT(FD)," or ""^"" to exit. "
 W !,?4,"Enter an effective date or ""^"" to exit. "
 Q
DEFF(X) ; Default Effective Date
 N TD,YR,DEF S TD=$$DT^XLFDT,YR=$$UP^XLFSTR($G(X)) I YR'?4N D
 . S YR=$P(YR,".TXT",1),YR=$E(YR,($L(YR)-3),$L(YR)) S:YR?4N YR=YR-1
 S DEF="" S:YR?4N DEF=(YR-1700)_"1001"
 S X="" S:DEF?7N X=DEF_"^"_$$FMTE^XLFDT(DEF,"5Z")
 Q X
TL(X) ; Test Load
 N DIR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,HF,Y S HF=$P($G(X),".",1)
 S DIR("B")="Yes" S:$L(HF) DIR("A")=" Test load the data in "_HF_":  "
 S:'$L(HF) DIR("A")=" Test load the data in the host file:  "
 S (DIR("?"),DIR("??"))="^D TLH^ZZLEXXCM",DIR("PRE")="S:X[""?"" X=""??"""
 S DIR(0)="YAO" W ! D ^DIR Q:X["^" "^" Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) "^"
 S X=Y
 Q X
TLH ;   Test Load Help
 D ATTR
 W !,?4,"Answer '",$G(BOLD),"Yes",$G(NORM),"' to test the load.  Possible changes will be"
 W !,?4,"displayed on the screen along with the total number of"
 W !,?4,"possible changes, but no ICD data will be updated",!
 W !,?4,"Answer '",$G(BOLD),"No",$G(NORM),"' to load the data, display the total possible"
 W !,?4,"changes with an option of updating the ICD files",!
 W !,?4,"or enter '^' to exit."
 D KATTR
 Q
CM(X) ; Test Load
 N DIR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,LEXHF,LEXFN,Y S LEXHF=$G(X) Q:'$L(LEXHF) 0
 S LEXFN="" S:LEXHF["UPD"!(LEXHF["AGE") LEXFN="ICD Diagnosis file"
 S:LEXHF["SEX" LEXFN="ICD Diagnosis/Procedure files" Q:'$L(LEXFN) 0
 S DIR("B")="No"
 S DIR("A")=" Update the "_LEXFN_":  "
 S (DIR("?"),DIR("??"))="^D CMH^ZZLEXXCM",DIR("PRE")="S:X[""?"" X=""??"""
 S DIR(0)="YAO" W ! D ^DIR Q:X["^" "^" Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) "^"
 S X=Y
 Q X
CMH ;   Test Load Help
 D ATTR S LEXFN=$G(LEXFN),LEXHF=$G(LEXHF)
 I LEXFN["files" D
 . W !,?4,"Answer '",$G(BOLD),"Yes",$G(NORM),"' to update tbe ",LEXFN
 . W !,?4,"with the data from the host file ",LEXHF," and"
 . W !,?4,"display the total changes made"
 . W !
 I LEXFN'["files" D
 . W !,?4,"Answer '",$G(BOLD),"Yes",$G(NORM),"' to update tbe ",LEXFN," with the"
 . W !,?4,"data from the host file ",LEXHF," and display"
 . W !,?4,"the total changes made"
 . W !
 W !,?4,"Answer '",$G(BOLD),"No",$G(NORM),"' to skip the upddate of the ICD files and"
 W !,?4,"display the total possibe changes had the update"
 W !,?4,"occurred",!
 W !,?4,"or enter '^' to exit."
 D KATTR
 Q
BD(X) ; Select Brief/Detailed Display
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,ENT,COM S ENT="BD^ZZLEXXCM",COM="Brief/Detailed Display"
 S DIRB=$$RET("BD") S:$L(DIRB) DIR("B")=DIRB S DIR(0)="SAO^B:Brief Display;D:Detailed Display"
 S DIR("B")="Brief" S DIR("A")=" Select Display Type - Brief/Detailed (B/D):  "
 S (DIR("?"),DIR("??"))="^D BDH^ZZLEXXCM"
 S DIR("PRE")="S OX=X S:$L(X)&(X'[""^"")&(""^B^D^""'[(""^""_$$UP^XLFSTR($E(X,1))_""^"")) X=""??"""
 W ! D ^DIR Q:$D(DIROUT)!($D(DTOUT))!($D(DIRUT))!($D(DUOUT)) "^"  S (X,Y)=$$UP^XLFSTR($E(Y,1))
 S DIRB="" S:X="B" DIRB="Brief" S:X="D" DIRB="Detailed" D:$L(DIRB) SAV("BD",DIRB)
 Q X
BDH ;   Select Brief/Detailed Display Help
 D ATTR
 W !,?6,"Enter '",$G(BOLD),"B",$G(NORM),"' for a brief display (displays summary only),"
 W !,?6,"'",$G(BOLD),"D",$G(NORM),"' for a detailed display (displays individual entries)"
 W !,?6,"or '^' to exit"
 D KATTR
 Q
 ;
 ; Miscellaneous
SAV(X,Y) ;   Save Defaults
 N RTN,TAG,REF,NUM,COM,VAL,NAM,ID,NOW,FUT,KEY
 S TAG=$G(X),VAL=$G(Y) Q:'$L(TAG)  Q:'$L(VAL)  S RTN=$P($T(+1)," ",1) Q:'$L(RTN)
 S COM=$E($$TM($TR($P($T(@TAG+0)," ",2,299),";"," ")),1,13) Q:'$L(COM)
 S NUM=+($G(DUZ)) Q:+NUM'>0  S NAM=$$GET1^DIQ(200,(NUM_","),.01) Q:'$L(NAM)
 S KEY=$E(COM,1,13) S:$L(KEY)'>11 KEY=KEY_$J(" ",12-$L(KEY))
 S NOW=$$DT^XLFDT,FUT=$$FMADD^XLFDT(NOW,60),ID=RTN_" "_NUM_" "_KEY
 S ^XTMP(ID,0)=FUT_"^"_NOW_"^"_COM,^XTMP(ID,TAG)=VAL
 Q
RET(X) ;   Retrieve Defaults
 N RTN,TAG,REF,NUM,COM,VAL,NAM,ID,NOW,FUT,KEY
 S TAG=$G(X) Q:'$L(TAG) ""  S RTN=$P($T(+1)," ",1) Q:'$L(RTN) ""
 S COM=$E($$TM($TR($P($T(@TAG+0)," ",2,299),";"," ")),1,13) Q:'$L(COM) ""
 S NUM=+($G(DUZ)) Q:+NUM'>0 ""  S NAM=$$GET1^DIQ(200,(NUM_","),.01) Q:'$L(NAM) ""
 S KEY=$E(COM,1,13) S:$L(KEY)'>11 KEY=KEY_$J(" ",12-$L(KEY))
 S ID=RTN_" "_NUM_" "_KEY S X=$G(^XTMP(ID,TAG))
 Q X
PR(LEX,X) ;   Parse Array using FileMan
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXC,LEXI,LEXL,Z
 K ^UTILITY($J,"W") Q:'$D(LEX)  S LEXL=+($G(X)) S:+LEXL'>0 LEXL=79
 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXL S LEXI=0
 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W"),%,%D
 Q
TM(X,Y) ;   Trim Character Y - Default " " Space
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
CS(X) ;   Comma Space
 S X=$G(X) F  Q:($E(X,1)'=" "&($E(X,1)'=","))&($E(X,$L(X))'=" "&($E(X,$L(X))'=","))  D TM(X),TM(X,",")
 S:X[", " X=$P(X,", ",1,($L(X,", ")-1))_" and "_$P(X,", ",$L(X,", "))
 Q X
DS(X) ;   Remove Double Space
 S X=$G(X) Q:X="" X
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,299)
 Q X
ATTR ;   Screen Attributes
 N X,%,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM) Q
KATTR ;   Kill Screen Attributes
 D KILL^%ZISS K IOINHI,IOINORM,BOLD,NORM Q
ED(X) ;   External Date
 S X=$G(X) Q:$P(X,".",1)'?7N ""
 S X=$$FMTE^XLFDT(X,"5ZM") S:X["@" X=$P(X,"@",1)_"  "_$P(X,"@",2)
 Q X
SYS(X) ;   System
 S X="U" S:$$OS^%ZOSV'["UNIX" X="V"
 Q X
LOC(X) ;   Local Namespace
 X "S X=$ZNSPACE" Q X
KILL ;   Kill Global
 K ^ZZLEXX("ZZLEXXC",$J),^ZZLEXX("ZZLEXXCM",$J),^ZZLEXX("ZZLEXXCH",$J)
 Q
LR(X) ;   Local Routine
 S X=$T(+1),X=$P(X," ",1) Q X
