*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA0703........................................*
TABLES: ZVSA0703, *ZVSA0703. "view work areas
CONTROLS: TCTRL_ZVSA0703
TYPE TABLEVIEW USING SCREEN '0010'.
DATA: BEGIN OF STATUS_ZVSA0703. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA0703.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA0703_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA0703.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0703_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA0703_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA0703.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0703_TOTAL.

*...processing: ZVSA0704........................................*
TABLES: ZVSA0704, *ZVSA0704. "view work areas
CONTROLS: TCTRL_ZVSA0704
TYPE TABLEVIEW USING SCREEN '0020'.
DATA: BEGIN OF STATUS_ZVSA0704. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA0704.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA0704_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA0704.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0704_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA0704_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA0704.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0704_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA0007                       .
TABLES: ZTSA07200701                   .
TABLES: ZTSA07200701_T                 .
