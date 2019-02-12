import xarray as xr
import cf_units as cf

def read_thetao_nc(file):
    ds = xr.open_dataset(file,chunks={'lev':1})
    return ds

def calc_ocean_heat(ds,dlim=275):
    ds = xr.open_dataset(file,chunks={'lev':1})
    lev_bnds_m = change_depth_to_m(ds)
    temp_K = change_temp_to_K(ds) 
    dlev_lim, temp_lim = limit_temp_to_dlim(lev_bnds_m, temp_K, dlim)
    weighted_temp = dlev_lim*temp_lim

    rho = 1026 #kg/m^3
    c_p = 3990 #J/(kg K)
    heat = weighted_temp.sum(dim="lev")*rho*c_p
    return heat

def change_depth_to_m(ds):
    orig_units = cf.Unit(ds.lev.attrs['units'])
    target_units = cf.Unit('m')
    lev_bnds_m = xr.apply_ufunc(orig_units.convert,ds.lev_bnds,target_units,dask='parallelized',output_dtypes=[ds.lev_bnds.dtype])
    return lev_bnds_m

def change_temp_to_K(ds):
    orig_units = cf.Unit(ds.thetao.attrs['units'])
    target_units = cf.Unit('K')
    temp_K = xr.apply_ufunc(orig_units.convert,ds.thetao,target_units,dask='parallelized',output_dtypes=[ds.thetao.dtype])
    return temp_K

def limit_temp_to_dlim(lev_bnds_m,temp_K,dlim): 
    lev_bnds_lim = lev_bnds_m.where(lev_bnds_m<dlim,dlim)
    dlev = abs(lev_bnds_lim[:,1]-lev_bnds_lim[:,0])
    dlev_lim = dlev.where(dlev!=0,drop=True)
    temp_lim = temp_K.where(dlev!=0,drop=True)
    return dlev_lim, temp_lim