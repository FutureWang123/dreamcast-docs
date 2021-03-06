/*
    stddde.h

    This header file defines all the constants, structures
    and APIs used to interface with stddde.c.

    You should include this header file in your own application
    after windows.h

*/

#ifndef _STDDDE_
#define _STDDDE_

#include <ddeml.h>

//
// String names for standard Windows Clipboard formats
//

#define SZCF_TEXT           "TEXT"        
#define SZCF_BITMAP         "BITMAP"      
#define SZCF_METAFILEPICT   "METAFILEPICT"
#define SZCF_SYLK           "SYLK"        
#define SZCF_DIF            "DIF"         
#define SZCF_TIFF           "TIFF"        
#define SZCF_OEMTEXT        "OEMTEXT"     
#define SZCF_DIB            "DIB"         
#define SZCF_PALETTE        "PALETTE"     
#define SZCF_PENDATA        "PENDATA"     
#define SZCF_RIFF           "RIFF"     
#define SZCF_WAVE           "WAVE"     
#define SZCF_UNICODETEXT    "UNICODETEXT" 
#define SZCF_ENHMETAFILE    "ENHMETAFILE" 

//
// String names for some standard DDE strings not
// defined in DDEML.H
//

#define SZ_READY            "Ready"
#define SZ_BUSY             "Busy"
#define SZ_TAB              "\t"

//
// Definition for a DDE Request processing function
//

typedef HDDEDATA (DDEREQUESTFN)(UINT wFmt, HSZ hszTopic, HSZ hszItem);
typedef DDEREQUESTFN *PDDEREQUESTFN;

//
// Definition for a DDE Poke processing function
//

typedef BOOL (DDEPOKEFN)(UINT wFmt, HSZ hszTopic, HSZ hszItem, HDDEDATA hData);
typedef DDEPOKEFN *PDDEPOKEFN;

//
// Definition for a DDE Execute processing function
//

typedef BOOL (DDEEXECFN)(UINT wFmt, HSZ hszTopic, HDDEDATA hData);
typedef DDEEXECFN *PDDEEXECFN;

//
// Structure used to hold a clipboard id and its text name
//

typedef struct _CFTAGNAME {
    WORD wFmt;
    LPSTR pszName;
} CFTAGNAME, FAR *PCFTAGNAME;


//
// Structure used to store information on a DDE item
//

typedef struct _DDEITEMINFO {
    struct _DDEITEMINFO FAR *pNext; // pointer to the next item
    LPSTR   pszItemName;        // pointer to its string name
    HSZ     hszItemName;        // DDE string handle for the name
    struct _DDETOPICINFO FAR *pTopic; // pointer to the topic it belongs to
    LPWORD  pFormatList;        // ptr to null term list of CF format words.
    PDDEREQUESTFN pfnRequest;   // pointer to the item specific request processor
    PDDEPOKEFN    pfnPoke;      // pointer to the item specific poke processor
} DDEITEMINFO, FAR *PDDEITEMINFO;

//
// Structure used to store information on a DDE topic
//

typedef struct _DDETOPICINFO {
    struct _DDETOPICINFO FAR *pNext;// pointer to the next topic
    LPSTR   pszTopicName;      // pointer to its string name
    HSZ     hszTopicName;       // DDE string handle for the name
    PDDEITEMINFO pItemList;     // pointer to its item list
    PDDEEXECFN  pfnExec;        // pointer to its DDE Execute processor
    PDDEREQUESTFN pfnRequest;   // pointer to the generic request processor
    PDDEPOKEFN    pfnPoke;      // pointer to the generic poke processor
} DDETOPICINFO, FAR *PDDETOPICINFO;

//
// Structure used to store information about a DDE conversation
//

typedef struct _DDECONVINFO {
    struct _DDECONVINFO FAR *pNext; // pointer to the next one
    HCONV hConv;                    // handle to the conversation
    HSZ hszTopicName;               // HSZ for the topic of the conversation
} DDECONVINFO, FAR *PDDECONVINFO;

//
// Structure used to store information on a DDE server
// which has only one service
//

typedef struct _DDESERVERINFO {
    LPSTR   lpszServiceName;        // pointer to the service string name
    HSZ     hszServiceName;         // DDE string handle for the name
    PDDETOPICINFO pTopicList;       // pointer to the topic list
    DWORD dwDDEInstance;            // DDE Instance value
    PFNCALLBACK pfnStdCallback;     // pointer to standard DDE callback fn
    PFNCALLBACK pfnCustomCallback;  // pointer to custom DDE callback fn
    PDDECONVINFO pConvList;         // pointer to the active conversation list
} DDESERVERINFO, FAR *PDDESERVERINFO;

//
// Functions provided by stddde.c
//

extern BOOL InitializeDDE(HANDLE hInstance,
                          LPSTR lpszServiceName,
                          LPDWORD lpdwDDEInst,
                          PFNCALLBACK lpfnCustomCallback,
                          DWORD dwFilterFlags);

extern void UninitializeDDE(void);

extern PDDETOPICINFO AddDDETopic(LPSTR lpszTopic,
                                 PDDEEXECFN pfnExec,     
                                 PDDEREQUESTFN pfnRequest,
                                 PDDEPOKEFN pfnPoke);
extern BOOL RemoveDDETopic(LPSTR lpszTopic);

extern PDDEITEMINFO AddDDEItem(LPSTR lpszTopic, 
                               LPSTR lpszItem, 
                               LPWORD pFormatList,
                               PDDEREQUESTFN lpReqFn, 
                               PDDEPOKEFN lpPokeFn);
extern BOOL RemoveDDEItem(LPSTR lpszTopic, LPSTR lpszItem);

extern void PostDDEAdvise(PDDEITEMINFO pItemInfo);
extern PDDETOPICINFO FindTopicFromName(LPSTR lpszName);
extern PDDEITEMINFO FindItemFromName(PDDETOPICINFO pTopic, LPSTR lpszItem);
extern PDDETOPICINFO FindTopicFromHsz(HSZ hszName);
extern PDDEITEMINFO FindItemFromHsz(PDDETOPICINFO pTopic, HSZ hszItem);
extern LPSTR GetCFNameFromId(WORD wFmt, LPSTR lpBuf, int iSize);


#endif // _STDDDE_
