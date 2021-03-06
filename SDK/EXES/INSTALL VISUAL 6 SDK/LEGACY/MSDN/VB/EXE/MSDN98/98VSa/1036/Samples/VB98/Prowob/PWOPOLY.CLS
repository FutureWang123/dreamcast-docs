VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Polygon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
' >> L'affichage complet du module donne de meilleurs r�sultats. <<
'
' Stockage pour le num�ro ID de d�bogage.
Private mlngDebugID As Long
Implements IDebug

' La classe Polygon est une classe TR�S
' -------       rudimentaire des objets Polygon.
'   Elle permet aux polygones d'�tre cr��s (avec
'   la m�thode SetPoints); il n'existe aucun
'   moyen de modifier les points une fois d�finis
'   (sauf en rappelant la m�thode SetPoints et en
'   red�finissant tout le polygone).

Private Type POLYPOINT  ' pr�fixe pyp
    X As Single
    Y As Single
    Angle As Single
End Type

' Polygone par d�faut � un point, aux coordonn�es (0,0).
Private mapyp() As POLYPOINT

' Stockage pour la propri�t� Normalized en lecture seule.
Private mblnNormalized As Boolean

' Stockage pour la propri�t� Color.
Private mrgbColor As Long

' IShape est l'interface utilis�e pour
' ------    l'affichage du polygone. Elle
'   dispose �galement d'une m�thode TimeTest
'   utilis�e pour comparer les d�pr�ciations
'   de performance des appels aux liaisons
'   tardives et pr�coces.
Implements IShape

' -------------------------------------
' L'impl�mentation de l'interface IShape
'   d�marre ici.

' La proc�dure IShape.DrawToPictureBox est
' ====== ----------------   appel�e pour
'   dessiner une forme; chaque classe de
'   forme doit fournir sa propre impl�mentation.
'
Private Sub IShape_DrawToPictureBox(ByVal pb As PictureBox)
    Dim sngXLast As Single
    Dim sngYLast As Single
    Dim sngX As Single
    Dim sngY As Single
    Dim intMax As Integer
    Dim intCt As Integer
    
    intMax = UBound(mapyp)
    sngX = mapyp(intMax).X
    sngY = mapyp(intMax).Y
    If intMax = 0 Then
        pb.PSet (sngX, sngY), mrgbColor
    Else
        For intCt = 0 To intMax
            sngXLast = sngX
            sngYLast = sngY
            sngX = mapyp(intCt).X
            sngY = mapyp(intCt).Y
            pb.Line (sngXLast, sngYLast)-(sngX, sngY), mrgbColor
        Next
    End If
End Sub

' La m�thode IShape.TimeTest est utilis�e
' ====== --------       pour afficher la
'   d�pr�ciation r�duite de performances
'   de l'appel d'une m�thode appel�e sur
'   une interface qui impl�mente plusieurs
'   classes, en opposition � l'appel
'   d'une m�thode semblable sur les interfaces
'   par d�faut des classes.
'
Private Sub IShape_TimeTest()
End Sub

' --------------------------------------
' L'interface par d�faut de la classe
'   Polygon (Propri�t�s et m�thodes publiques)
'   d�marre ici. Il s'agit de
'   l'interface Polygon que les objets
'   Triangle et Rectangle impl�mentent.

' Propri�t� Color.
' -----
'
Public Property Get Color() As Long
    Color = mrgbColor
End Property
'
Public Property Let Color(ByVal rgb As Long)
    If 0 <> (rgb And &HFF000000) Then
        Err.Raise vbObjectError + 2080, , _
            "Valeur de couleur non valide pour l'objet Polygon"
        Exit Property
    End If
    mrgbColor = rgb
End Property

' La m�thode TimeTest ne prend pas d'arguments,
' --------      ne fait rien et effectue
'   imm�diatement un renvoi. Elle est utilis�e
'   pour montrer la d�pr�ciation de performance
'   pour une liaison tardive, en opposition �
'   la liaison pr�coce fournie en appelant la
'   m�thode TimeTest sur l'interface IShape.
'
' Vous pensez peut-�tre que nous aurions
'   d� faire de TimeTest une propri�t�
'   Friend, comme DebugID, pour enregistrer
'   les objets Triangle et Rectangle (qui
'   impl�mentent l'interface Polygon) depuis
'   l'impl�mentation de Polygon_TimeTest.
'   Les propri�t�s et les m�thodes Friend
'   ne font PAS partie d'une interface de
'   classe. La raison pour laquelle nous
'   n'avons pas pu le faire est que TimeTest
'   doit �tre appel�e, dans cet exemple, avec
'   une liaison TARDIVE, alors que les propri�t�
'   et les m�thodes Friend doivent toujours
'   �tre appel�es avec une liaison PR�COCE.
Public Sub TimeTest()
End Sub

