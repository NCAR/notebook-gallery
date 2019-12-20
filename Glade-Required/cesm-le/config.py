import os
import intake_esm
import xcollection as xc

USER = os.environ['USER']

intake_esm.set_options(database_directory=f'/glade/work/{USER}/intake-collections',
                       cache_directory=f'/glade/scratch/{USER}/intake-cesm-data')
    
xc.set_options(cache_directory=f'/glade/scratch/{USER}/notebook-gallery-data')