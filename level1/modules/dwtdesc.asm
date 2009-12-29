********************************************************************
* DWTDesc - Drivewire Virtual Serial Device Descriptor
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   0.3    2009/12/??  Aaron Wolfe
* ADded SHARE. bit to mode.
*
*   0.4    2009/12/27  Boisy G. Pitre
* Removed SHARE. bit from mode because of tsmon issues.
*
* This descriptor has slightly different defaults, intended to be used as 
* the channel for the DriveWire utilities
*

         nam   DWTDesc
         ttl   DriveWire Virtual Serial Device Descriptor

         ifp1  
         use   defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $04

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         IFNE  UTIL
         fcb   UPDAT.+SHARE.   	mode byte (share set to prevent multiple access on /T0)
         ELSE
         fcb   UPDAT.    	mode byte
         ENDC
         fcb   HW.Page    extended controller address
         fdb   $FF00+TNum      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.SCF     device type:0=scf,1=rbf,2=pipe,3=scf
         IFNE  UTIL
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00,$00,$00,$00,$00,$00
         fcb   $00,$00,$00
         ELSE
         fcb   $00        case:0=up&lower,1=upper only
         fcb   $01        backspace:0=bsp,1=bsp then sp & bsp
         fcb   $00        delete:0=bsp over line,1=return
         fcb   $01        echo:0=no echo
         fcb   $01        auto line feed:0=off
         fcb   $00        end of line null count
         fcb   $00        pause:0=no end of page pause
         fcb   24         lines per page
         fcb   C$BSP      backspace character
         fcb   C$DEL      delete line character
         fcb   C$CR       end of record character
         fcb   C$EOF      end of file character
         fcb   C$RPRT     reprint line character
         fcb   C$RPET     duplicate last line character
         fcb   C$PAUS     pause character
         fcb   C$INTR     interrupt character
         fcb   C$QUIT     quit character
         fcb   C$BSP      backspace echo character
         fcb   C$BELL     line overflow character (bell)
         ENDC
         IFNE  UTIL
         fcb   $03        mode byte for utility descriptor
		 ELSE
         fcb   $00        mode byte for terminal descriptor
		 ENDC
         fcb   B600       baud rate
         fdb   name       copy of descriptor name address
         fcb   $00        acia xon char
         fcb   $00        acia xoff char
         fcb   80         (szx) number of columns for display
         fcb   24         (szy) number of rows for display
initsize equ   *

         IFNE  TERM
name     fcs   /Term/
         ELSE
		 IFNE  UTIL
name     fcc   /U/
         fcb   176+TNum-8
		 ELSE
name     fcc   /T/
         fcb   176+TNum
         ENDC
         ENDC
mgrnam   fcs   /SCF/
drvnam   fcs   /scdwt/

         emod  
eom      equ   *
         end   
