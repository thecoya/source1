*&---------------------------------------------------------------------*
*& Include          YCL107_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
FORM SELECT_DATA .
REFRESH GT_SCARR. " ITAB 초기화

" CLEAR GT_SCARR  ->Headerline이 있나 없나 찾아봐야함
" CLEAR GT_SCARR[].

SELECT *
  FROM SCARR
  WHERE CARRID IN @S_CARRID     "필드끼리 계산이 가능하다 ?
  AND CARRNAME IN @S_CARRNM
  INTO  TABLE @GT_SCARR.   ""@ 언제든지 값이 변하는 변수다. 의미

SORT GT_SCARR BY CARRID.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT_0100 .
CREATE OBJECT GR_CON
  EXPORTING
    REPID                       = SY-REPID "프로그램명 적어도 된다.                 " Report to Which This Docking Control is Linked
    DYNNR                       = SY-DYNNR                 " Screen to Which This Docking Control is Linked

    EXTENSION                   = 5000               " "dock화면 크기 Control Extension
*    STYLE                       =                  " Windows Style Attributes Applied to This Docking Container
*    LIFETIME                    = LIFETIME_DEFAULT " Lifetime
*    CAPTION                     =                  " Caption
*    METRIC                      = 0                " Metric
*    RATIO                       =                  " Percentage of Screen: Takes Priority Over EXTENSION
*    NO_AUTODEF_PROGID_DYNNR     =                  " Don't Autodefined Progid and Dynnr?
*    NAME                        =                  " Name
  EXCEPTIONS   "에러상황일 때, sy-subrc의 변수에 이런 상황의 에러숫자가 들어감
    CNTL_ERROR                  = 1                " Invalid Parent Control
    CNTL_SYSTEM_ERROR           = 2                " System Error
    CREATE_ERROR                = 3                " Create Error
    LIFETIME_ERROR              = 4                " Lifetime Error
    LIFETIME_DYNPRO_DYNPRO_LINK = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
    OTHERS                      = 6.

"subrc에 어떤 값으로 설정할거냐/숫자 바꿔도된다.


CREATE OBJECT GR_SPLIT    "위 아래로 쪼개진 상태
  EXPORTING
    PARENT                  = GR_CON                  " Parent Container
    ROWS                    = 2                   " Number of Rows to be displayed
    COLUMNS                 = 1                   " Number of Columns to be Displayed
  EXCEPTIONS
    CNTL_ERROR              = 1                  " See Superclass
    CNTL_SYSTEM_ERROR       = 2                  " See Superclass
    OTHERS                  = 3.


*CALL METHOD GR_SPLIT->GET_CONTAINER
*  EXPORTING
*    ROW       =                  " Row
*    COLUMN    =                  " Column
**  RECEIVING
**    CONTAINER =                  " Container.


*GR_SPLIT->GET_CONTAINER(
*  EXPORTING
*    ROW       =                  " Row
*    COLUMN    =                  " Column
**  RECEIVING
**    CONTAINER =                  " Container
*).


"METHOD는 특별하게 RECEIVING 이있는데 단 하나의 변수만 적을 수 있다.
" CALL METHOD는 따로 써야함

" ALV 공간은 만들었다/
GR_CON_TOP = GR_SPLIT->GET_CONTAINER( ROW = 1 COLUMN = 1 ).
GR_CON_ALV = GR_SPLIT->GET_CONTAINER( ROW = 1 COLUMN = 1 ).



CREATE OBJECT GR_ALV
  EXPORTING
    I_PARENT                = GR_CON_ALV                 " Parent Container
  EXCEPTIONS
    ERROR_CNTL_CREATE       = 1                " Error when creating the control
    ERROR_CNTL_INIT         = 2                " Error While Initializing Control
    ERROR_CNTL_LINK         = 3                " Error While Linking Control
    ERROR_DP_CREATE         = 4                " Error While Creating DataProvider Control
    OTHERS                  = 5.

* GR_ALV = NEW CL_GUI_ALV_GRID( I_PARENT = GR_CON_ALV ).  "의미?
* GR_ALV = NEW #( I_PARENT = GR_CON_ALV ). "4~5년된 문법


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV_LAYOUT_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_LAYOUT_0100 .
"SHIFT + SPACE 단축키

  CLEAR GS_LAYOUT.
  GS_LAYOUT-ZEBRA = ABAP_ON. "옵션을 킨다!
  GS_LAYOUT-SEL_MODE = 'D'.  "A: 행열, B:단일행, C:복수행, D:셀단위 B, C는  ㅜㅐ 갲
  GS_LAYOUT-CWIDTH_OPT = ABAP_ON. "데이터가 많으면 출력할 때 느려짐

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_FIELDCAT_0100 .
"함수를 이용한 FC만들기 / 함수를 이용해서 만들면 편하다? 이유는?

  DATA LT_FIELDCAT TYPE KKBLO_T_FIELDCAT. "앞에 LVC만 뺀 느낌 ?

  CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
    EXPORTING
      I_CALLBACK_PROGRAM     = SY-REPID                " Internal table declaration program
      I_TABNAME              = 'GS_SCARR' "ITAB 변수가 아니라 구조체가 들어가야 한다.                 " Name of table to be displayed
      I_STRUCNAME            = 'SCARR'  "SCARR를
      I_INCLNAME             = SY-REPID
      I_BYPASSING_BUFFER     = ABAP_ON   "메모리에 저장된 값을 가지고 올것인지            "자주쓰는 메모리를 저장해서 기억함   " Ignore buffer while reading
      I_BUFFER_ACTIVE        = ABAP_OFF  "메모레어서 가져온 값을 저장할 건지?
    CHANGING
      CT_FIELDCAT            = LT_FIELDCAT                 " Field Catalog with Field Descriptions
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      OTHERS                 = 2.

IF LT_FIELDCAT[] IS INITIAL.      "KKB를 ALV로 변환화는 과정 !
MESSAGE '필드 카탈로그 구성 중 오류가 발생했습니다.' TYPE 'E'.
ELSE.
  CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
    EXPORTING
      IT_FIELDCAT_KKBLO         = LT_FIELDCAT
    IMPORTING
      ET_FIELDCAT_LVC           = GT_FIELDCAT
    EXCEPTIONS
      IT_DATA_MISSING           = 1
      OTHERS                    = 2.

ENDIF.

ENDFORM.

" KKBLO랑 ALV랑 필드 개수 비슷, SSRL? 필드 개수가 적다
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV_0100 .
CALL METHOD GR_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING

    IS_LAYOUT                     =  GS_LAYOUT                " Layout
  CHANGING
    IT_OUTTAB                     = GT_SCARR[]                 " Output Table
    IT_FIELDCATALOG               = GT_FIELDCAT[]                 " Field Catalog
  EXCEPTIONS
    INVALID_PARAMETER_COMBINATION = 1                " Wrong Parameter
    PROGRAM_ERROR                 = 2                " Program Errors
    TOO_MANY_LINES                = 3                " Too many Rows in Ready for Input Grid
    OTHERS                        = 4.

ENDFORM.
