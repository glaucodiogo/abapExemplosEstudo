*&---------------------------------------------------------------------*
*& Report  Z998904_GDA_EXER1
*&
*&---------------------------------------------------------------------*

REPORT  z998904_gda_exer3.

*--------------------------------------------------------------------*
* Variáveis
*--------------------------------------------------------------------*
DATA: vg_nome TYPE ztgda_func-nome.
*--------------------------------------------------------------------*
* Tipos
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* Tabelas internas
*--------------------------------------------------------------------*
DATA it_func TYPE STANDARD TABLE OF ztgda_func.


*--------------------------------------------------------------------*
* Estruturas
*--------------------------------------------------------------------*
DATA st_func TYPE  ztgda_func.

*--------------------------------------------------------------------*
* Parâmetros de entrada
*--------------------------------------------------------------------*
PARAMETERS p_codfun TYPE ztgda_func-codfun OBLIGATORY.
PARAMETERS p_coddep TYPE ztgda_dep-coddep OBLIGATORY.

*--------------------------------------------------------------------*
* Processamento
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM preencher_tabela.
*  FORM exibir_alv.


*&---------------------------------------------------------------------*
*&      Form  PREENCHER_TABELA
*&---------------------------------------------------------------------*
FORM preencher_tabela .
  "Select single , usado somente quando se espera receber uma linha
  SELECT SINGLE * INTO st_func  FROM ztgda_func
     WHERE codfun = p_codfun.

  IF sy-subrc <> 0.
    CLEAR st_func.
  ELSE.
    WRITE: / st_func-nome ,st_func-cargo.

  ENDIF.
ENDFORM.                    " PREENCHER_TABELA
*&---------------------------------------------------------------------*
*&      Form  EXIBIR_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM exibir_alv .
  DATA: lo_alv TYPE REF TO cl_salv_table, "Classe mais atual no momento para se criar ALV
        lo_functions TYPE REF TO cl_salv_functions_list.

  TRY.
*
*    CALL METHOD cl_salv_table=>factory(
*      IMPORTING
*        r_salv_table   = lo_alv
*      CHANGING
*        t_table        = it_estado ).

      lo_functions = lo_alv->get_functions( ).
      lo_functions->set_all( abap_true ).

      lo_alv->display( ).
    CATCH cx_salv_msg.
  ENDTRY.

ENDFORM.                    " EXIBIR_ALV
