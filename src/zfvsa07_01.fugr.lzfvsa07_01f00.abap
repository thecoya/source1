*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVSA0703........................................*
FORM GET_DATA_ZVSA0703.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTSA0007 WHERE
(VIM_WHERETAB) .
    CLEAR ZVSA0703 .
ZVSA0703-MANDT =
ZTSA0007-MANDT .
ZVSA0703-PERRNR =
ZTSA0007-PERRNR .
ZVSA0703-ENAME =
ZTSA0007-ENAME .
ZVSA0703-ENTDT =
ZTSA0007-ENTDT .
ZVSA0703-GENDER =
ZTSA0007-GENDER .
ZVSA0703-DEPID =
ZTSA0007-DEPID .
<VIM_TOTAL_STRUC> = ZVSA0703.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVSA0703 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVSA0703.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVSA0703-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTSA0007 WHERE
  PERRNR = ZVSA0703-PERRNR .
    IF SY-SUBRC = 0.
    DELETE ZTSA0007 .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTSA0007 WHERE
  PERRNR = ZVSA0703-PERRNR .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTSA0007.
    ENDIF.
ZTSA0007-MANDT =
ZVSA0703-MANDT .
ZTSA0007-PERRNR =
ZVSA0703-PERRNR .
ZTSA0007-ENAME =
ZVSA0703-ENAME .
ZTSA0007-ENTDT =
ZVSA0703-ENTDT .
ZTSA0007-GENDER =
ZVSA0703-GENDER .
ZTSA0007-DEPID =
ZVSA0703-DEPID .
    IF SY-SUBRC = 0.
    UPDATE ZTSA0007 ##WARN_OK.
    ELSE.
    INSERT ZTSA0007 .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVSA0703-UPD_FLAG,
STATUS_ZVSA0703-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ENTRY_ZVSA0703.
  SELECT SINGLE * FROM ZTSA0007 WHERE
PERRNR = ZVSA0703-PERRNR .
ZVSA0703-MANDT =
ZTSA0007-MANDT .
ZVSA0703-PERRNR =
ZTSA0007-PERRNR .
ZVSA0703-ENAME =
ZTSA0007-ENAME .
ZVSA0703-ENTDT =
ZTSA0007-ENTDT .
ZVSA0703-GENDER =
ZTSA0007-GENDER .
ZVSA0703-DEPID =
ZTSA0007-DEPID .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVSA0703 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVSA0703-PERRNR TO
ZTSA0007-PERRNR .
MOVE ZVSA0703-MANDT TO
ZTSA0007-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA0007'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA0007 TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA0007'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
*...processing: ZVSA0704........................................*
FORM GET_DATA_ZVSA0704.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTSA07200701 WHERE
(VIM_WHERETAB) .
    CLEAR ZVSA0704 .
ZVSA0704-MANDT =
ZTSA07200701-MANDT .
ZVSA0704-DEPID =
ZTSA07200701-DEPID .
ZVSA0704-PHONE =
ZTSA07200701-PHONE .
ZVSA0704-BUDGET =
ZTSA07200701-BUDGET .
ZVSA0704-WAERS =
ZTSA07200701-WAERS .
    SELECT SINGLE * FROM ZTSA07200701_T WHERE
DEPID = ZTSA07200701-DEPID AND
SPRAS = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZVSA0704-DTEXT =
ZTSA07200701_T-DTEXT .
    ENDIF.
<VIM_TOTAL_STRUC> = ZVSA0704.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVSA0704 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVSA0704.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVSA0704-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTSA07200701 WHERE
  DEPID = ZVSA0704-DEPID .
    IF SY-SUBRC = 0.
    DELETE ZTSA07200701 .
    ENDIF.
    DELETE FROM ZTSA07200701_T WHERE
    DEPID = ZTSA07200701-DEPID .
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTSA07200701 WHERE
  DEPID = ZVSA0704-DEPID .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTSA07200701.
    ENDIF.
ZTSA07200701-MANDT =
ZVSA0704-MANDT .
ZTSA07200701-DEPID =
ZVSA0704-DEPID .
ZTSA07200701-PHONE =
ZVSA0704-PHONE .
ZTSA07200701-BUDGET =
ZVSA0704-BUDGET .
ZTSA07200701-WAERS =
ZVSA0704-WAERS .
    IF SY-SUBRC = 0.
    UPDATE ZTSA07200701 ##WARN_OK.
    ELSE.
    INSERT ZTSA07200701 .
    ENDIF.
    SELECT SINGLE FOR UPDATE * FROM ZTSA07200701_T WHERE
    DEPID = ZTSA07200701-DEPID AND
    SPRAS = SY-LANGU .
      IF SY-SUBRC <> 0.   "insert preprocessing: init WA
        CLEAR ZTSA07200701_T.
ZTSA07200701_T-DEPID =
ZTSA07200701-DEPID .
ZTSA07200701_T-SPRAS =
SY-LANGU .
      ENDIF.
ZTSA07200701_T-DTEXT =
ZVSA0704-DTEXT .
    IF SY-SUBRC = 0.
    UPDATE ZTSA07200701_T ##WARN_OK.
    ELSE.
    INSERT ZTSA07200701_T .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVSA0704-UPD_FLAG,
STATUS_ZVSA0704-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ENTRY_ZVSA0704.
  SELECT SINGLE * FROM ZTSA07200701 WHERE
DEPID = ZVSA0704-DEPID .
ZVSA0704-MANDT =
ZTSA07200701-MANDT .
ZVSA0704-DEPID =
ZTSA07200701-DEPID .
ZVSA0704-PHONE =
ZTSA07200701-PHONE .
ZVSA0704-BUDGET =
ZTSA07200701-BUDGET .
ZVSA0704-WAERS =
ZTSA07200701-WAERS .
    SELECT SINGLE * FROM ZTSA07200701_T WHERE
DEPID = ZTSA07200701-DEPID AND
SPRAS = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZVSA0704-DTEXT =
ZTSA07200701_T-DTEXT .
    ELSE.
      CLEAR SY-SUBRC.
      CLEAR ZVSA0704-DTEXT .
    ENDIF.
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVSA0704 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVSA0704-DEPID TO
ZTSA07200701-DEPID .
MOVE ZVSA0704-MANDT TO
ZTSA07200701-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA07200701'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA07200701 TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA07200701'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

MOVE ZTSA07200701-DEPID TO
ZTSA07200701_T-DEPID .
MOVE SY-LANGU TO
ZTSA07200701_T-SPRAS .
MOVE ZVSA0704-MANDT TO
ZTSA07200701_T-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA07200701_T'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA07200701_T TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA07200701_T'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
