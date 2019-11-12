#!/usr/bin/env python

"""The setup script."""

from os.path import exists

from setuptools import find_packages, setup

if exists('README.rst'):
    with open('README.rst') as f:
        long_description = f.read()
else:
    long_description = ''

DISTNAME = 'ngallery-utils'
LICENSE = 'Apache 2.0'
AUTHOR = 'Xdev Team'
AUTHOR_EMAIL = 'xdev@ucar.edu'
URL = 'https://github.com/NCAR/aletheia-data'
CLASSIFIERS = [
    'Development Status :: 4 - Beta',
    'License :: OSI Approved :: Apache Software License',
    'Operating System :: OS Independent',
    'Intended Audience :: Science/Research',
    'Programming Language :: Python',
    'Programming Language :: Python :: 3',
    'Programming Language :: Python :: 3.6',
    'Topic :: Scientific/Engineering',
]

INSTALL_REQUIRES = ['pooch']
PYTHON_REQUIRES = '>=3.6'
DESCRIPTION = 'Utility package for notebook gallery'


setup(
    name=DISTNAME,
    description=DESCRIPTION,
    long_description=long_description,
    maintainer=AUTHOR,
    maintainer_email=AUTHOR_EMAIL,
    url=URL,
    packages=find_packages(),
    include_package_data=True,
    install_requires=INSTALL_REQUIRES,
    license=LICENSE,
    zip_safe=False,
    keywords='',
    use_scm_version=True,
    setup_requires=['setuptools_scm', 'setuptools>=30.3.0', 'setuptools_scm_git_archive'],
)
