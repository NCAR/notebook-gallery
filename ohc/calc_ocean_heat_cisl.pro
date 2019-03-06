function calc_ocean_heat,t,levs,noadj=noadj,fulldepth=fulldepth,m700=m700,m300=m300,m500a=m500a,m5000=m5000,m2000=m2000,m100=m100, $
	lev_bnds=lev_bnds,verbose=verbose,m1500=m1500,mthousand=mthousand
;give the function a profile of t with modpoints of levs and it
;returns the integrated heat content/m2- upper level is assumed to terminate at depth=0 and lower
;level is assumed to terminate at depth=max(levs)+(max(levs)-max(levs(*:*-1)
;missing value assumed to be 1e36 or less than 265K
;by default, integrations only go to 275m...various options exist to change this
;set noadjust keyword to ignore conversion from C to K and allow values less than 265
;allows for missing values of 1e36
;density of sea water is assumed to be 1026 kg/m3
;specific heat is assumed to be 3990 J/kg/C 
;coded so that depths can vary from top to bottom or bottom to top.

dlim=275
t1=t
if keyword_set(m100) then dlim=100
if keyword_set(m300) then dlim=300
if keyword_set(m500a) then dlim=500
if keyword_set(m700) then dlim=700
if keyword_set(mthousand) then dlim=1000
if keyword_set(m1500) then dlim=1500
if keyword_set(m2000) then dlim=2000 
if keyword_set(fulldepth) or keyword_set(m5000) then dlim=max([levs,5000]) ;& if keyword_set(lev_bnds) then dlim=max([5000,max(lev_bnds)]) 
if max(levs) gt 10000. then begin & print,'Depth levels seem excessive. Check units.' & stop & endif
gd=where(t1 lt 1e30) & if max(levs) lt 2 then begin & print,'Are these levels in m or in some normalized units?' & stop & endif
if max(t1(gd)) gt -10 and max(t1(gd)) lt 60 and not keyword_set(noadj) then t1(gd)=t1(gd)+273.15 ;assume conversion from C to K is needed
mingood=268 & if keyword_set(noadj) then mingood=-5 ;sea water can't be less than -5C; use this to catch some alternative 'missing value' specifications
s=size(t1) & levdim=min(where(nel(levs) eq s)) ;identify the depth dimension
if (levdim) lt 0 then begin & print,'Cant find the dimension equal to the depth' & stop & endif

case s(0) of 
	1:begin &if levdim eq 1 then begin & nlon=1 & nlat=1 & ntime=1 & nlev=s(1)&endif
		heat=0. & endcase ;for a profile
	3:begin &if levdim eq 3 then begin & nlon=s(1) & nlat=s(2) & ntime=1 & nlev=s(3)&endif
		heat=fltarr(nlon,nlat) & endcase ;grid at one time
	4:begin &if levdim eq 3 then begin & nlon=s(1) & nlat=s(2) & ntime=s(4) & nlev=s(3)&endif
		heat=fltarr(nlon,nlat,ntime) & endcase ;grid with many times
endcase
lev1=0 & lev2=nlev-1 &levstep=1
if levs(0) gt lev(1) then begin &lev1=nlev-1 & lev2=0 & levstep=-1 & endif
for levi=lev1,lev2,levstep do begin ;loop through levels from top to bottom
	;get d1 and d2 - the layer boundaries in m depth
	if keyword_set(lev_bnds) then begin
		d1=lev_bnds(0,levi) & d2=lev_bnds(1,levi) ;this specifies the layer boundary based on explicitly provided levels as if typically the case in a model
	endif else begin  & if lev(0) gt lev(1) then begin & print,'Note: this part of the calc_ocean_heat routine executed in this way assumes levels go from top to bottom' & stop & endif
		case levi of 
		lev1:begin & d1=0 & d2=levs(0)&endcase ;layer thickness when derived from temps given at a discrete depth
		else:begin & d1=levs(levi-1) & d2=levs(levi) & endcase ;layer thickness when derived from temps given at a discrete depth
		endcase
	endelse
	if d1 lt dlim or d2 lt dlim then begin ;limit integrations to depth limit (dlim) - by default 275m but also 100, 300, 700, 2000 or 5000 depending on keyword set
		if d2 gt dlim then d2=dlim ;only use the fraction of a layer above the depth limit
		if d1 gt dlim then d1=dlim
		case s(0) of 
			1:begin
				if levdim eq 1 then begin& if levi eq lev1 or keyword_set(lev_bnds) then tmp=t1(levi)  else tmp=rebin_bad(t1(levi-1:levi),[1]) & endif 
				endcase ;how to compute OHC depends on the data provided. for obs this is often as a reading at a point, which requires averaging across a layer to get its mean temperature and using the provided depths as boundaries (except at the surface), while in models this is often given as an average across a layer where the bounds are given
			3:begin
				if levdim eq 3 then begin&  if levi eq lev1 or keyword_set(lev_bnds) then tmp=reform(t1(*,*,levi)) else tmp=rebin_bad(t1(*,*,levi-1:levi),[s(1),s(2),1])& endif
				endcase
			4:begin
				if levdim eq 3 then begin&  if levi eq lev1 or keyword_set(lev_bnds) then tmp=reform(t1(*,*,levi,*)) else tmp=rebin_bad(t1(*,*,levi-1:levi,*),[s(1),s(2),1,s(4)])& endif
				endcase
			4:begin
				if levdim eq 4 then begin& if levi eq lev1 or keyword_set(lev_bnds) then tmp=reform(t1(*,*,*,levi)) else tmp=rebin_bad(t1(*,*,*,levi-1:levi),[s(1),s(2),s(3),1])& endif
				endcase
		endcase 
		bd=where(tmp gt 1e35 or tmp lt mingood or tmp lt 263,nb) & if nb gt 0 then tmp(bd)=0
		heat=heat+abs(d2-d1)*1026.*3990.*tmp 
		if keyword_set(verbose) then hlp,heat,levi,lev1,lev2,dlim
	endif
endfor
bd=where(heat eq 0,nb) & if nb gt 0 then heat(bd)=1e36
if min(heat) gt 1e30 then stop
return,heat
end

pro test
;test the routine

fi=ncdf_open('/Users/john/DATA/worldocean/WOA01/WOA01.nc')
ncdf_varget,fi,'thetao',t,count=[360,180,20,12],offset=[0,0,0,0] & t=t*.001+10.+273.15
ncdf_varget,fi,'levs',levs,count=[20],offset=[0]
ncdf_varget,fi,'lon',lon ;,count=[2],offset=[60] 
ncdf_varget,fi,'lat',lat ;,count=[2],offset=[90]
ncdf_close,fi

heat=calc_ocean_heat(t,levs)

save,file='/Users/john/data/woa/woa_heat_unprocessed.sav',heat,levs,lon,lat

stop
end