' La m�thode GetPoint affecte deux variables
' --------      ByRef de type Single aux
'   valeurs X et Y pour le point requis. Si
'   l'interface de l'objet Polygon n'a pas
'   �t� impl�ment�e par les objets Triangle
'   et Rectangle, GetPoint peut �tre d�clar�
'   comme Friend, et renvoyer une structure
'   POLYPOINT. Dans ce cas, elle serait
'   d�clar�e comme Public dans un module
'   standard; cependant, les membres Friend
'   ne font pas partie d'une interface de
'   la classe. D�clarer la m�thode GetPoint
'   comme Friend emp�cherait donc les objets
'   Triangle et Rectangle d'impl�menter
'   l'instruction Polygon_GetPoint comme
'   liaison pr�coce.
'
Public Sub GetPoint(ByVal intPoint As Integer, _
        ByRef X As Single, ByRef Y As Single)
    X = mapyp(intPoint).X
    Y = mapyp(intPoint).Y
End Sub

' La propri�t� GetPointCount renvoie le nombre
' -------------     de points dans l'objet Polygon.
'
Public Property Get GetPointCount() As Integer
    GetPointCount = UBound(mapyp) + 1
End Property

' La m�thode SetPoints accepte un tableau de
' ---------     donn�es de type Single,
'   commen�ant � z�ro. Les �l�ments
'   pairs (0, 2, etc.) correspondent aux
'   valeurs de X et les �l�ments impairs
'   aux valeurs de Y des points.
'
Public Sub SetPoints(asngPoints() As Single)
    Dim blnBadArray As Boolean
    Dim intMax As Integer
    Dim intPoint As Integer
    
    On Error Resume Next
    If LBound(asngPoints) <> 0 Then blnBadArray = True
    intMax = UBound(asngPoints)
    ' La limite sup�rieure d'un tableau commen�ant
    '   � z�ro doit �tre un nombre impair; la valide.
    ' 
    If (intMax / 2#) = (intMax \ 2) Then blnBadArray = True
    ' Si une erreur se produit dans la fonction
    '   UBound, d�clare le tableau comme invalide.
    If Err.Number <> 0 Then blnBadArray = True
    If blnBadArray Then
        Err.Raise vbObjectError + 2081, , _
            "La m�thode SetPoints doit recevoir un tableau � une dimension commen�ant � z�ro, avec un nombre impair d'�l�ments, les entr�es paires correspondant aux valeurs de X et les entr�es impaires aux valeurs de Y."
        Exit Sub
    End If
    ' Convertit l'index maximum du tableau des
    '   entr�es en index maximum du tableau interne
    '   de l'objet Polygon.
    intMax = intMax \ 2
    ReDim mapyp(0 To intMax)
    ' Lit les valeurs du point.
    For intPoint = 0 To intMax
        mapyp(intPoint).X = asngPoints(intPoint * 2)
        mapyp(intPoint).Y = asngPoints(intPoint * 2 + 1)
    Next
End Sub

' --------------------------------------
' Les proc�dures priv�es de l'objet
'   Polygon (proc�dures d'aide et d'�v�nement)
'   d�marrent ici.

Private Sub Class_Initialize()
    ' Code de d�bogage.
    mlngDebugID = DebugInit(Me)
    '
    ' Objet Polygon par d�faut affect� � un point.
    ReDim mapyp(0 To 0)
End Sub

Private Sub Class_Terminate()
    DebugTerm Me
End Sub

' -------- Impl�mentation de IDebug --------
'
' IDebug.DebugID permet de distinguer
' ====== -------    les diff�rents objets. Il
'   est requis par les proc�dures de d�bogage
'   DebugInit, DebugTerm et DebugShow
'   d�clar�es dans le module modFriend.

Private Property Get IDebug_DebugID() As Long
    IDebug_DebugID = mlngDebugID
End Property

