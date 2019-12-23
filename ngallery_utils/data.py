import os

import pooch

from .util import identify_host


hostname = identify_host()

data_cache_map = {'cheyenne': '/glade/work/abanihi/aletheia-data/tutorial-data/',
                  'casper': '/glade/work/abanihi/aletheia-data/tutorial-data/',
                  'hobart': '/ftp/archive/aletheia-data/tutorial-data/',
                  'unknown': '~/aletheia-data/tutorial-data/',
                 }

BASE_URL = 'ftp://ftp.cgd.ucar.edu/archive/aletheia-data'
TUTORIAL_DATA_URL = f'{BASE_URL}/tutorial-data'
URLS = {
    'thetao_Omon_historical_GISS-E2-1-G_r1i1p1f1_gn_185001-185512.nc': f'{TUTORIAL_DATA_URL}/thetao_Omon_historical_GISS-E2-1-G_r1i1p1f1_gn_185001-185512.nc',
    'woa2013v2-O2-thermocline-ann.nc': f'{TUTORIAL_DATA_URL}/woa2013v2-O2-thermocline-ann.nc',
    'NOAA_NCDC_ERSST_v3b_SST.nc': f'{TUTORIAL_DATA_URL}/NOAA_NCDC_ERSST_v3b_SST.nc',
    'sst_indices.csv': f'{TUTORIAL_DATA_URL}/sst_indices.csv',
    'air_temperature.nc': f'{TUTORIAL_DATA_URL}/air_temperature.nc',
    'rasm.nc': f'{TUTORIAL_DATA_URL}/rasm.nc',
    'co2.nc': f'{TUTORIAL_DATA_URL}/co2.nc',
    'moc.nc': f'{TUTORIAL_DATA_URL}/moc.nc',
    'aviso_madt_2015.tar.gz': f'{TUTORIAL_DATA_URL}/aviso_madt_2015.tar.gz',
    'NARR_19930313_0000.nc': f'{TUTORIAL_DATA_URL}/NARR_19930313_0000.nc',
    'MPAS.nc': f'{TUTORIAL_DATA_URL}/MPAS.nc',
    'Oklahoma.static.nc': f'{TUTORIAL_DATA_URL}/Oklahoma.static.nc',
    'uas.rcp85.CanESM2.CRCM5-UQAM.day.NAM-44i.raw.Colorado.nc': f'{TUTORIAL_DATA_URL}/uas.rcp85.CanESM2.CRCM5-UQAM.day.NAM-44i.raw.Colorado.nc',
    'uas.hist.CanESM2.CRCM5-UQAM.day.NAM-44i.raw.Colorado.nc': f'{TUTORIAL_DATA_URL}/uas.hist.CanESM2.CRCM5-UQAM.day.NAM-44i.raw.Colorado.nc',
    'uas.gridMET.NAM-44i.Colorado.nc': f'{TUTORIAL_DATA_URL}/uas.gridMET.NAM-44i.Colorado.nc'
    'WRF_output_2T_RR_F/all_T2_RR_F_2014_2019_SST.nc': f'{TUTORIAL_DATA_URL}/all_T2_RR_F_2014_2019_SST.nc'
}
DATASETS = pooch.create(
    path=data_cache_map[hostname],
    version_dev='master',
    base_url='ftp://ftp.cgd.ucar.edu/archive/aletheia-data',
    urls=URLS,
)

DATASETS.load_registry(os.path.join(os.path.dirname(__file__), 'registry.txt'))
