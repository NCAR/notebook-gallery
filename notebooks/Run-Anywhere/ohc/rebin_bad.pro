function rebin_bad,block,dims,badval=badval,twod=twod,oned=oned,minval=minval,integrate=integrate,reform=reform,total=total
;20110330-added explicit statement to rule out all values over 9.9e35 due to problems flagging bad valudes
if not keyword_set(badval) then badval=1e36

s=size((block))
if s(0) eq 0 then begin & print,'The data block is not defined.' & stop & endif
if nel(s) eq 4 then oned=1
if nel(s) eq 5 then twod=1

;**get size dimensions of input block and check versus request
case s(0) of
	1:begin
    	d1=s(1) 
   		if ismult(d1,dims(0)) then xs=d1/float(dims(0)) else begin
    	    print,'x dim not a integer multiple of original array' &stop
    	endelse
    	output=fltarr(dims)
    	if xs lt 1 then xstep=xs-.0001 else xstep=1
    	for i=0,dims(0)-xstep do begin
    	    temp=block(fix(i*xs):fix(i*xs+xs-xstep))
    	    if keyword_set(minval) then gd=where(temp gt minval,ng) else gd=where(temp ne badval and temp lt 9.9e35,ng)
    	    if keyword_set(integrate) or keyword_set(total) then ngood=1. else ngood=float(ng)
   	   		if ng gt 0 then output(i)=total(temp(gd))/ngood else output(i)=badval
    	endfor
	endcase
	2:begin
    	d1=s(1) & d2=s(2)
   		if ismult(d1,dims(0)) then xs=d1/float(dims(0)) else begin
    	    print,'x dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d2,dims(1)) then ys=d2/float(dims(1)) else begin
    	    print,'y dim not a integer multiple of original array' &stop
    	endelse 
    	output=fltarr(dims(0),dims(1))
    	if xs lt 1 then xstep=xs-.0001 else xstep=1
    	if ys lt 1 then ystep=ys-.0001 else ystep=1
    	for i=0,dims(0)-xstep do for j=0,dims(1)-ystep do begin
    	    temp=block(fix(i*xs):fix(i*xs+xs-xstep),fix(j*ys):fix(j*ys+ys-ystep))
    	    if keyword_set(minval) then gd=where(temp gt minval,ng) else gd=where(temp ne badval and temp lt 9.9e35,ng) 
    	    if keyword_set(integrate) or keyword_set(total) then ngood=1. else ngood=float(ng)
   	   		if ng gt 0 then output(i,j)=total(temp(gd))/ngood else output(i,j)=badval
    	endfor
    endcase
	3:begin
    	d1=s(1) & d2=s(2) & d3=s(3)
    	if ismult(d1,dims(0)) then xs=d1/float(dims(0)) else begin
    	    print,'x dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d2,dims(1)) then ys=d2/float(dims(1)) else begin
    	    print,'y dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d3,dims(2)) then zs=d3/float(dims(2)) else begin
    	    print,'z dim not a integer multiple of original array' &stop
    	endelse 
    	output=fltarr(dims(0),dims(1),dims(2))
    	if xs lt 1 then xstep=xs-.0001 else xstep=1
    	if ys lt 1 then ystep=ys-.0001 else ystep=1
    	if zs lt 1 then zstep=zs-.0001 else zstep=1
    	for i=0,dims(0)-xstep do for j=0,dims(1)-ystep do for k=0,dims(2)-zstep do begin
       	 	temp=block(fix(i*xs):fix(i*xs+xs-xstep),fix(j*ys):fix(j*ys+ys-ystep),fix(k*zs):fix(k*zs-zstep+zs))
       		if keyword_set(minval) then gd=where(temp gt minval,ng) else gd=where(temp ne badval and temp lt 9.9e35,ng)
    	    if keyword_set(integrate) or keyword_set(total) then ngood=1. else ngood=float(ng)
   	   		if ng gt 0 then output(i,j,k)=total(temp(gd))/ngood else output(i,j,k)=badval
    	endfor
    endcase
	4:begin
    	d1=s(1) & d2=s(2) & d3=s(3) & d4=s(4)
    	if ismult(d1,dims(0)) then xs=d1/float(dims(0)) else begin
    	    print,'x dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d2,dims(1)) then ys=d2/float(dims(1)) else begin
    	    print,'y dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d3,dims(2)) then zs=d3/float(dims(2)) else begin
    	    print,'z dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d4,dims(3)) then ts=d4/float(dims(3)) else begin
    	    print,'t dim not a integer multiple of original array' &stop
    	endelse 
    	output=fltarr(dims(0),dims(1),dims(2),dims(3))
    	if xs lt 1 then xstep=xs-.0001 else xstep=1
    	if ys lt 1 then ystep=ys-.0001 else ystep=1
    	if zs lt 1 then zstep=zs-.0001 else zstep=1
    	if ts lt 1 then tstep=ts-.0001 else tstep=1
    	for i=0,dims(0)-xstep do for j=0,dims(1)-ystep do for k=0,dims(2)-zstep do for l=0,dims(3)-tstep do begin
       	 	temp=block(fix(i*xs):fix(i*xs+xs-xstep),fix(j*ys):fix(j*ys+ys-ystep),fix(k*zs):fix(k*zs-zstep+zs),fix(l*ts):fix(l*ts-tstep+ts))
       	 	if keyword_set(minval) then gd=where(temp gt minval,ng) else gd=where(temp ne badval and temp lt 9.9e35,ng)
    	    if keyword_set(integrate) or keyword_set(total) then ngood=1. else ngood=float(ng)
   	   		if ng gt 0 then output(i,j,k,l)=total(temp(gd))/ngood else output(i,j,k,l)=badval
    	endfor
    endcase
	5:begin
    	d1=s(1) & d2=s(2) & d3=s(3) & d4=s(4) & d5=s(5)
    	if ismult(d1,dims(0)) then xs=d1/float(dims(0)) else begin
    	    print,'x dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d2,dims(1)) then ys=d2/float(dims(1)) else begin
    	    print,'y dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d3,dims(2)) then zs=d3/float(dims(2)) else begin
    	    print,'z dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d4,dims(3)) then ts=d4/float(dims(3)) else begin
    	    print,'t dim not a integer multiple of original array' &stop
    	endelse 
    	if ismult(d5,dims(4)) then ms=d5/float(dims(4)) else begin
    	    print,'t dim not a integer multiple of original array' &stop
    	endelse 
    	output=fltarr(dims(0),dims(1),dims(2),dims(3),dims(4))
    	if xs lt 1 then xstep=xs-.0001 else xstep=1
    	if ys lt 1 then ystep=ys-.0001 else ystep=1
    	if zs lt 1 then zstep=zs-.0001 else zstep=1
    	if ts lt 1 then tstep=ts-.0001 else tstep=1
    	if ms lt 1 then mstep=ms-.0001 else mstep=1
    	for i=0,dims(0)-xstep do for j=0,dims(1)-ystep do for k=0,dims(2)-zstep do for l=0,dims(3)-tstep do for m=0,dims(4)-mstep do  begin
       	 	temp=block(fix(i*xs):fix(i*xs+xs-xstep),fix(j*ys):fix(j*ys+ys-ystep),fix(k*zs):fix(k*zs-zstep+zs),fix(l*ts):fix(l*ts-tstep+ts),fix(m*ms):fix(m*ms-mstep+ms))
       	 	if keyword_set(minval) then gd=where(temp gt minval,ng) else gd=where(temp ne badval and temp lt 9.9e35,ng)
    	    if keyword_set(integrate) or keyword_set(total) then ngood=1. else ngood=float(ng)
   	   		if ng gt 0 then output(i,j,k,l,m)=total(temp(gd))/ngood else output(i,j,k,l,m)=badval
    	endfor
    endcase
endcase
if not keyword_set(noreform) then output=reform(output)
return,output

end

