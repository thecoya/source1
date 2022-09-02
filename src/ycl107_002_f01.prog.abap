*&---------------------------------------------------------------------*
*& Include          YCL107_002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form REFRESH_GRID_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_GRID_0100 .
CHECK GR_ALV IS BOUND.

DATA LS_STABLE TYPE LVC_S_STBL.
LS_STABLE-ROW = ABAP_OFF.
LS_STABLE-COL = ABAP_ON.

CALL METHOD GR_ALV->REFRESH_TABLE_DISPLAY
  EXPORTING
    IS_STABLE      = LS_STABLE
    I_SOFT_REFRESH = SPACE
  EXCEPTIONS
    FINISHED       = 1
    OTHERS         = 2.
"새로고침 할때 마다 유지 OR NOT 유지 / SPACE: 설정된 필터나, 정렬정보를 초기화
                                 " 'X' : 설정된 필터나 정렬을 유지

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

GR_CON = NEW CL_GUI_CUSTOM_CONTAINER(
      CONTAINER_NAME = 'MY_CONTAINER' ).

GR_ALV = NEW CL_GUI_ALV_GRID(
  I_PARENT = GR_CON ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SELECT_dATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SELECT_DATA .

REFRESH GT_SCARR.

"검색조건을 위해 RANGE 설정  " FOR 뒤에 변수 타입에 따라 LOW-HIGH 자동 설정?
" SEL-OPT 화면에서만 쓰는 NO INTERVALS 등
" RANGES는  HEADER + ITAB을 선언

RANGES LR_CARRID FOR SCARR-CARRID.
RANGES LR_CARRNAME FOR SCARR-CARRNAME.

IF SCARR-CARRID IS INITIAL AND SCARR-CARRNAME IS INITIAL.
"ID와 이름이 둘다 공란인 경우
ELSEIF SCARR-CARRID IS INITIAL.
  "이름은 공란이 아닌 경우
  LR_CARRNAME-SIGN = 'I'.
  LR_CARRNAME-OPTION = 'EQ'.
  LR_CARRNAME-LOW = SCARR-CARRNAME.
  APPEND LR_CARRNAME.
  CLEAR LR_CARRNAME.

ELSEIF  SCARR-CARRNAME IS INITIAL.
  "ID가 공란이 아닌 경우
 LR_CARRID-SIGN = 'I'.
 LR_CARRID-OPTION = 'EQ'.
 LR_CARRID-LOW = SCARR-CARRID.
 APPEND LR_CARRID.
 CLEAR LR_CARRID.
*  ELSE. / "ID와 이름이 둘다 공란이 아닌 경우
ENDIF.

SELECT *
  FROM SCARR
  WHERE CARRID IN @LR_CARRID
  AND CARRNAME IN @LR_CARRNAME
  INTO TABLE @GT_SCARR.


ENDFORM.


"ITAB을 초기화 / RANGE변수 세팅 / SELECT
*&---------------------------------------------------------------------*
*& Form SET_ALV_LAYOUT_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_LAYOUT_0100 .
CLEAR  GS_LAYOUT.

GS_LAYOUT-ZEBRA = ABAP_ON.
GS_LAYOUT-SEL_MODE = 'D'.
GS_LAYOUT-CWIDTH_OPT = ABAP_ON.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV_FIELDCAT_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_FIELDCAT_0100 .

DATA LT_FIELDCAT TYPE KKBLO_T_FIELDCAT.

REFRESH GT_FCAT.   "FCAT 초기화해주면 좋다.

CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
  EXPORTING
    I_CALLBACK_PROGRAM     = SY-REPID                  " Internal table declaration program
*    I_TABNAME              =                  " Name of table to be displayed
    I_STRUCNAME            = 'SCARR'
    I_INCLNAME             = SY-REPID
    I_BYPASSING_BUFFER     = ABAP_ON                 " Ignore buffer while reading
    I_BUFFER_ACTIVE        = ABAP_OFF
  CHANGING
    CT_FIELDCAT            = LT_FIELDCAT                " Field Catalog with Field Descriptions
  EXCEPTIONS
    INCONSISTENT_INTERFACE = 1
    OTHERS                 = 2.

"잘 가져왔는지 확인.

IF LT_FIELDCAT IS INITIAL.
MESSAGE 'ALV 필드 카탈로그 구성이 실패했습니다.' TYPE 'E'.
ELSE.
  CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
    EXPORTING
      IT_FIELDCAT_KKBLO         = LT_FIELDCAT
    IMPORTING
      ET_FIELDCAT_LVC           = GT_FCAT
    EXCEPTIONS
      IT_DATA_MISSING           = 1
      OTHERS                    = 2    .

ENDIF.

ENDFORM.
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
    IS_LAYOUT                     = GS_LAYOUT "Layout
  CHANGING
    IT_OUTTAB                     = GT_SCARR[] "OUTPUT TABLE
    IT_FIELDCATALOG               = GT_FCAT[] "FCAT
  EXCEPTIONS
    INVALID_PARAMETER_COMBINATION = 1
    PROGRAM_ERROR                 = 2
    TOO_MANY_LINES                = 3
    OTHERS                        = 4.


ENDFORM.
