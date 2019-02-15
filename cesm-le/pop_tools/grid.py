import numpy as np
import xarray as xr


def vol3d(ds):

    nk = len(ds.z_t)
    nj = ds.KMT.shape[0]
    ni = ds.KMT.shape[1]

    # make 3D array of 0:km
    MASK = (xr.DataArray(np.arange(0, len(ds.z_t)), dims=('z_t'), 
                        coords={'z_t': ds.z_t}) *
            xr.DataArray(np.ones((nk, nj, ni)), dims=('z_t', 'nlat', 'nlon'),
                         coords={'z_t': ds.z_t}))

    # mask out cells where k is below KMT
    MASK = MASK.where(MASK <= ds.KMT - 1)
    MASK.values = np.where(MASK.notnull(), 1., 0.)

    MASKED_VOL = ds.dz * ds.TAREA * MASK
    MASKED_VOL.attrs['units'] = 'cm^3'
    MASKED_VOL.attrs['long_name'] = 'masked volume'

    return MASKED_VOL