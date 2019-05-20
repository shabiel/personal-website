ZZLEXXAB ;SLC/KER - Import - ICD-10-CM - Verify ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^ICD9(              ICR   4485
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.02         SACC 1.3
 ;    ^LEX(757.1          SACC 1.3
 ;    ^LEX(757.11         SACC 1.3
 ;    ^LEX(757.12         SACC 1.3
 ;    ^ZZLEXX("ZZLEXXA"   SACC 1.3
 ;               
 ; External References
 ;    IX1^DIK             ICR  10013
 ;    IX2^DIK             ICR  10013
 ;    $$CODEABA^ICDEX     ICR   5747
 ;    $$STATCHK^ICDEX     ICR   5747
 ;    $$MIX^LEXXM         N/A
 ;    $$LOW^XLFSTR        ICR  10104
 ;    $$UP^XLFSTR         ICR  10104
 ;    $$PATCH^XPDUTL      ICR  10141
 ;               
 ; Local Variables NEWed or KILLed in ZZLEXXAA
 ;     COMMIT,ERR,LEFF,QUIET,TEST
 ;               
 Q
NTO ; Compare New (Host File) to Old (on File)
 ;   Get Path and Open Host File
 Q:$G(LEFF)'?7N  N EXIT W:'$D(COMMIT)&('$D(QUIET)) ! S EXIT=0 F  D  S EXIT=$$EOF^ZZLEXXAM Q:EXIT>0
 . N ACT,CODE,EIEN,EXC,FLAG,FLTXD,FLTXT,LEXEXP,LEXLSM,LEXLST,LEXLSC,LEXFSM,LEXFST,LEXFSC
 . N FSTAD,FSTAT,FSTXD,FSTXT,HIEN,LEXE,LEXD,LEXN,LEXS,LEXT,LINE,LLTXD,LLTXT,LSTAD,LSTAT
 . N LSTXD,LSTXT,SIEN,TIEN,X,Y
 . S EXC="U IO R LINE U IO(0)" X EXC U IO(0) S LINE=$TR(LINE,$C(9)," ") Q:'$L($$TM^ZZLEXXAA(LINE))
 . ;   Get Load Data
 . ;     Flag                15      1
 . S FLAG=+($E(LINE,15)) Q:FLAG'>0
 . ;     Code                 7      7
 . S CODE=$E(LINE,7,14) I CODE["*" D  Q
 . . S CODE=$$TM^ZZLEXXAA($TR(CODE,"*.","")),CODE=$E(CODE,1,3)_"."_$E(CODE,4,$L(CODE))
 . S CODE=$$TM^ZZLEXXAA(CODE)
 . I '$L(CODE),$L($$TM^ZZLEXXAA(LINE)) D  Q
 . . D ERR^ZZLEXXAA(("Code missing "_$G(CODE)),$G(CODE)) S ERR=+($G(ERR))+1
 . S CODE=$$TM^ZZLEXXAA($E(CODE,1,3)_"."_$E(CODE,4,$L(CODE)))
 . I $E(CODE,1)'?1U!($L($P(CODE,".",1))'=3) D  Q
 . . D ERR^ZZLEXXAA(("Code invalid format "_$G(CODE)),$G(CODE)) S ERR=+($G(ERR))+1
 . ;     Short Description   17     60
 . S LSTXT=$$TM^ZZLEXXAA($E(LINE,17,77)),LSTXD=LEFF
 . I $L(LSTXT)<1!($L(LSTXT)>60) D  Q
 . . I $L(LSTXT)<1 D ERR^ZZLEXXAA("Diagnosis field missing ",$G(CODE)) S ERR=+($G(ERR))+1
 . . I $L(LSTXT)>60 D ERR^ZZLEXXAA(("Diagnosis field too long """_$G(LSTXT)_""""),$G(CODE)) S ERR=+($G(ERR))+1
 . ;     Long Description    78     End
 . S LLTXT=$$TM^ZZLEXXAA($E(LINE,78,$L(LINE))),LLTXD=LEFF
 . I $L(LLTXT)<1!($L(LLTXT)>245) D  Q
 . . I $L(LLTXT)<1 D ERR^ZZLEXXAA("Description field missing ",$G(CODE)) S ERR=+($G(ERR))+1
 . . I $L(LLTXT)>245 D ERR^ZZLEXXAA(("Description field to long """_$G(LLTXT)_""""),$G(CODE)) S ERR=+($G(ERR))+1
 . S LSTAT=1,LSTAD=LEFF,ACT="NC"
 . ;     Lexicon
 . S LEXEXP=$G(LLTXT) S:$$UP^XLFSTR(LLTXT)=LLTXT LEXEXP=$$MIX^LEXXM(LLTXT)
 . S LEXLSM=$$SM^ZZLEXXAM(CODE,30),LEXLSC=$P(LEXLSM,"^",1),LEXLST=$P(LEXLSM,"^",2)
 . I '$D(^LEX(757.11,+LEXLSC,0)) D
 . . D ERR^ZZLEXXAA(("Invalid Semantic Class "_LEXLSC),$G(CODE)) S ERR=+($G(ERR))+1 S EXIT=1 Q
 . I '$D(^LEX(757.12,+LEXLST,0)) D
 . . D ERR^ZZLEXXAA(("Invalid Semantic Type "_LEXLSC),$G(CODE)) S ERR=+($G(ERR))+1 S EXIT=1 Q
 . ;   Save Load Data
 . S:$L($G(CODE)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SO")=$G(CODE)
 . S:$G(LEFF)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"EF")=$G(LEFF)
 . S:"^0^1^"[("^"_$G(LSTAT)_"^") ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SA","LOAD")=LSTAT
 . S:$G(LEFF)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AD","LOAD")=$G(LEFF)
 . S ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AS","LOAD")="1"
 . S:$L($G(LSTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"ST","LOAD")=LSTXT
 . S:$G(LSTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SD","LOAD")=LSTXD
 . S:$L($G(LLTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LT","LOAD")=LLTXT
 . S:$G(LLTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LD","LOAD")=LLTXD
 . S:$L($G(LEXEXP)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","LOAD")=LEXEXP
 . S:$L($G(LEXLSM)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMAP")=LEXLSM
 . S:$L($G(LEXLSC))&($D(^LEX(757.11,+($G(LEXLSC)),0))) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMSC")=LEXLSC
 . S:$L($G(LEXLST))&($D(^LEX(757.12,+($G(LEXLST)),0))) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMST")=LEXLST
 . ;   Get On-File Data
 . S TIEN=$$CODEABA^ICDEX(CODE,80,30) S:+TIEN'>0 ACT="AD"
 . S:+($G(TIEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"IE","LOAD")=TIEN
 . S (LEXT,LEXD,FSTXT,FSTXD,FLTXT,FLTXD,FSTAT,FSTAD,HIEN)="" I +TIEN>0 D
 . . ;     Status and Effective Date
 . . S (LEXS,SIEN,EIEN,LEXT,LEXD,LEXN)="" S LEXT=$$LEX^ZZLEXXAA(CODE,$G(LEFF))
 . . I +LEXT'>0 S (LEXS,SIEN,EIEN,LEXT,LEXD,LEXE,LEXN)=""
 . . I +LEXT>0 D
 . . . N MIEN S SIEN=$P(LEXT,"^",1),EIEN=$P(LEXT,"^",2),LEXS=$P(LEXT,"^",3)
 . . . S LEXD=$P(LEXT,"^",4),LEXT=$P(LEXT,"^",5),LEXN=$$MIX^LEXXM(LLTXT)
 . . . S LEXE=$G(^LEX(757.01,+EIEN,0)),MIEN=$P($G(^LEX(757.02,+SIEN,0)),"^",4)
 . . . S LEXFSM=$O(^LEX(757.1,"B",+MIEN,0))
 . . . S LEXFSM=$P($G(^LEX(757.1,+LEXFSM,0)),"^",2,3)
 . . . S LEXFSC=$P(LEXFSM,"^",1),LEXFST=$P(LEXFSM,"^",2)
 . . S FSTAT=$$STATCHK^ICDEX(CODE,($G(LEFF)+.0001),30)
 . . S FSTAD=$P(FSTAT,"^",3),FSTAT=$P(FSTAT,"^",1)
 . . ;     Short Description
 . . S FSTXD=$O(^ICD9(+TIEN,67,"B",($G(LEFF)+.0001)),-1)
 . . S HIEN=$O(^ICD9(+TIEN,67,"B",+FSTXD," "),-1)
 . . S FSTXT=$P($G(^ICD9(+TIEN,67,+HIEN,0)),"^",2)
 . . I $$UP^XLFSTR(FSTXT)=FSTXT,$$UP^XLFSTR(LSTXT)'=LSTXT,$$UP^XLFSTR(FSTXT)=$$UP^XLFSTR(LSTXT),+TIEN>0,+HIEN>0 D
 . . . N DA,DIK
 . . . S DA=TIEN,DIK="^ICD9(" D IX2^DIK S (FSTXT,$P(^ICD9(+TIEN,67,+HIEN,0),"^",2))=LSTXT
 . . . S DA=TIEN,DIK="^ICD9(" D IX1^DIK
 . . ;     Long Description
 . . S FLTXD=$O(^ICD9(+TIEN,68,"B",($G(LEFF)+.0001)),-1)
 . . S HIEN=$O(^ICD9(+TIEN,68,"B",+FLTXD," "),-1)
 . . S FLTXT=$P($G(^ICD9(+TIEN,68,+HIEN,1)),"^",1)
 . . I $$UP^XLFSTR(FLTXT)=FLTXT,$$UP^XLFSTR(LLTXT)'=LLTXT,$$UP^XLFSTR(FLTXT)=$$UP^XLFSTR(LLTXT),+TIEN>0,+HIEN>0 D
 . . . N DA,DIK
 . . . S DA=TIEN,DIK="^ICD9(" D IX2^DIK S (FLTXT,^ICD9(+TIEN,68,+HIEN,1))=LLTXT
 . . . S DA=TIEN,DIK="^ICD9(" D IX1^DIK
 . . ;     Get Action
 . . I +FSTAT>0 D
 . . . Q:'$L($G(LSTXT))  Q:'$L($G(LLTXT))  Q:'$L($G(FSTXT))  Q:'$L($G(FLTXT))
 . . . Q:$G(LEFF)'?7N  Q:$G(FSTXD)'?7N  Q:$G(FLTXD)'?7N
 . . . I $$TX^ZZLEXXAA(FSTXT)'=$$TX^ZZLEXXAA(LSTXT),$$TX^ZZLEXXAA(FLTXT)=$$TX^ZZLEXXAA(LLTXT),FSTXD'>$G(LSTXD) S ACT="SR"
 . . . I $$TX^ZZLEXXAA(FLTXT)'=$$TX^ZZLEXXAA(LLTXT),$$TX^ZZLEXXAA(FSTXT)=$$TX^ZZLEXXAA(LSTXT),FLTXD'>$G(LLTXD) S ACT="FR"
 . . . I $$TX^ZZLEXXAA(FSTXT)'=$$TX^ZZLEXXAA(LSTXT),FSTXD'>$G(LSTXD) I $$TX^ZZLEXXAA(FLTXT)'=$$TX^ZZLEXXAA(LLTXT),FLTXD'>$G(LLTXD) S ACT="BR"
 . . I +FSTAT'>0 D
 . . . S ACT="RA" S:$$TX^ZZLEXXAA(FSTXT)'=$$TX^ZZLEXXAA(LSTXT)!($$TX^ZZLEXXAA(FLTXT)'=$$TX^ZZLEXXAA(LLTXT)) ACT="RU"
 . . ;   Save ICD On-File Data
 . . S:$G(LEFF)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"EF")=$G(LEFF)
 . . S:$L($G(CODE)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SO")=$G(CODE)
 . . S:$L($G(FSTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"ST","FILE")=FSTXT
 . . S:$G(FSTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SD","FILE")=FSTXD
 . . S:$L($G(FLTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LT","FILE")=FLTXT
 . . S:$G(FLTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LD","FILE")=FLTXD
 . . S:$G(FSTAT)?1N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AS","FILE")=FSTAT
 . . S:$G(FSTAD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AD","FILE")=FSTAD
 . . S:+($G(TIEN)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"IE","FILE")=TIEN
 . . ;   Save Lexicon On-File Data
 . . S:+($G(SIEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SIEN")=SIEN
 . . S:+($G(EIEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EIEN")=EIEN
 . . S:$G(LEXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EFFD")=LEXD
 . . S:$L($G(LEXN)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","NEWT")=LEXN
 . . S:$L($G(LEXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EXPR")=LEXT
 . . S:$L($G(LEXE)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","FILE")=$G(LEXE)
 . . S:$L($G(LEXFSM))>1 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMAP")=LEXFSM
 . . S:$L($G(LEXFSC))&($D(^LEX(757.11,+($G(LEXFSC)),0))) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMSC")=LEXFSC
 . . S:$L($G(LEXFST))&($D(^LEX(757.12,+($G(LEXFST)),0))) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SMST")=LEXFST
 . . S:"^0^1^"[("^"_$G(LEXS)_"^") ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","LEXS")=LEXS
 . I "^NC^SR^IA^RA^"'[("^"_ACT_"^"),$$PATCH^XPDUTL("LEX*2.0*103")'>0,$L(LEXEXP)>240 D
 . . D ERR^ZZLEXXAA(("Lexicon Expression too long >240 """_LEXEXP_""""),$G(CODE)) S ERR=+($G(ERR))+1 S EXIT=1 Q
 . I "^NC^SR^IA^RA^"'[("^"_ACT_"^"),$$PATCH^XPDUTL("LEX*2.0*103")>0,$L(LEXEXP)>4000 D
 . . D ERR^ZZLEXXAA(("Lexicon Expression too long >4000 """_LEXEXP_""""),$G(CODE)) S ERR=+($G(ERR))+1 S EXIT=1 Q
 . I ACT'="NC",$D(TEST) D WRT^ZZLEXXAA
 . S:$L($G(ACT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AC")=$G(ACT)
 . S:$L($G(ACT)) TOT(ACT)=+($G(TOT(ACT)))+1 S TOT=+($G(TOT))+1
 Q
 ;
OTN ; Compare Old (on File) to New (Host File in ^ZZLEXXA)
 ;   Get Inactivations
 Q:$G(LEFF)'?7N  N ORD S ORD="" F  S ORD=$O(^ICD9("ABA",30,ORD)) Q:'$L(ORD)  D
 . N IEN S IEN=0 F  S IEN=$O(^ICD9("ABA",30,ORD,IEN)) Q:+IEN'>0  D
 . . N ACT,CODE,EIEN,FLTXD,FLTXT,FSTAD,FSTAT,FSTXD,FSTXT,HIEN,LEXD,LEXN,LEXS,LEXT,SIEN
 . . S CODE=$P($G(^ICD9(+IEN,0)),"^",1) Q:'$L(CODE)  Q:$D(^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" ")))
 . . ;     Status and Effective Date  FSTAT/FSTAD
 . . S FSTAD=$O(^ICD9(+IEN,66,"B",(LEFF+.0001)),-1)
 . . S HIEN=$O(^ICD9(+IEN,66,"B",+FSTAD," "),-1)
 . . S FSTAT=$P($G(^ICD9(+IEN,66,+HIEN,0)),"^",2)
 . . Q:+FSTAT'=1
 . . S ACT="IA"
 . . ;     Short Description          FSTXT,FSTXD
 . . S FSTXD=$O(^ICD9(+IEN,67,"B",(LEFF+.0001)),-1)
 . . S HIEN=$O(^ICD9(+IEN,67,"B",+FSTXD," "),-1)
 . . S FSTXT=$P($G(^ICD9(+IEN,67,+HIEN,0)),"^",2)
 . . ;     Long Description           FLTXT,FLTXD
 . . S FLTXD=$O(^ICD9(+IEN,68,"B",(LEFF+.0001)),-1)
 . . S HIEN=$O(^ICD9(+IEN,68,"B",+FLTXD," "),-1)
 . . S FLTXT=$P($G(^ICD9(+IEN,68,+HIEN,1)),"^",1)
 . . ;     Lexicon Term
 . . S (LEXT,LEXD,LEXN)="" S LEXT=$$LEX^ZZLEXXAA(CODE,LEFF) S:+LEXT'>0 (LEXD,LEXT)=""
 . . I +LEXT>0 D
 . . . S SIEN=$P(LEXT,"^",1),EIEN=$P(LEXT,"^",2),LEXS=$P(LEXT,"^",3),LEXD=$P(LEXT,"^",4),LEXT=$P(LEXT,"^",5)
 . . ;     Save ICD On-File Data
 . . S ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AS","LOAD")="0"
 . . S ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AD","LOAD")=$G(LEFF)
 . . S:$G(LEFF)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"EF")=$G(LEFF)
 . . S:$L($G(CODE)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SO")=$G(CODE)
 . . S:$L($G(FSTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"ST","FILE")=FSTXT
 . . S:$G(FSTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SD","FILE")=FSTXD
 . . S:$L($G(FLTXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LT","FILE")=FLTXT
 . . S:$G(FLTXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LD","FILE")=FLTXD
 . . S:$G(FSTAT)?1N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"SA","FILE")=FSTAT
 . . S:$G(FSTAD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"EF","FILE")=FSTAD
 . . S:+($G(IEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"IE","FILE")=IEN
 . . ;     Save Lexicon On-File Data
 . . S:$G(FSTAD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AD","FILE")=FSTAD
 . . S:"^0^1^"[("^"_$G(FSTAT)_"^") ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AS","FILE")=FSTAT
 . . S:+($G(SIEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","SIEN")=SIEN
 . . S:+($G(EIEN))>0 ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EIEN")=EIEN
 . . S:$G(LEXD)?7N ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EFFD")=LEXD
 . . S:$L($G(LEXT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","EXPR")=LEXT
 . . S:"^0^1^"[("^"_$G(LEXS)_"^") ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"LX","LEXS")=LEXS
 . . S TOT=+($G(TOT))+1
 . . S:$L($G(ACT)) ^ZZLEXX("ZZLEXXA",$J,"ICD",(CODE_" "),"AC")=$G(ACT)
 . . S:$L($G(ACT)) TOT(ACT)=+($G(TOT(ACT)))+1
 . . S TOT=+($G(TOT))+1
 . . D:$D(TEST) WRT^ZZLEXXAA
 Q
UP ;   Uppercase
 D UPS,UPL
 Q
UPL ;   Uppercase Descriptions (COMMIT to change)
 N TOT,IEN S IEN=500000 F  S IEN=$O(^ICD9(IEN)) Q:+IEN'>0  D
 . N HIEN,UP S (UP,HIEN)=0 F  S HIEN=$O(^ICD9(IEN,68,HIEN)) Q:+HIEN'>0  D
 . . N TXT S TXT=$G(^ICD9(IEN,68,HIEN,1)) I $$UP^XLFSTR(TXT)=TXT D
 . . . N ALT S ALT=$$UP^XLFSTR($E(TXT,1))_$$LOW^XLFSTR($E(TXT,2,$L(TXT)))
 . . . S ALT=$$MIX^LEXXM(TXT)
 . . . W !,IEN,?8,HIEN,?11,TXT
 . . . W !,?11,ALT
 . . . S UP=1,TOT("LTX")=$G(TOT("LTX"))+1
 . . . I $D(COMMIT) D
 . . . . N DA,DIK
 . . . . S DA=IEN,DIK="^ICD9(" D IX2^DIK S ^ICD9(IEN,68,HIEN,1)=ALT W !,"."
 . . . . S DA=IEN,DIK="^ICD9(" D IX1^DIK
 . S:UP>0 TOT("REC")=$G(TOT("REC"))+1
 W !!,"Records with Uppercase Descriptions:  ",+($G(TOT("REC")))
 W !,"Uppercase Descriptions:               ",+($G(TOT("LTX"))),!
 Q
UPS ;   Uppercase Short Text (COMMIT to change)
 N TOT,IEN S IEN=500000 F  S IEN=$O(^ICD9(IEN)) Q:+IEN'>0  D
 . N HIEN,UP S (UP,HIEN)=0 F  S HIEN=$O(^ICD9(IEN,67,HIEN)) Q:+HIEN'>0  D
 . . N TXT S TXT=$P($G(^ICD9(IEN,67,HIEN,0)),"^",2) I $$UP^XLFSTR(TXT)=TXT D
 . . . N ALT S ALT=$$UP^XLFSTR($E(TXT,1))_$$LOW^XLFSTR($E(TXT,2,$L(TXT)))
 . . . S ALT=$$MIX^LEXXM(TXT)
 . . . W !,IEN,?8,HIEN,?11,TXT
 . . . W !,?11,ALT
 . . . S UP=1,TOT("LTX")=$G(TOT("LTX"))+1
 . . . I $D(COMMIT) D
 . . . . N DA,DIK
 . . . . S DA=IEN,DIK="^ICD9(" D IX2^DIK S $P(^ICD9(IEN,67,HIEN,0),"^",2)=ALT W !,"."
 . . . . S DA=IEN,DIK="^ICD9(" D IX1^DIK
 . S:UP>0 TOT("REC")=$G(TOT("REC"))+1
 W !!,"Records with Uppercase Short Text:    ",+($G(TOT("REC")))
 W !,"Uppercase Short Text:                 ",+($G(TOT("LTX"))),!
 Q
KILL ;   Kill Global
 D KILL^ZZLEXXAA
 Q
