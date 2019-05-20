ZZLEXXAS ;SLC/KER - Import - ICD-10-CM - Kewords ;10/26/2017
 ;;1.0;Generic Utility;**1**;Sep 23, 1996
 ;               
 ; Global Variables
 ;    ^ICD9(              ICR   4485
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.02,        SACC 1.3
 ;    ^LEX(757.071        SACC 1.3
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    UPDATE^DIE          ICR   2053
 ;    IX1^DIK             ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    $$STATCHK^LEXSRC2   N/A
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     CODE
 ;               
 Q
SUP ; Supplemental Keywords
 Q:'$L($G(CODE))  N %,DA,DEFF,DHIS,DIEN,DSUP,DTXT,DIERR,EXCL,FD,FDA,FDAI,FND,I
 N IENS,KEY,KEYS,KEYW,KIEN,LIEN,LSUP,LTXT,ND,NM,POP,TD,X,Y S TD=$$DT^XLFDT
 S FD=$$FMADD^XLFDT(TD,273) S DIEN=$O(^ICD9("ABA",30,(CODE_" "),0))
 S LIEN=+($G(^LEX(757.02,+($P($$STATCHK^LEXSRC2(CODE,FD,,"10D"),"^",2)),0)))
 Q:DIEN'>0  Q:'$D(^ICD9(+DIEN,68))  Q:LIEN'>0  Q:'$D(^LEX(757.01,+LIEN,0))
 S DEFF=$O(^ICD9(+DIEN,68,"B",FD),-1),DHIS=$O(^ICD9(+DIEN,68,"B",+DEFF," "),-1)
 S DTXT=$$TX($G(^ICD9(DIEN,68,+DHIS,1))),LTXT=$$TX($G(^LEX(757.01,+LIEN,0)))
 Q:'$L(DTXT)  Q:'$L(LTXT)  K DSUP,LSUP
 S KIEN=0 F  S KIEN=$O(^LEX(757.071,KIEN)) Q:+KIEN'>0  D
 . N FND,I,KEY,KEYS,KEYW,ND S ND=$G(^LEX(757.071,+KIEN,0))
 . S KEYW=$P(ND,"^",1) Q:'$L(KEYW)  S KEYS=$P(ND,"^",4),EXCL=$P(ND,"^",5)
 . S FND=0 F I=1:1 S KEY=$P(KEYS,";",I) Q:'$L(KEY)  D
 . . I $E(DTXT,1,$L(KEY))=KEY S FND=FND+1 Q
 . . I DTXT[(" "_KEY_" ") S FND=FND+1 Q
 . . I $E(DTXT,($L(DTXT)-($L(KEY)-1)),$L(DTXT))=KEY S FND=FND+1
 . F I=1:1 S KEY=$P(EXCL,";",I) Q:'$L(KEY)  D
 . . I $E(DTXT,1,$L(KEY))=KEY S FND=0 Q
 . . I DTXT[(" "_KEY_" ") S FND=0 Q
 . . I $E(DTXT,($L(DTXT)-($L(KEY)-1)),$L(DTXT))=KEY S FND=0
 . S:FND=$L(KEYS,";") DSUP(KEYW)=""
 . S FND=0 F I=1:1 S KEY=$P(KEYS,";",I) Q:'$L(KEY)  D
 . . I $E(LTXT,1,$L(KEY))=KEY S FND=FND+1 Q
 . . I LTXT[(" "_KEY_" ") S FND=FND+1 Q
 . . I $E(LTXT,($L(LTXT)-($L(KEY)-1)),$L(LTXT))=KEY S FND=FND+1
 . F I=1:1 S KEY=$P(EXCL,";",I) Q:'$L(KEY)  D
 . . I $E(LTXT,1,$L(KEY))=KEY S FND=0 Q
 . . I LTXT[(" "_KEY_" ") S FND=0 Q
 . . I $E(LTXT,($L(LTXT)-($L(KEY)-1)),$L(LTXT))=KEY S FND=0
 . S:FND=$L(KEYS,";") LSUP(KEYW)=""
 D:$L($O(DSUP(""))) ICDS
 D:$L($O(LSUP(""))) LEXS
 Q
ICDS ;   Add ICD DX Supplemental Key Words
 ;     Supplemental Keyword       80.682     .01
 Q:+($G(DIEN))'>0  Q:'$D(^ICD9(+($G(DIEN)),0))
 Q:+($G(DHIS))'>0  Q:'$D(^ICD9(+($G(DIEN)),68,+($G(DHIS)),1))
 S KEY="" F  S KEY=$O(DSUP(KEY)) Q:'$L(KEY)  D
 . Q:$D(^ICD9(DIEN,68,DHIS,2,"B",KEY))
 . N DA,FDA,FDAI,DIERR,IENS K DIERR,FDA,DA
 . S DA(2)=+($G(DIEN)),DA(1)=+($G(DHIS)),IENS=("+1,"_DA(1)_","_DA(2)_",")
 . S DA=$O(^ICD9(DIEN,68,DHIS,2," "),-1)+1
 . S FDA(80.682,IENS,.01)=KEY
 . S FDAI(1)=DA
 . D UPDATE^DIE(,"FDA","FDAI","DIERR")
 . D:$D(DIERR) ERR
 Q
LEXS ;   Add Lexicon Supplemental Keywords
 ;     Supplemental Keyword       757.18     .01
 Q:+($G(LIEN))'>0  Q:'$D(^LEX(757.01,+($G(LIEN)),0))  Q:'$L($O(LSUP("")))
 N KEY,DA,DIK S KEY="" F  S KEY=$O(LSUP(KEY)) Q:'$L(KEY)  D
 . Q:$D(^LEX(757.01,+($G(LIEN)),5,"B",KEY))
 . N DA,FDA,FDAI,DIERR,IENS K DIERR,FDA,DA
 . S DA(1)=+($G(LIEN)),IENS=("+1,"_DA(1)_",")
 . S DA=$O(^LEX(757.01,LIEN,5," "),-1)+1
 . S FDA(757.18,IENS,.01)=KEY
 . S FDAI(1)=DA
 . D UPDATE^DIE(,"FDA","FDAI","DIERR")
 . D:$D(DIERR) ERR
 S DA=+($G(LIEN)),DIK="^LEX(757.01," D IX1^DIK
 Q
 ;  
 ; Miscellaneous
ERR ;   Errors
 N SEQ S SEQ=0 F  S SEQ=$O(DIERR("DIERR",$J,SEQ)) Q:+SEQ'>0  D
 . N TI,TX S TI=0 F  S TI=$O(DIERR("DIERR",$J,SEQ,"TEXT",TI)) Q:+TI'>0  D
 . . N TMP,TXI S TMP=$G(DIERR("DIERR",$J,SEQ,"TEXT",TI)) Q:'$L(TMP)
 . . S TXI=$O(TX(" "),-1)+1,TX(TXI)=TMP
 . Q:$O(TX(0))'>0  D PR^ZZLEXXAM(.TX,50) S TX(1)="ERROR>>  "
 . W !,?2,$G(TX(1)) S TI=1 F  S TI=$O(TX(TI)) Q:+TI'>0  W !,?11,$G(TX(TI))
 Q
TX(X) ;   Format ICD Text
 S X=$$UP^XLFSTR($$TM($$DS($$DQ($$CTL($G(X))))))
 Q X
CTL(X) ;   Remove Control Characters
 Q $$CTL^ZZLEXXAM($G(X))
DQ(X) ;   Remove Double Quotes (there are no double quotes in ICD)
 Q $TR($G(X),"""","")
DS(X) ;   Remove Double Space
 S X=$G(X) Q:X="" X
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,299)
 Q X
TM(X,Y) ;   Trim Character Y - Default " " Space
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
KILL ;   Kill Global
 D KILL^ZZLEXXAA
 Q
LOC(X) ;   Local Namespace
 X "S X=$ZNSPACE" Q X
LR(X) ;   Local Routine
 S X=$T(+1),X=$P(X," ",1) Q X
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N NM S NM=$$GET1^DIQ(200,(DUZ_","),.01)
 I '$L(NM) W !!,?5,"Invalid/Missing DUZ" Q 0
 S:$G(DUZ(0))'["@" DUZ(0)=$G(DUZ(0))_"@"
 Q 1
