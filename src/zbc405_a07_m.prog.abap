*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a07_m_top                        .    " Global Data

* INCLUDE ZBC405_A07_M_O01                        .  " PBO-Modules
* INCLUDE ZBC405_A07_M_I01                        .  " PAI-Modules
* INCLUDE ZBC405_A07_M_F01                        .  " FORM-Routines


*SELECT SINGLE depid
*  FROM ztsa2001
*  INTO ( gs_emp-depid )        " ()를 쓰면 corresponding 안써도 된다.
*  WHERE pernr = '20220001'.
*
*WRITE : '사원명', gs_emp-pernr.
*NEW-LINE.
*WRITE : 'ENAME : ', gs_emp-ename.
*NEW-LINE.
*WRITE : '부서코드:', gs_emp-depid.
*WRITE : /'성별:', gs_emp-gender.

*  SELECT SINGLE phone
*    FROM ztsa2002
*    INTO CORRESPONDING FIELDS OF gs_emp
*    WHERE depid = gs_emp-depid.


*"loop문
*SELECT *
*  FROM ztsa2001
*  INTO CORRESPONDING FIELDS OF TABLE gt_emp.
*
*
*
*
*CLEAR gs_emp.
*LOOP AT gt_emp INTO gs_emp.
*  CASE gs_emp-gender.    "연산(+,- 등), 범위로써 조건을 줄때, if문써야함. case문 못씀
*    WHEN '1'.
*      gs_emp-gender_a = '남성'.
*
*    WHEN '2'.
*      gs_emp-gender_a = '여성'.
*  ENDCASE.
*
*
*
*z
*
*  MODIFY gt_emp FROM gs_emp.  "modify 위에 다 쓰기~
*  CLEAR gs_emp.
*ENDLOOP.
*
*
*"Cl_demo_output=>display_data( gt_emp ). "클래스에 들어가 있는 메소드 메소드가 클래스에 존재
*cl_demo_output=>display_data( gt_emp ).

*DATA ls_sb TYPE sbook.
*DATA lt_sb LIKE TABLE OF ls_sb.
*DATA lv_tabix TYPE sy-tabix.
*
*
*SELECT carrid connid fldate bookid customid custtype invoice class smoker
*  FROM sbook
*  INTO CORRESPONDING FIELDS OF TABLE lt_sb
*  WHERE carrid = 'DL'
*  AND custtype = 'P'
*  AND order_date = '20201227'.
*
*
*LOOP AT lt_sb INTO ls_sb.
*
*  lv_tabix = sy-tabix.
*  CASE ls_sb-smoker.
*    WHEN 'X'.
*      IF ls_sb-invoice = 'X'.
*        ls_sb-class = 'F'.
*      ENDIF.
*  ENDCASE.
*  MODIFY lt_sb FROM ls_sb INDEX lv_tabix TRANSPORTING class.  "현재 레코드의 class라는 필드만 modify해줘~
*ENDLOOP.
*
*cl_demo_output=>display_data( lt_sb ).
*
*
*"select single 일때 /  into corresponding fields of lt_Sb --> 한줄만 가져오는 것.



*TYPES: BEGIN OF ty_sf,
*         carrid     TYPE sflight-carrid,
*         connid     TYPE sflight-connid,
*         fldate     TYPE sflight-fldate,
*         currency   TYPE sflight-currency,
*         planetype  TYPE sflight-planetype,
*         seatsocc_b TYPE sflight-seatsocc_b.
*TYPES: END OF ty_sf.
*
*DATA ls_sf TYPE ty_sf.
*DATA lt_sf LIKE TABLE OF ls_sf.
*DATA lv_tabix TYPE sy-tabix.
*
*SELECT carrid connid fldate currency planetype seatsocc_b
*  FROM sflight
*  INTO CORRESPONDING FIELDS OF TABLE lt_sf
*  WHERE currency = 'USD'
*  AND planetype = '747-400'.
*
*LOOP AT lt_sf INTO ls_sf.
*  lv_tabix = sy-tabix.
*
*  IF ls_sf-carrid = 'UA'.
*    ls_sf-seatsocc_b = ls_sf-seatsocc_b + 5.
*  ENDIF.
*  MODIFY lt_sf FROM ls_sf INDEX lv_tabix TRANSPORTING seatsocc_b.
*ENDLOOP.
*
*cl_demo_output=>display_data( lt_sf ).




*TYPES: BEGIN OF ty_mara,
*         matnr TYPE mara-matnr,
*         maktx TYPE makt-maktx,
*         mtart TYPE mara-mtart,
*         matkl TYPE mara-matkl.
*TYPES: END OF ty_mara.
*
*TYPES: BEGIN OF ty_makt,
*         matnr TYPE makt-matnr,
*         maktx TYPE makt-maktx.
*
*TYPES: END OF ty_makt.
*
*DATA : gs_mara TYPE ty_mara,
*       gt_mara LIKE TABLE OF gs_mara,
*       gs_makt TYPE ty_makt,
*       gt_makt LIKE TABLE OF gs_makt.
*
*SELECT matnr mtart matkl
*  FROM mara
*  INTO CORRESPONDING FIELDS OF TABLE gt_mara.
*
*SELECT matnr maktx
*  FROM makt
*  INTO CORRESPONDING FIELDS OF TABLE gt_makt
*  WHERE spras = sy-langu.
*
*
*LOOP AT gt_mara INTO gs_mara.
*  READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_mara-matnr.
*  gs_mara-maktx = gs_makt-maktx.
*
*  MODIFY gt_mara FROM gs_mara INDEX sy-tabix TRANSPORTING maktx.
*
*ENDLOOP.
*
*
*cl_demo_output=>display_data( gt_mara ).



