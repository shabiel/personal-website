ZZLEXXSH ;SLC/KER - Import - SDO Addenda - Help ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^ZZLEXX("ZZLEXXS"   SACC 1.3
 ;               
 ; External References
 ;    ^%ZIS               ICR  10086
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZISC              ICR  10089
 ;    ENDR^%ZISS          ICR  10088
 ;    KILL^%ZISS          ICR  10088
 ;    ^%ZTLOAD            ICR  10063
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;               
HELP ; Main Entry Point
 N %,%ZIS,BOLD,CNT,ENV,EXEC,I,IOINHI,IOINORM,IOP,LEXCONT,LEXCT,LEXEOP,LEXI,LEXLC,NM,NORM,POP,RTN
 N TAG,TXT,X,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ENV=$$ENV Q:ENV'>0
 K ^ZZLEXX("ZZLEXXS",$J,"HELP") D GET I '$D(^ZZLEXX("ZZLEXXS",$J,"HELP")) W !!," No help text found",! K ^ZZLEXX("ZZLEXXS",$J,"HELP") Q
 D DSP
 Q
GET ; Get Help Text
 N TAG,RTN,BOLD,NORM,CNT,TXT,I  S TAG="HT",RTN="ZZLEXXSH" D ATTR
 K ^ZZLEXX("ZZLEXXS",$J,"HELP") S CNT=0,TXT=""  F I=1:1 D  Q:'$L(TXT)
 . N EXEC S TXT="" S EXEC="S TXT=$T("_TAG_"+"_I_"^"_RTN_")" X EXEC
 . S TXT=$P(TXT,";;",2,299) Q:TXT=""  Q:$TR(TXT,";","")=""
 . I TXT["~" F  Q:TXT'["~"  S TXT=$P(TXT,"~",1)_$G(BOLD)_$P(TXT,"~",2,299)
 . I TXT["|" F  Q:TXT'["|"  S TXT=$P(TXT,"|",1)_$G(NORM)_$P(TXT,"|",2,299)
 . S CNT=CNT+1 S ^ZZLEXX("ZZLEXXS",$J,"HELP",CNT)=(" "_TXT)
 D KATTR
 D:$D(SHOW) SHOW K SHOW
 Q
 ; 
DSP ; Display ^ZZLEXX("ZZLEXXS",$J,"HELP")
 N %,%ZIS,IOP,ZTRTN,ZTSAVE,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTQUEUED,ZTREQ
 S ZTRTN="DSPI^ZZLEXXSH",ZTDESC="Display/Print Help"
 S ZTIO=ION,ZTDTH=$H,%ZIS="PQ",ZTSAVE("^ZZLEXX(""ZZLEXXS"","_$J_",""HELP"",")=""
 S %ZIS("A")="   Device:  " W !!," Display Help",! D ^%ZIS
 K %ZIS Q:POP  S ZTIO=ION I $D(IO("Q")) D QUE,^%ZISC Q
 D NOQUE
 Q
NOQUE ;   Do not que task
 W @IOF W:IOST["P-" !,"< Not queued, printing Help >",! U:IOST["P-" IO D @ZTRTN,^%ZISC
 Q
QUE ;   Task queued 
 K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! H 2 Q
 Q
DSPI ;   Display Code Lookup
 W:$L($G(IOF)) @IOF
 I '$D(ZTQUEUED),$G(IOST)'["P-" I '$D(^ZZLEXX("ZZLEXXS",$J,"HELP")) W !,"Text not Found"
 U:IOST["P-" IO G:'$D(^ZZLEXX("ZZLEXXS",$J,"HELP")) DSPQ N LEXCONT,LEXI,LEXLC,LEXEOP,LEXCT S LEXCT=0
 S LEXCONT="",(LEXLC,LEXI)=0,LEXEOP=+($G(IOSL)) S:LEXEOP=0 LEXEOP=24
 F  S LEXI=$O(^ZZLEXX("ZZLEXXS",$J,"HELP",LEXI)) Q:+LEXI=0!(LEXCONT["^")  D
 . W !,^ZZLEXX("ZZLEXXS",$J,"HELP",LEXI) S LEXCT=0 D LF Q:LEXCONT["^"
 S:$D(ZTQUEUED) ZTREQ="@" D:'LEXCT CONT K ^ZZLEXX("ZZLEXXS",$J,"HELP") W:$G(IOST)["P-" @IOF
DSPQ ;   Quit Display
 Q
LF ;   Line Feed
 S LEXLC=LEXLC+1 D:IOST["P-"&(LEXLC>(LEXEOP-7)) CONT D:IOST'["P-"&(LEXLC>(LEXEOP-4)) CONT
 Q
CONT ;   Page/Form Feed
 S LEXCT=1 S LEXLC=0 W:IOST["P-" @IOF Q:IOST["P-"
 W !!,"  Press <Return> to continue  " R LEXCONT:300 W:$L($G(IOF)) @IOF S:'$T LEXCONT="^"
 S:LEXCONT["^" LEXCONT="^" S:LEXCONT'["^" LEXCONT=""
 Q
 ; 
 ; Miscellaneous
SHOW ;   Show ^ZZLEXXA Global
 N I S I=0 F  S I=$O(^ZZLEXX("ZZLEXXS",$J,"HELP",I)) Q:+I'>0  D
 . W !,$G(^ZZLEXX("ZZLEXXS",$J,"HELP",I))
 Q
ATTR ;   Screen Attributes
 N X,%,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM) Q
KATTR ;   Kill Screen Attributes
 D KILL^%ZISS K BOLD,NORM Q
KILL ;   Kill Global
 D KILL^ZZLEXXAA
 Q
SUB(X) ;   Subscript
 S X=$$LR_"T"
 Q X
LR(X) ;   Local Routine
 S X=$T(+1),X=$P(X," ",1) Q X
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N NM S NM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L(NM) W !!,?5,"Invalid/Missing DUZ" Q 0
 S:$G(DUZ(0))'["@" DUZ(0)=$G(DUZ(0))_"@"
 Q 1
 ;
 ; Help Text
HT ;   Addenda Help
 ;;~1) Retrieve the Data File:|
 ;;    
 ;;   Open the Center for Medicare/Medicaid Services (CMS) Web Site
 ;;   
 ;;        ~https://www.cms.gov/Medicare/Medicare.html|
 ;;   
 ;;   Under the heading "Coding" click on ~ICD-10|
 ;;   
 ;;   ICD Diagnosis:
 ;;   
 ;;       On the left, click on ~ICD-10-CM and GEMs| for the fiscal year
 ;;       needed.
 ;;   
 ;;       On the right, click on ~Code Descriptions in Tabular Order| (zip
 ;;       file) and open the file.
 ;;   
 ;;       Click on file with the word ~addenda| in it.  It will be named
 ;;       either:
 ;;       
 ;;          ~icd10cm_order_addenda_yyyy.txt|  or 
 ;;          ~order_addenda_yyyy.txt|
 ;;       
 ;;          (Where yyyy is the fiscal year needed)
 ;;       
 ;;       Save the ICD diagnosis addenda file on the local machine.
 ;;       
 ;;       If not named icd10cm_order_addenda_yyyy.txt 
 ;;       then rename as icd10cm_order_addenda_yyyy.txt
 ;;        
 ;;   
 ;;   ICD Procedures:
 ;;   
 ;;       On the left, click on ~ICD-10-PCS and GEMs| for the fiscal year
 ;;       needed.
 ;;   
 ;;       On the right, click on ~yyyy ICD-10-PCS Order File (Long and 
 ;;       Abbreviated Titles| (zip file) and open the file.
 ;;   
 ;;       Click on file with the word ~addenda| in it.  It will be named
 ;;       either:
 ;;       
 ;;          ~icd10pcs_order_addenda_yyyy.txt| or
 ;;          ~order_addenda_yyyy.txt|
 ;;       
 ;;          (Where yyyy is the fiscal year needed)
 ;;       
 ;;       Save the ICD procedure addenda file on the local machine.
 ;;       
 ;;       If not named icd10pcs_order_addenda_yyyy.txt 
 ;;       then rename as icd10pcs_order_addenda_yyyy.txt
 ;;   
 ;;   Addenda File Format:
 ;;  
 ;;       The addenda file formats for both Diagnosis and Procedures will 
 ;;       be in the following format:
 ;;     
 ;;          Character
 ;;          Positions    Length     Contents
 ;;            1-12         12       Action
 ;;                                    Add
 ;;                                    Delete
 ;;                                    Revise from
 ;;                                    Revise to
 ;;            13            1       Blank
 ;;            14            1       Type
 ;;                                    0 header code
 ;;                                    1 valid code
 ;;            15            1       Blank
 ;;            15-22         8       Code
 ;;            23            1       Blank
 ;;            24-83        60       Short Text
 ;;            84            1       Blank
 ;;            85-End      1-300     Long Text
 ;;        
 ;;~2) Move the Data File:|
 ;;    
 ;;   SFTP the both the diagnosis and procedure addenda files from the 
 ;;   local machine to the export directory:
 ;;  
 ;;       Salt Lake:   VA5$:[BETA]
 ;;       Bay Pines:   /home/sftp/patches/
 ;;       
 ;;       Filenames:   icd10cm_order_addenda_yyyy.txt
 ;;                    icd10pcs_order_addenda_yyyy.txt
 ;;       
 ;;~3) Read and Display SDO Addenda Summary:|
 ;;   
 ;;   Using the import utility:
 ;;   
 ;;       Select menu option ~SDO Addenda|
 ;;        
 ;;   When prompted for the file name make sure to select the host file for
 ;;   the code type (diagnosis - CM or procedures - PCS) and the fiscal year
 ;;   needed.
 ;;   
 ;;       Select either a diagnosis or procedure addenda file:
 ;;       
 ;;           icd10cm_order_addenda_yyyy.txt
 ;;           icd10pcs_order_addenda_yyyy.txt
 ;;       
 ;;           (where yyyy is the fiscal year)
 ;;        
 ;;   It is recommended that "logging" be turned on to capture the output.
 ;;   
 ;;;;;;
