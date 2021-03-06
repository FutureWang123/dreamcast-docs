VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "XTimer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'===============================================
' AVERTISSEMENT! Vous ne DEVEZ PAS cliquer sur
'   le bouton Fin pendant le d�bogage de ce
'   projet! Reportez-vous aux explications
'   figurant au d�but du module XTimerSupport
'   (XTimerS.bas).
'===============================================

' Stockage priv� pour les propri�t�s de l'objet XTimer:
Private mlngTimerID As Long
Private mlngInterval As Long
Private mblnEnabled As Boolean

' Le seul �v�nement de l'objet XTimer est Tick.
' Celui-ci n'a pas d'arguments (ce qui am�liore sensiblement
' la vitesse d'ex�cution de l'�v�nement) mais rien ne vous 
' emp�che d'en fournir si vous le d�sirez.
Event Tick()

' La propri�t� TimerID est requise par la proc�dure EndTimer,
' ----------------   afin de localiser rapidement la minuterie
'   dans le tableau du module XTimerSupport des minuteries actives.
'
' Il n'y a pas de raison que le client utilise cette propri�t�;
'   elle est donc d�clar�e en tant que Friend au lieu de Public.
'
Friend Property Get TimerID() As Long
    TimerID = mlngTimerID
End Property

' La propri�t� Enabled allume et �teint la minuterie.
' ----------------      Cela est r�alis� en arr�tant la
'   minuterie du syst�me car il n'existe pas de solution
'   pour la suspendre, son r�le �tant de fonctionner.
'
Public Property Get Enabled() As Boolean
    Enabled = mblnEnabled
End Property
'
Public Property Let Enabled(ByVal NewValue As Boolean)
    ' Si aucune modification n'intervient dans l'�tat
    '   de la propri�t�, alors quitte. Cela
    '   emp�che de d�marrer une autre minuterie
    '   lorsqu'il y en a une qui fonctionne d�j�.
    If NewValue = mblnEnabled Then Exit Property
    '
    ' Enregistre la nouvelle valeur de la propri�t�.
    mblnEnabled = NewValue
    '
    ' Si l'intervalle est �gale � z�ro, la minuterie
    '   est d�j� arr�t�e. Ne pas la d�marrer.
    If mlngInterval = 0 Then Exit Property
    '
    ' Allume ou �teint la minuterie.
    If mblnEnabled Then
        Debug.Assert mlngTimerID = 0
        mlngTimerID = BeginTimer(Me, mlngInterval)
    Else
        ' Ce qui suit est n�cessaire car l'objet
        '   XTimer peut �teindre sa minuterie
        '   du syst�me de deux fa�ons: Enabled = False,
        '   ou Interval = 0.
        If mlngTimerID <> 0 Then
            Call EndTimer(Me)
            mlngTimerID = 0
        End If
    End If
End Property

' La propri�t� Interval peut faire plus que de d�finir
' -----------------   uniquement l'intervalle de la minuterie.
'   Si l'objet XTimer est activ�e, et que la propri�t�
'   Interval passe de z�ro � une valeur diff�rente de z�ro,
'   une minuterie du syst�me pourra d�marrer. De m�me, si la
'   propri�t� Interval prend la valeur 0, la minuterie doit �tre
'   arr�t�e.
'
' La proc�dure de la propri�t� Let met fin �galement � une
'   minuterie du syst�me et en d�marre une autre lorsque
'   l'intervalle change. cela s'explique par l'impossibilit�
'   de modifier l'intervalle d'une minuterie.
'
Public Property Get Interval() As Long
    Interval = mlngInterval
