   �   !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Courier New                    6     winspool \\foxdoc\apple Ne00:                          \\foxdoc\apple                  � p s           X  X   Letter                                                                                  ����4      ��������     ��       ��    ��  ������������������������������         '''  '                                   �DRIVER=winspool
DEVICE=\\foxdoc\apple
OUTPUT=Ne00:
ORIENTATION=0
PAPERSIZE=1
COPIES=1
DEFAULTSOURCE=1
DUPLEX=1
YRESOLUTION=600
TTOPTION=3
               employee.emp_id                AALLTRIM(employee.first_name) + " " +  ALLTRIM(employee.last_name)                                                               Arial                          orders.order_amt                                              Courier New                    
"99999,99"                     orders.order_amt                                              Courier New                    "9999999,99"                   Arial                          "Total g�n�ral des ventes"                                      3STR(INT((emp_total / nTotalSales)*100)) + " " + "%"                                            Courier New                    "@I"                           Arial                          "Total des ventes par employ�"                                  Arial                          	"Employ�"                      Arial                          "Total des ventes"             Arial                          "% du total des ventes"        5STR(INT((nTotalSales / nTotalSales)*100)) + " " + "%"                                          Courier New                    employee.emp_id                                               Arial                          Times New Roman                0"Exemple d'�tat Visual FoxPro 6.0 - Percent.frx"                "Page " + ALLTRIM(STR(_pageno))                                                                Times New Roman                Times New Roman                "Description"                  Times New Roman                �"Vous pouvez attacher du code � l'environnement de donn�es pour calculer une valeur � utiliser dans l'�tat. Dans ce cas, le total"                                 Times New Roman                �"des ventes de tous les employ�s est calcul� avant l'ex�cution de l'�tat. Cette valeur est alors utilis�e pour imprimer le pourcentage "                           Times New Roman                m"du total des ventes par employ�s (qui est bas� sur les ventes des employ�s divis� par le total des ventes)."                     	emp_total                      orders.order_amt               0                              Courier New                    Arial                          Arial                          Times New Roman                Times New Roman                Times New Roman                dataenvironment                KLeft = 83
Top = 359
Width = 512
Height = 158
Name = "Dataenvironment"
                      ~PROCEDURE Init
set currency to " F"
set currency RIGHT

Set separator to '.'
set point to ','
set date to DMY
ENDPROC
                                     ����    �   �                         ��   %   o       �      }           �  U  :  G8(��  F�� G8Y� G<(�� .�� G;(�� ,�� G(� DMY� U  DMY Init,     ��1 � a � � � 1                       s       )   �                                            cursor                        .Left = 20
Top = 10
Width = 118
Height = 90
Alias = "employee"
Order = "emp_id"
Database = ..\..\..\data\target\testdata.dbc
CursorSource = "employee"
Name = "Cursor1"
                                                                                                                                                        cursor                         �Left = 160
Top = 10
Width = 118
Height = 90
Alias = "orders"
Database = ..\..\..\data\target\testdata.dbc
CursorSource = "orders"
Name = "Cursor2"
       �PROCEDURE Destroy

* Remove the PUBLIC variable from memory
RELEASE nTotalSales
ENDPROC
PROCEDURE Init
PUBLIC nTotalSales

* Make sure TALK is off, so CALC results to not
* display on screen
cOldTalk = SYS(103)

SET TALK OFF

* CALC sales total for all employees
CALCULATE SUM(orders.order_amt) TO nTotalSales

* Return TALK setting to previous setting
SET TALK &cOldTalk

ENDPROC
                        `���    G  G                        ґ   %   �       �   	   �           �  U  
  <�  � U  NTOTALSALESH  7�  � T� �C�g]�� G2� }(�  ��� � �� SET TALK &cOldTalk
 U  NTOTALSALES COLDTALK ORDERS	 ORDER_AMT Destroy,     �� InitG     ��1 s 2 q � b 3c2                       R         m   �      )   G                  1 �      relation                      	ParentAlias = "employee"
RelationalExpr = "emp_id"
ChildAlias = "orders"
ChildOrder = "emp_id"
Name = "Relation1"
                                                                                                                                                                                                                                                                                                                                                                                                                                                  