*TYPES : BEGIN OF ty_sp,
*          carrid   TYPE spfli-carrid,
*          carrname TYPE scarr-carrname,
*          url      TYPE scarr-url,
*          connid   TYPE spfli-connid,
*          airpfrom TYPE spfli-airpfrom,
*          airpto   TYPE spfli-airpto,
*          deptime  TYPE spfli-deptime,
*          arrtime  TYPE spfli-arrtime.
*TYPES: END OF ty_sp.
*
*TYPES: BEGIN OF ty_sc,
*         carrid   TYPE scarr-carrid,
*         carrname TYPE scarr-carrname,
*         url      TYPE scarr-url.
*TYPES: END OF ty_sc.
*
*DATA: gs_spfl TYPE ty_sp,
*      gt_spfl LIKE TABLE OF gs_spfl,
*      gs_scar TYPE ty_sc,
*      gt_scar LIKE TABLE OF gs_scar.
*DATA lv_tabix TYPE sy-tabix.
*
*SELECT carrid connid airpfrom airpto deptime arrtime
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF TABLE gt_spfl.
*
*SELECT carrid carrname url
*FROM scarr
*INTO CORRESPONDING FIELDS OF TABLE gt_scar.
*
*LOOP AT gt_spfl INTO gs_spfl.
*  lv_tabix = sy-tabix.
*
*  READ TABLE gt_scar INTO gs_scar WITH KEY carrid = gs_spfl-carrid.
*
*  IF sy-subrc EQ 0.
*    gs_spfl-carrname = gs_scar-carrname.
*    gs_spfl-url = gs_scar-url.
*    MODIFY gt_spfl FROM gs_spfl INDEX lv_tabix TRANSPORTING carrname url.
*  ENDIF.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_spfl ).




TYPES: BEGIN OF ty_data,
         mandt TYPE mara-mandt,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         mtbez TYPE t134t-mtbez,
         mbrsh TYPE mara-mbrsh,
         mbbez TYPE t137t-mbbez,
         tragr TYPE mara-tragr,
         vtext TYPE ttgrt-vtext.
TYPES: END OF ty_data.

DATA : gs_mara TYPE ty_data,
       gt_mara LIKE TABLE OF gs_mara.
DATA : lv_tabix TYPE sy-tabix.

DATA : gs_bez TYPE ty_data,
       gt_bez LIKE TABLE OF gs_bez.

DATA : gs_bbez TYPE ty_data,
       gt_bbez LIKE TABLE OF gs_bbez.

DATA : gs_vt TYPE ty_data,
       gt_vt LIKE TABLE OF gs_vt.

SELECT matnr mtart mbrsh tragr
  FROM mara
  INTO CORRESPONDING FIELDS OF TABLE gt_mara.


SELECT mtart mtbez
  FROM t134t
  INTO CORRESPONDING FIELDS OF TABLE gt_bez
  WHERE spras = sy-langu.

SELECT mbrsh mbbez
  FROM t137t
  INTO CORRESPONDING FIELDS OF TABLE gt_bbez
  WHERE spras = sy-langu.

SELECT tragr vtext
  FROM ttgrt
  INTO CORRESPONDING FIELDS OF TABLE gt_vt
  WHERE spras = sy-langu.

SELECT a~mandt a~matnr b~maktx a~mtart a~mbrsh a~tragr
  FROM mara AS a INNER JOIN makt AS b
  ON a~matnr = b~matnr
  INTO CORRESPONDING FIELDS OF TABLE gt_mara.


LOOP AT gt_mara INTO gs_mara.
  lv_tabix = sy-tabix.

  READ TABLE gt_bez INTO gs_bez WITH KEY mtart = gs_mara-mtart.
  IF sy-subrc EQ 0.
    gs_mara-mtbez = gs_bez-mtbez.
    MODIFY gt_mara FROM gs_mara INDEX lv_tabix TRANSPORTING mtbez.
  ENDIF.

  READ TABLE gt_bbez INTO gs_bbez WITH KEY mbrsh = gs_mara-mbrsh.
  IF sy-subrc EQ 0.
    gs_mara-mbbez = gs_bbez-mbbez.
    MODIFY gt_mara FROM gs_mara INDEX lv_tabix TRANSPORTING mbbez.
  ENDIF.

  READ TABLE gt_vt INTO gs_vt WITH KEY tragr = gs_mara-tragr.
  IF sy-subrc EQ 0.
    gs_mara-vtext = gs_vt-vtext.
    MODIFY gt_mara FROM gs_mara INDEX lv_tabix TRANSPORTING vtext.
  ENDIF.

ENDLOOP.



cl_demo_output=>display_data( gt_mara ).
