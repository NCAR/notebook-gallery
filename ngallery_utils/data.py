import os

import pooch

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
}
DATASETS = pooch.create(
    path=['~', '.aletheia', 'data'],
    version_dev='master',
    base_url='ftp://ftp.cgd.ucar.edu/archive/aletheia-data',
    urls=URLS,
)

DATASETS.load_registry(os.path.join(os.path.dirname(__file__), 'registry.txt'))