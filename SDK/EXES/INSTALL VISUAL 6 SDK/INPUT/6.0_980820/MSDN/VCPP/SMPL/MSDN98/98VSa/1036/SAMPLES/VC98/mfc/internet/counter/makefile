# This is a part of the Microsoft Foundation Classes C++ library.
# Copyright (C) 1997 Microsoft Corporation
# All rights reserved.
#
# This source code is only intended as a supplement to the
# Microsoft Foundation Classes Reference and related
# electronic documentation provided with the library.
# See these sources for detailed information regarding the
# Microsoft Foundation Classes product.

PROJ=COUNTER
OBJS=counter.obj
NO_PCH=1
AFXDLL=1

MFCDEFS=/D_AFXDLL /D_USRDLL /D_WINDLL

goal: counter.dll

DLL_LINKFLAGS=/dll
!if "$(DEBUG)" == "0"
DLL_LINKFLAGS=$(DLL_LINKFLAGS) /debug:none
!else
DLL_LINKFLAGS=$(DLL_LINKFLAGS) /debug:full /debugtype:cv
!endif

!include <mfcsamps.mak>

counter.dll counter.lib: counter.obj counter.res
	link $(DLL_LINKFLAGS) /out:counter.dll /map:counter.map \
	/implib:counter.lib /def:counter.def counter.obj \
	counter.res
