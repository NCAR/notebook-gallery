import xarray as xr
import esmlab

def weighted_mean_ds(ds, weights, dim):

    if callable(weights):
        weights = weights(ds)
        
    # copy time 
    dso = xr.Dataset()
    time_coord_name = esmlab.utils.time.infer_time_coord_name(ds)
    tb_name, tb_dim = esmlab.utils.time.time_bound_var(ds, time_coord_name)
    dso[tb_name] = ds[tb_name]
    dso[time_coord_name] = ds[time_coord_name]
    
    # find variables where all `dim` appear (not sure we need to be this restrictive)
    variable_list = [v for v, da in ds.variables.items() 
                     if all(d in da.dims for d in dim)]

    apply_nan_mask = True
    for v in variable_list:
        dso[v] = esmlab.statistics.weighted_mean(ds[v], weights=weights, dim=dim,
                                                apply_nan_mask=apply_nan_mask)
        apply_nan_mask = False
    
    return dso