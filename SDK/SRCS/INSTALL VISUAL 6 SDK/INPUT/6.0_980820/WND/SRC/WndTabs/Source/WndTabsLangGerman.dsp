# Microsoft Developer Studio Project File - Name="WndTabsLangGerman" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=WndTabsLangGerman - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "WndTabsLangGerman.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "WndTabsLangGerman.mak" CFG="WndTabsLangGerman - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "WndTabsLangGerman - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "WndTabsLangGerman - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "WndTabsLangGerman"
# PROP Scc_LocalPath ".\res"
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "WndTabsLangGerman - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WNDTABSLANGGERMAN_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WNDTABSLANGGERMAN_EXPORTS" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /i "..\..\BCG\BCGControlBar" /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 /nologo /base:"0x44A00000" /dll /pdb:none /machine:I386 /nodefaultlib /noentry

!ELSEIF  "$(CFG)" == "WndTabsLangGerman - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WNDTABSLANGGERMAN_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WNDTABSLANGGERMAN_EXPORTS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1009 /d "_DEBUG"
# ADD RSC /l 0x1009 /i "..\..\BCG\BCGControlBar" /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /base:"0x44A00000" /dll /pdb:none /machine:I386 /nodefaultlib /noentry

!ENDIF 

# Begin Target

# Name "WndTabsLangGerman - Win32 Release"
# Name "WndTabsLangGerman - Win32 Debug"
# Begin Source File

SOURCE=.\res\about.ico
# End Source File
# Begin Source File

SOURCE=.\res\banner.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bulb2.bmp
# End Source File
# Begin Source File

SOURCE=.\res\icons.bmp
# End Source File
# Begin Source File

SOURCE=.\res\lang_dl.ico
# End Source File
# Begin Source File

SOURCE=.\res\lang_sel.ico
# End Source File
# Begin Source File

SOURCE=.\res\lg_mail.ico
# End Source File
# Begin Source File

SOURCE=.\res\lg_net.ico
# End Source File
# Begin Source File

SOURCE=.\res\mainfram.bmp
# End Source File
# Begin Source File

SOURCE=.\res\numbers.bmp
# End Source File
# Begin Source File

SOURCE=.\Readme.de.txt
# End Source File
# Begin Source File

SOURCE=.\res\reg_opt.ico
# End Source File
# Begin Source File

SOURCE=.\res\reg_opt2.ico
# End Source File
# Begin Source File

SOURCE=.\res\TBarLrge.bmp
# End Source File
# Begin Source File

SOURCE=.\res\TBarMedm.bmp
# End Source File
# Begin Source File

SOURCE=.\res\UserBtns.bmp
# End Source File
# Begin Source File

SOURCE=.\WndTabs.de.rc
# End Source File
# Begin Source File

SOURCE=.\res\WndTabs.ico
# End Source File
# Begin Source File

SOURCE=.\res\WndTabsExt.bmp
# End Source File
# End Target
# End Project