End Property
'
Public Property Let Interval(ByVal NewInterval As Long)
    ' Si la nouvelle valeur de la propri�t� Interval est �gale
    '   � l'ancienne, il n'existe aucune raison de faire
    '   quelque chose.
    If NewInterval = mlngInterval Then Exit Property
    '
    ' Enregistre la nouvelle valeur.
    mlngInterval = NewInterval
    '
    ' Si l'objet XTimer est active, mlngTimerID
    '   est diff�rent de z�ro. Dans ce cas, l'ancienne
    '   minuterie du syst�me doit �tre arr�t�e avant
    '   le d�marrage de la nouvelle.
    If mlngTimerID <> 0 Then
        Call EndTimer(Me)
        mlngTimerID = 0
    End If
    '
    ' Si le nouvel intervalle est �gale � z�ro, l'objet
    '   XTimer est d�sactiv�e, quelle que soit la
    '   valeur de la propri�t� Enabled. Si le nouvel
    '   intervalle est diff�rent de z�ro ET que la
    '   valeur de la propri�t� Enabled est True, une
    '   nouvelle minuterie d�marre et son ID est stock�
    '   dans mlngTimerID.
    If (NewInterval <> 0) And mblnEnabled Then
        mlngTimerID = BeginTimer(Me, NewInterval)
    End If
End Property

' La m�thode RaiseTick est appel�e par le module XTimerSupport
' ----------------   lorsque l'�v�nement de la minuterie se
'   produit pour la minuterie du syst�me de cet objet XTimer.
'
' Explication de l'impl�mentation:   il est pr�f�rable de d�clarer
'   cette m�thode en tant que Friend au lieu de Public, dans la
'   mesure o� le client n'a pas besoin d'appeler cette m�thode
'   RaiseTick. Il peut �tre dangereux de d�clarer la m�thode en
'   tant que Public car l'objet peut �tre lib�r� alors que
'   l'�v�nement Tick est toujours maintenu. Un objet ne se
'   terminera PAS tant que l'une de ses m�thodes de type Public
'   est sur la pile. En revanche, il PEUT se terminer si une
'   m�thode de type Friend est sur la pile. Si l'objet se
'   termine avant le renvoi de la m�thode Friend (ce qui peut
'   se produire si le client ex�cute beaucoup de code dans
'   l'�v�nement Tick de l'objet XTimer), une erreur de 
'   protection g�n�rale se produira.
'   Note: ce sc�nario est tr�s improbable et d�pend d'�v�nements
'   ext�rieurs; il ne se produit pas lors de l'utilisation
'   courante des fonctions Friend.
'
Public Sub RaiseTick()
    RaiseEvent Tick
End Sub

Private Sub Class_Terminate()
    ' Lorsque le client lib�re sa derni�re r�f�rence �
    '   un objet XTimer, il s'arr�te -- mais uniquement
    '   si la propri�t� Enabled de l'objet XTimer a
    '   pour valeur False, ou que sa propri�t�
    '   Interval a pour valeur True!
    '
    ' Pendant le fonctionnement de la minuterie de
    '   l'objet XTimer, le module XTimerSupport doit,
    '   en effet, avoir une r�f�rence � l'objet XTimer
    '   pour pouvoir d�clencher son �v�nement Tick.
    '   L'�chec du client pour d�sactiver les objets
    '   XTimer avant de les lib�rer entra�ne la perte
    '   des minuteries du syst�me!
    '
    ' Cette perte des minuteries du syst�me ne sera
    '   pas r�cup�rable tant que le composant XTimers
    '   ne s'arr�te pas, en d'autres termes, tant que le
    '   client qui utilise la DLL ne s'arr�te pas.
    '   La DLL ne sera PAS d�charg�e lorsque tous les
    '   objets XTimer sont lib�r�s, car les r�f�rences
    '   aux objets de type Public (dans ce cas, les
    '   r�f�rences maintenues par le module XTimerSupport)
    '   emp�chent le d�chargement des DLL.
    '
    ' Pourquoi donc se soucier de nettoyer la minuterie
    '   du syst�me dans l'�v�nement Terminate? Parce que
    '   toutes les r�f�rences � l'objet XTimer seront
    '   nettoy�es lors du d�chargement de la DLL, et que
    '   l'objet XTimer obtiendra son �v�nement Terminate.
    '   La minuterie du syst�me serait d�truite �
    '   ce moment-l�.
    On Error Resume Next
    If mlngTimerID <> 0 Then KillTimer 0, mlngTimerID
    '
    ' Ce qui suit montre ce que ferait l'objet XTimer
    '   dans l'hypoth�se o� il serait lib�r� avant
    '   le d�chargement de la DLL.
    'If mlngTimerID <> 0 Then Call EndTimer(Me)
End Sub

