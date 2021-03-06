VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CoffeeTracker"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' CoffeeTracker est un petit objet priv�
' =============     pour garder la trace
'   d'une t�che ex�cut�e par un objet
'   Coffee. L'utilisation d'objets est
'   dict�e par le fait que les variables
'   WithEvents ne peuvent �tre mises dans des
'   tableaux. Pour en avoir un nombre
'   variable, il convient d'avoir une
'   classe d'objets pour conserver les
'   variables WithEvents.
'
' D�finit les propri�t�s ThreadID et Size avant le
'   d�but de l'ex�cution de la t�che longue; d�finit
'   la propri�t� Coffee JUSTE avant que vous
'   n'appeliez StartLongTask. L'ID est affect�
'   par la proc�dure NewTracker dans la
'   feuille frmThread; il s'agit de l'index
'   de l'objet dans l'objet Collection
'   CoffeeTrackers.

Public ThreadID As Long
Public Size As Long
Public ID As String

' Stockage pour l'objet Coffee dont il faut garder une trace.
Private WithEvents mwCoffee As Coffee
Attribute mwCoffee.VB_VarHelpID = -1
'
' Heure de d�but (depuis l'API timeGetTimer).
Private mlngStart As Long

Public Property Get Coffee() As Coffee
    Set Coffee = mwCoffee
End Property
Public Property Set Coffee(ByVal NewValue As Coffee)
    ' Enregistre l'heure de d�but.
    mlngStart = timeGetTime
    Set mwCoffee = NewValue
End Property

' L'objet Coffee d�clenche un �v�nement
'   Complete lorsque la t�che dont il faut
'   garder une trace est termin�e. L'objet
'   CoffeeTracker met les informations
'   sur la t�che (ID de la thread, taille
'   et nombre de secondes par it�ration)
'   dans une zone de liste de la feuille
'   frmThread.
'
Private Sub mwCoffee_Complete(ByVal Canceled As Boolean)
    Dim lngEnd As Long
    Dim dblElapsed As Double
    
    lngEnd = timeGetTime
    '
    ' Lib�re l'objet Coffee.
    Set mwCoffee = Nothing
    '
    ' Ajoute une ligne d'�tat � la zone de liste.
    If Canceled Then
        frmThread.lstResults.AddItem ThreadID _
            & " (" & Size & ") annul�", 0
    Else
        frmThread.lstResults.AddItem ThreadID _
            & " (" & Size & ") " _
            & (CDbl(lngEnd) - mlngStart) / Size / 1000# _
            & " sec/it�ration", 0
    End If
    '
    ' L'objet CoffeeTracker supprime sa r�f�rence
    '   de la collection, ce qui le laisse
    '   sans r�f�rences. Il peut donc se
    '   terminer.
    frmThread.CoffeeTrackers.Remove ID
End Sub

' Pour les t�ches longues, les �v�nements
'   Coffee d�clenchent un �v�nement Progress
'   � chaque 10% effectu� par la t�che. L'objet
'   CoffeeTracker ajoute une entr�e � la
'   zone de liste de la feuille frmThread.
'
Private Sub mwCoffee_Progress(ByVal PercentDone As Single, Cancel As Boolean)
    frmThread.lstResults.AddItem ThreadID _
        & " (" & Size & ") " _
        & Format$(PercentDone * 100, "#0.0") & "%", 0
    '
    ' D�s qu'un objet CoffeeTracker d�tecte
    '   l'indicateur global Cancel, il arr�te
    '   la t�che longue qu'il attendait.
    '   L'objet Coffee d�clenchera ensuite
    '   un �v�nement Complete (voir ci-dessus).
    If frmThread.CancelAll Then Cancel = True
End Sub

