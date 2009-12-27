********************************************************************
* T1 - Drivewire Virtual Serial Port on T1
*
* mostly copied or slightly changed from other DriveWire code
*
*
* Aaron Wolfe
* version 0.3 - 12/17/09  - added SHARE bit to mode
*

         nam   T1
         ttl   CoCo DriveWire Virtual Serial Device Descriptor

         ifp1  
         use   defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   UPDAT.+SHARE.      mode byte
         fcb   HW.Page    extended controller address
         fdb   $FF01      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.SCF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00        case:0=up&lower,1=upper only
         fcb   $01        backspace:0=bsp,1=bsp then sp & bsp
         fcb   $01        delete:0=bsp over line,1=return
         fcb   $01        echo:0=no echo
         fcb   $01        auto line feed:0=off
         fcb   $00        end of line null count
         fcb   $00        pause:0=no end of page pause
         fcb   66         lines per page
         fcb   C$BSP      backspace character
         fcb   C$DEL      delete line character
         fcb   C$CR       end of record character
         fcb   $00        end of file character
         fcb   C$RPRT     reprint line character
         fcb   C$RPET     duplicate last line character
         fcb   C$PAUS     pause character
         fcb   $00        interrupt character
         fcb   $00        quit character
         fcb   C$BSP        backspace echo character
         fcb   C$BELL     line overflow character (bell)
         fcb   $00        init value for dev ctl reg
         fcb   B600       baud rate
         fdb   name       copy of descriptor name address
         fcb   $00        acia xon char
         fcb   $00        acia xoff char
         fcb   80         (szx) number of columns for display
         fcb   24         (szy) number of rows for display
initsize equ   *

name     fcs   /T1/
mgrnam   fcs   /SCF/
drvnam   fcs   /scdwt/

         emod  
eom      equ   *
         end   
