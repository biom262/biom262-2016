# `conda install whywontyouinstall` issues

There's been some update to Anaconda which has messed up in the R installation, and you've probably seen an error message like this:

```
Error: MD5 sums mismatch for download: https://conda.anaconda.org/r/linux-64/glib-2.43.0-2.tar.bz2 (68c651c6eb669975d5a2e7a0aa785291 != ca7f3f7a0ba9cb98492b54a00095d2ab)
```

To trick `conda` into thinking we already have this downloaded, we'll need to manually download these packages and save them to `$HOME/anaconda3/pkgs`. Here's how.

First, let's update `conda` with `conda update conda`

```
$ conda update conda
Fetching package metadata: ....
Solving package specifications: ....................
Package plan for installation in environment /home/ucsd-train01/anaconda3:

The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    requests-2.9.0             |           py35_0         647 KB  defaults
    setuptools-19.1.1          |           py35_0         348 KB  defaults
    conda-3.19.0               |           py35_0         180 KB  defaults
    ------------------------------------------------------------
                                           Total:         1.1 MB

The following packages will be UPDATED:

    conda:      3.18.8-py35_0 defaults --> 3.19.0-py35_0 defaults
    requests:   2.8.1-py35_0  defaults --> 2.9.0-py35_0  defaults
    setuptools: 18.5-py35_0   defaults --> 19.1.1-py35_0 defaults

Proceed ([y]/n)? y

Fetching packages ...
requests-2.9.0 100% |#############################################################| Time: 0:00:00 932.16 kB/s
setuptools-19. 100% |#############################################################| Time: 0:00:00 524.97 kB/s
conda-3.19.0-p 100% |#############################################################| Time: 0:00:00 511.75 kB/s
Extracting packages ...
[      COMPLETE      ]|################################################################################| 100%
Unlinking packages ...
[      COMPLETE      ]|################################################################################| 100%
Linking packages ...
[      COMPLETE      ]|################################################################################| 100%
```


Now that we have an updated `conda`, change directories into `~/anaconda3/pkgs`

```
cd ~/anaconda3/pkgs`
```

(Remember that you can always check where you are by "printing the working directory" or `pwd`):

```
$ pwd
/home/ucsd-train01/anaconda3/pkgs
```

Take a look around with `ls`. It'll probalby look something like this

```
$ ls
abstract-rendering-0.5.1-np110py35_0  jupyter_client-4.1.1-py35_0    pytables-3.2.2-np110py35_0
alabaster-0.7.6-py35_0                jupyter_console-4.0.3-py35_0   pytest-2.8.1-py35_0
anaconda-2.4.1-np110py35_0            jupyter_core-4.0.6-py35_0      python-3.5.1-0
anaconda-client-1.2.1-py35_0          libdynd-0.7.0-0                python-dateutil-2.4.2-py35_0
argcomplete-1.0.0-py35_1              libffi-3.0.13-0                pytz-2015.7-py35_0
astropy-1.0.6-np110py35_0             libgfortran-1.0-0              pyyaml-3.11-py35_1
babel-2.1.1-py35_0                    libpng-1.6.17-0                pyzmq-14.7.0-py35_1
beautifulsoup4-4.4.1-py35_0           libsodium-1.0.3-0              qt-4.8.7-1
bitarray-0.8.1-py35_0                 libtiff-4.0.6-1                qtconsole-4.1.1-py35_0
blaze-core-0.8.3-py35_0               libxml2-2.9.2-0                readline-6.2-2
bokeh-0.10.0-py35_0                   libxslt-1.1.28-0               redis-2.6.9-0
boto-2.38.0-py35_0                    _license-1.1-py35_1            redis-py-2.10.3-py35_0
bottleneck-1.0.0-np110py35_0          llvmlite-0.8.0-py35_0          requests-2.8.1-py35_0
cache                                 lxml-3.4.4-py35_0              requests-2.9.0-py35_0
_cache-0.0-py35_x0                    markupsafe-0.23-py35_0         rope-0.9.4-py35_1
cffi-1.2.1-py35_0                     matplotlib-1.5.0-np110py35_0   scikit-image-0.11.3-np110py35_0
clyent-1.2.0-py35_0                   mistune-0.7.1-py35_0           scikit-learn-0.17-np110py35_1
colorama-0.3.3-py35_0                 multipledispatch-0.4.8-py35_0  scipy-0.16.0-np110py35_1
conda-3.18.8-py35_0                   nbconvert-4.0.0-py35_0         setuptools-18.5-py35_0
conda-3.19.0-py35_0                   nbformat-4.0.1-py35_0          setuptools-19.1.1-py35_0
conda-build-1.18.2-py35_0             networkx-1.10-py35_0           simplegeneric-0.8.1-py35_0
conda-env-2.4.5-py35_0                nltk-3.1-py35_0                sip-4.16.9-py35_0
configobj-5.0.6-py35_0                nose-1.3.7-py35_0              six-1.10.0-py35_0
cryptography-1.0.2-py35_0             notebook-4.0.6-py35_0          snowballstemmer-1.2.0-py35_0
curl-7.45.0-0                         numba-0.22.1-np110py35_0       sockjs-tornado-1.0.1-py35_0
cycler-0.9.0-py35_0                   numexpr-2.4.4-np110py35_0      sphinx-1.3.1-py35_0
cython-0.23.4-py35_0                  numpy-1.10.1-py35_0            sphinx_rtd_theme-0.1.7-py35_0
cytoolz-0.7.4-py35_0                  odo-0.3.4-py35_0               spyder-2.3.8-py35_0
datashape-0.4.7-np110py35_1           openblas-0.2.14-3              spyder-app-2.3.8-py35_0
decorator-4.0.4-py35_0                openpyxl-2.2.6-py35_0          sqlalchemy-1.0.9-py35_0
docutils-0.12-py35_0                  openssl-1.0.2d-0               sqlite-3.8.4.1-1
dynd-python-0.7.0-py35_0              pandas-0.17.1-np110py35_0      statsmodels-0.6.1-np110py35_0
fastcache-1.0.2-py35_0                patchelf-0.6-0                 sympy-0.7.6.1-py35_0
flask-0.10.1-py35_1                   path.py-8.1.2-py35_1           terminado-0.5-py35_1
fontconfig-2.11.1-5                   patsy-0.4.0-np110py35_0        theano-0.7.0-np110py35_0
freetype-2.5.5-0                      pep8-1.6.2-py35_0              tk-8.5.18-0
greenlet-0.4.9-py35_0                 pexpect-3.3-py35_0             toolz-0.7.4-py35_0
h5py-2.5.0-np110py35_4                pickleshare-0.5-py35_0         tornado-4.3-py35_0
hdf5-1.8.15.1-2                       pillow-3.0.0-py35_1            traitlets-4.0.0-py35_0
idna-2.0-py35_0                       pip-7.1.2-py35_0               ujson-1.33-py35_0
ipykernel-4.1.1-py35_0                ply-3.8-py35_0                 unicodecsv-0.14.1-py35_0
ipython-4.0.1-py35_0                  psutil-3.3.0-py35_0            urls.txt
ipython_genutils-0.1.0-py35_0         ptyprocess-0.5-py35_0          util-linux-2.21-0
ipython-notebook-4.0.4-py35_0         py-1.4.30-py35_0               werkzeug-0.11.2-py35_0
ipython-qtconsole-4.0.1-py35_0        pyasn1-0.1.9-py35_0            wheel-0.26.0-py35_1
ipywidgets-4.1.0-py35_0               pycosat-0.6.1-py35_0           xlrd-0.9.4-py35_0
itsdangerous-0.24-py35_0              pycparser-2.14-py35_0          xlsxwriter-0.7.7-py35_0
jbig-2.1-0                            pycrypto-2.6.1-py35_0          xlwt-1.0.0-py35_0
jdcal-1.0-py35_0                      pycurl-7.19.5.1-py35_3         xz-5.0.5-0
jedi-0.9.0-py35_0                     pyflakes-1.0.0-py35_0          yaml-0.1.6-0
jinja2-2.8-py35_0                     pygments-2.0.2-py35_0          zeromq-4.1.3-0
jpeg-8d-0                             pyopenssl-0.15.1-py35_1        zlib-1.2.8-0
jsonschema-2.4.0-py35_0               pyparsing-2.0.3-py35_0
jupyter-1.0.0-py35_1                  pyqt-4.11.4-py35_1
```


Now we need to do our manual download. Copy/paste the code block below and **press enter.**

```
wget https://anaconda.org/r/ncurses/5.9/download/linux-64/ncurses-5.9-4.tar.bz2
wget https://anaconda.org/r/nlopt/2.4.2/download/linux-64/nlopt-2.4.2-1.tar.bz2
wget https://anaconda.org/r/glib/2.43.0/download/linux-64/glib-2.43.0-2.tar.bz2
```

The output will look like this:

```
[ucsd-train01@tscc-login2 pkgs]$ wget https://anaconda.org/r/ncurses/5.9/download/linux-64/ncurses-5.9-4.tar.bz2
--2016-01-12 09:48:59--  https://anaconda.org/r/ncurses/5.9/download/linux-64/ncurses-5.9-4.tar.bz2
Resolving anaconda.org... 54.225.102.25, 23.21.137.79
Connecting to anaconda.org|54.225.102.25|:443... connected.
HTTP request sent, awaiting response... 302 FOUND
Location: https://binstar-cio-packages-prod.s3.amazonaws.com/53c83ec45e768323ef188ec0/557f301e1d4e0538f426f568?Signature=84J9kJoVODhLCYan7JAv8LKy1r0%3D&Expires=1452620999&AWSAccessKeyId=ASIAJG3RBWPNO4JQFT2A&response-content-disposition=attachment%3B%20filename%3Dlinux-64/ncurses-5.9-4.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBoa4AONBNPCNFsbLcOzH%2BqkPEpwx1TSJxPOS2knO5iYKmzLOM4g1m7/CP2Va2bWHCUe4kR8d%2BAkjkA9zi/xLLwRswuOmgSiCW2l02cwwn1a6HI3xjLysAJM1TKsOwVqwhejaTh9BgGB79pGmoDZIjBc0Bx//c1tRSZHrde6kxs36bPP22m3dP5p%2B8kTDXtVDf3q6IVanL8dip4KPhXkrR8GH99MtcuCVzcAUjrcr18h9Oc11db7Pyqm08pZPCbOErnicHwtqjAz84dRE2QkDYKQP7%2BVMtqfx6/wju7T3KPAF2ZJiISWXM4RrdbKJGdyTStqwHBI0VvAxsWBGTKWOYN/ExktWyxHGD4W74o99A1vv6R%2Bmudq2FhFMSxxpJrCP%2B6mUq/M3qq2V8dRNXC67K4rcPXDqeSEtyH1WAT5I9oiElcjNuXB3uCTWYS%2BiVwD9fDzqzeTXRqvc3hPmE7q/x7mMq9fqhKEjNFKHKdq5gLURBKGqIDYiPfAU0K4L8cJn6Fdtv50xr33G%2BMAwsi/v9iTh9rXrQLaDHohuSd8CvS/u4URfl3jD/EMirUQkMT/DYWfgtKcp6Hy5RtQCFI9DqAfXkPsK4zOnBIPRmJf4YIxYi1xGtaP3BXLc6kqsEX/L8/o34UgldbUtAU%3D [following]
--2016-01-12 09:48:59--  https://binstar-cio-packages-prod.s3.amazonaws.com/53c83ec45e768323ef188ec0/557f301e1d4e0538f426f568?Signature=84J9kJoVODhLCYan7JAv8LKy1r0%3D&Expires=1452620999&AWSAccessKeyId=ASIAJG3RBWPNO4JQFT2A&response-content-disposition=attachment%3B%20filename%3Dlinux-64/ncurses-5.9-4.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBoa4AONBNPCNFsbLcOzH%2BqkPEpwx1TSJxPOS2knO5iYKmzLOM4g1m7/CP2Va2bWHCUe4kR8d%2BAkjkA9zi/xLLwRswuOmgSiCW2l02cwwn1a6HI3xjLysAJM1TKsOwVqwhejaTh9BgGB79pGmoDZIjBc0Bx//c1tRSZHrde6kxs36bPP22m3dP5p%2B8kTDXtVDf3q6IVanL8dip4KPhXkrR8GH99MtcuCVzcAUjrcr18h9Oc11db7Pyqm08pZPCbOErnicHwtqjAz84dRE2QkDYKQP7%2BVMtqfx6/wju7T3KPAF2ZJiISWXM4RrdbKJGdyTStqwHBI0VvAxsWBGTKWOYN/ExktWyxHGD4W74o99A1vv6R%2Bmudq2FhFMSxxpJrCP%2B6mUq/M3qq2V8dRNXC67K4rcPXDqeSEtyH1WAT5I9oiElcjNuXB3uCTWYS%2BiVwD9fDzqzeTXRqvc3hPmE7q/x7mMq9fqhKEjNFKHKdq5gLURBKGqIDYiPfAU0K4L8cJn6Fdtv50xr33G%2BMAwsi/v9iTh9rXrQLaDHohuSd8CvS/u4URfl3jD/EMirUQkMT/DYWfgtKcp6Hy5RtQCFI9DqAfXkPsK4zOnBIPRmJf4YIxYi1xGtaP3BXLc6kqsEX/L8/o34UgldbUtAU%3D
Resolving binstar-cio-packages-prod.s3.amazonaws.com... 54.231.80.72
Connecting to binstar-cio-packages-prod.s3.amazonaws.com|54.231.80.72|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 732730 (716K) [application/x-tar]
Saving to: “ncurses-5.9-4.tar.bz2”

100%[===================================================================>] 732,730      826K/s   in 0.9s    

2016-01-12 09:49:01 (826 KB/s) - “ncurses-5.9-4.tar.bz2” saved [732730/732730]

[ucsd-train01@tscc-login2 pkgs]$ wget https://anaconda.org/r/nlopt/2.4.2/download/linux-64/nlopt-2.4.2-1.tar.bz2
--2016-01-12 09:49:01--  https://anaconda.org/r/nlopt/2.4.2/download/linux-64/nlopt-2.4.2-1.tar.bz2
Resolving anaconda.org... 54.225.102.25, 23.21.137.79
Connecting to anaconda.org|54.225.102.25|:443... connected.
HTTP request sent, awaiting response... 302 FOUND
Location: https://binstar-cio-packages-prod.s3.amazonaws.com/546e40735e76831f659ea0fd/54e4efb45e7683344eb26e1d?Signature=iAXH24NDjjCoYRornQjy7W4qBBM%3D&Expires=1452621001&AWSAccessKeyId=ASIAJG3RBWPNO4JQFT2A&response-content-disposition=attachment%3B%20filename%3Dlinux-64/nlopt-2.4.2-1.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBoa4AONBNPCNFsbLcOzH%2BqkPEpwx1TSJxPOS2knO5iYKmzLOM4g1m7/CP2Va2bWHCUe4kR8d%2BAkjkA9zi/xLLwRswuOmgSiCW2l02cwwn1a6HI3xjLysAJM1TKsOwVqwhejaTh9BgGB79pGmoDZIjBc0Bx//c1tRSZHrde6kxs36bPP22m3dP5p%2B8kTDXtVDf3q6IVanL8dip4KPhXkrR8GH99MtcuCVzcAUjrcr18h9Oc11db7Pyqm08pZPCbOErnicHwtqjAz84dRE2QkDYKQP7%2BVMtqfx6/wju7T3KPAF2ZJiISWXM4RrdbKJGdyTStqwHBI0VvAxsWBGTKWOYN/ExktWyxHGD4W74o99A1vv6R%2Bmudq2FhFMSxxpJrCP%2B6mUq/M3qq2V8dRNXC67K4rcPXDqeSEtyH1WAT5I9oiElcjNuXB3uCTWYS%2BiVwD9fDzqzeTXRqvc3hPmE7q/x7mMq9fqhKEjNFKHKdq5gLURBKGqIDYiPfAU0K4L8cJn6Fdtv50xr33G%2BMAwsi/v9iTh9rXrQLaDHohuSd8CvS/u4URfl3jD/EMirUQkMT/DYWfgtKcp6Hy5RtQCFI9DqAfXkPsK4zOnBIPRmJf4YIxYi1xGtaP3BXLc6kqsEX/L8/o34UgldbUtAU%3D [following]
--2016-01-12 09:49:01--  https://binstar-cio-packages-prod.s3.amazonaws.com/546e40735e76831f659ea0fd/54e4efb45e7683344eb26e1d?Signature=iAXH24NDjjCoYRornQjy7W4qBBM%3D&Expires=1452621001&AWSAccessKeyId=ASIAJG3RBWPNO4JQFT2A&response-content-disposition=attachment%3B%20filename%3Dlinux-64/nlopt-2.4.2-1.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBoa4AONBNPCNFsbLcOzH%2BqkPEpwx1TSJxPOS2knO5iYKmzLOM4g1m7/CP2Va2bWHCUe4kR8d%2BAkjkA9zi/xLLwRswuOmgSiCW2l02cwwn1a6HI3xjLysAJM1TKsOwVqwhejaTh9BgGB79pGmoDZIjBc0Bx//c1tRSZHrde6kxs36bPP22m3dP5p%2B8kTDXtVDf3q6IVanL8dip4KPhXkrR8GH99MtcuCVzcAUjrcr18h9Oc11db7Pyqm08pZPCbOErnicHwtqjAz84dRE2QkDYKQP7%2BVMtqfx6/wju7T3KPAF2ZJiISWXM4RrdbKJGdyTStqwHBI0VvAxsWBGTKWOYN/ExktWyxHGD4W74o99A1vv6R%2Bmudq2FhFMSxxpJrCP%2B6mUq/M3qq2V8dRNXC67K4rcPXDqeSEtyH1WAT5I9oiElcjNuXB3uCTWYS%2BiVwD9fDzqzeTXRqvc3hPmE7q/x7mMq9fqhKEjNFKHKdq5gLURBKGqIDYiPfAU0K4L8cJn6Fdtv50xr33G%2BMAwsi/v9iTh9rXrQLaDHohuSd8CvS/u4URfl3jD/EMirUQkMT/DYWfgtKcp6Hy5RtQCFI9DqAfXkPsK4zOnBIPRmJf4YIxYi1xGtaP3BXLc6kqsEX/L8/o34UgldbUtAU%3D
Resolving binstar-cio-packages-prod.s3.amazonaws.com... 54.231.80.72
Connecting to binstar-cio-packages-prod.s3.amazonaws.com|54.231.80.72|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 451418 (441K) [application/x-tar]
Saving to: “nlopt-2.4.2-1.tar.bz2”

100%[===================================================================>] 451,418      581K/s   in 0.8s    

2016-01-12 09:49:02 (581 KB/s) - “nlopt-2.4.2-1.tar.bz2” saved [451418/451418]

[ucsd-train01@tscc-login2 pkgs]$ wget https://anaconda.org/r/glib/2.43.0/download/linux-64/glib-2.43.0-2.tar.bz2
--2016-01-12 09:49:05--  https://anaconda.org/r/glib/2.43.0/download/linux-64/glib-2.43.0-2.tar.bz2
Resolving anaconda.org... 54.225.102.25, 23.21.137.79
Connecting to anaconda.org|54.225.102.25|:443... connected.
HTTP request sent, awaiting response... 302 FOUND
Location: https://binstar-cio-packages-prod.s3.amazonaws.com/53c058395e7683532898caea/54b00b195e768372503c2875?Signature=kIuyW41u%2FTZMPXyxplijMwHtHH8%3D&Expires=1452621005&AWSAccessKeyId=ASIAIUODTQ2XUNE34SVQ&response-content-disposition=attachment%3B%20filename%3Dlinux-64/glib-2.43.0-2.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBka4ANmST6BCLSFPfMMbzf4GvxyaTH8FCIsrabCFI49OVGEPDp5S8EIaBYXjoogZtPZz5SCl6Fn4xetZXGD/MSLn3zbqVMRUHiwpU1VLleu4HVc8ll4uRuz0xgNjVl5DFWLlwzF9BJHeELZNcruSF175ylzFR7nX8oaojOVaDAERYCVtOuDy7rSQqH8e3uE4th1tojJBmHb0XhAs3w4Yr3yb7bIpv9onr9uhr//fEylYgW9M/Qnbayx1hwjlasEzmcIFEOfQ8H6nsMmJ1l8sSTf5Up6x0pS9tHyKpaZB0RQnvWUDOuqlZJ8cDtOdU/QzdWDm3Y3OOwnpL7xzIGMcjzfRplpZm29KLeKO4URGdxFeklfUUbynv79mwQIRHalO%2BlT7LiCmjUAMHZxOQAqmgry1B3cdeKIMCuCu6DeMJ/vEDGFJA3%2B47F0Svn2iGZqOkkNbi0lwOLf3WcIY1JJnLFyxXFwMHBtp1hGZjf%2BsouljIVxiwJyJaEirFc3XCav4bhdliYIoyanpJIi8Jy4293xtk7p/Z34cZKiiVDgT6W%2B6hp1zB2cd8QNPKJOwc6ADEn8pA3SrZJR3SWlSmtuoO3yVU7cdegqrkNfdXCIzPhIn4GhWzNgef2gyEsbOsNzF0bKwbwg9cbUtAU%3D [following]
--2016-01-12 09:49:05--  https://binstar-cio-packages-prod.s3.amazonaws.com/53c058395e7683532898caea/54b00b195e768372503c2875?Signature=kIuyW41u%2FTZMPXyxplijMwHtHH8%3D&Expires=1452621005&AWSAccessKeyId=ASIAIUODTQ2XUNE34SVQ&response-content-disposition=attachment%3B%20filename%3Dlinux-64/glib-2.43.0-2.tar.bz2&response-content-type=application/x-tar&x-amz-security-token=AQoDYXdzEBka4ANmST6BCLSFPfMMbzf4GvxyaTH8FCIsrabCFI49OVGEPDp5S8EIaBYXjoogZtPZz5SCl6Fn4xetZXGD/MSLn3zbqVMRUHiwpU1VLleu4HVc8ll4uRuz0xgNjVl5DFWLlwzF9BJHeELZNcruSF175ylzFR7nX8oaojOVaDAERYCVtOuDy7rSQqH8e3uE4th1tojJBmHb0XhAs3w4Yr3yb7bIpv9onr9uhr//fEylYgW9M/Qnbayx1hwjlasEzmcIFEOfQ8H6nsMmJ1l8sSTf5Up6x0pS9tHyKpaZB0RQnvWUDOuqlZJ8cDtOdU/QzdWDm3Y3OOwnpL7xzIGMcjzfRplpZm29KLeKO4URGdxFeklfUUbynv79mwQIRHalO%2BlT7LiCmjUAMHZxOQAqmgry1B3cdeKIMCuCu6DeMJ/vEDGFJA3%2B47F0Svn2iGZqOkkNbi0lwOLf3WcIY1JJnLFyxXFwMHBtp1hGZjf%2BsouljIVxiwJyJaEirFc3XCav4bhdliYIoyanpJIi8Jy4293xtk7p/Z34cZKiiVDgT6W%2B6hp1zB2cd8QNPKJOwc6ADEn8pA3SrZJR3SWlSmtuoO3yVU7cdegqrkNfdXCIzPhIn4GhWzNgef2gyEsbOsNzF0bKwbwg9cbUtAU%3D
Resolving binstar-cio-packages-prod.s3.amazonaws.com... 54.231.81.160
Connecting to binstar-cio-packages-prod.s3.amazonaws.com|54.231.81.160|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 7450093 (7.1M) [application/x-tar]
Saving to: “glib-2.43.0-2.tar.bz2”

100%[===================================================================>] 7,450,093   2.68M/s   in 2.7s    

2016-01-12 09:49:08 (2.68 MB/s) - “glib-2.43.0-2.tar.bz2” saved [7450093/7450093]

```

Now try to install `r`, `r-essentials` and `r-irkernel` again. The `--yes` flag tells `conda`, "Yes I want these installed - please don't ask me if I want to proceed!"

```
conda install --yes -c r r-essentials r-irkernel
```

The output is VERY big and looks like this:

```
Fetching package metadata: ......
Solving package specifications: ........................................................................................
Package plan for installation in environment /home/ucsd-train01/anaconda3:

The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    libgcc-4.8.5               |                1         922 KB
    pcre-8.31                  |                0         534 KB
    pixman-0.32.6              |                0         2.4 MB
    decorator-4.0.6            |           py35_0           6 KB
    pyzmq-15.1.0               |           py35_0         782 KB
    cairo-1.12.18              |                6         594 KB
    harfbuzz-0.9.35            |                6         1.1 MB
    pango-1.36.8               |                3         796 KB
    nbconvert-4.1.0            |           py35_0         275 KB
    r-base-3.2.2               |                0        20.6 MB
    r-3.2.2                    |                0           2 KB
    r-assertthat-0.1           |         r3.2.2_1          44 KB
    r-base64enc-0.1_3          |         r3.2.2_0          25 KB
    r-bh-1.58.0_1              |         r3.2.2_0         5.5 MB
    r-bitops-1.0_6             |         r3.2.2_1          23 KB
    r-boot-1.3_17              |         r3.2.2_0         575 KB
    r-chron-2.3_47             |         r3.2.2_0          98 KB
    r-cluster-2.0.3            |         r3.2.2_0         466 KB
    r-codetools-0.2_14         |         r3.2.2_0          45 KB
    r-colorspace-1.2_6         |         r3.2.2_0         371 KB
    r-dbi-0.3.1                |         r3.2.2_2         168 KB
    r-dichromat-2.0_0          |         r3.2.2_2         146 KB
    r-digest-0.6.8             |         r3.2.2_2          93 KB
    r-foreign-0.8_66           |         r3.2.2_0         220 KB
    r-formatr-1.2.1            |         r3.2.2_0          46 KB
    r-gtable-0.1.2             |         r3.2.2_2          62 KB
    r-highr-0.5.1              |         r3.2.2_0          30 KB
    r-iterators-1.0.8          |         r3.2.2_0         304 KB
    r-jsonlite-0.9.17          |         r3.2.2_0         927 KB
    r-kernsmooth-2.23_15       |         r3.2.2_0          84 KB
    r-labeling-0.3             |         r3.2.2_1          40 KB
    r-lattice-0.20_33          |         r3.2.2_0         698 KB
    r-lazyeval-0.1.10          |         r3.2.2_2          44 KB
    r-magrittr-1.5             |         r3.2.2_1         154 KB
    r-maps-3.0.0_2             |         r3.2.2_0         3.3 MB
    r-mass-7.3_45              |         r3.2.2_0         1.0 MB
    r-mime-0.4                 |         r3.2.2_0          26 KB
    r-nloptr-1.0.4             |         r3.2.2_1         728 KB
    r-nnet-7.3_11              |         r3.2.2_0          99 KB
    r-proto-0.3_10             |         r3.2.2_1         454 KB
    r-r6-2.1.1                 |         r3.2.2_0         112 KB
    r-randomforest-4.6_12      |         r3.2.2_0         141 KB
    r-rcolorbrewer-1.1_2       |         r3.2.2_2          26 KB
    r-rcpp-0.12.2              |         r3.2.2_0         2.2 MB
    r-repr-0.3                 |         r3.2.2_0          44 KB
    r-rjsonio-1.3_0            |         r3.2.2_1         982 KB
    r-rpart-4.1_10             |         r3.2.2_0         861 KB
    r-rzmq-0.7.7               |         r3.2.2_3          60 KB
    r-sparsem-1.7              |         r3.2.2_0         739 KB
    r-spatial-7.3_11           |         r3.2.2_0         122 KB
    r-stringi-1.0_1            |         r3.2.2_0        10.7 MB
    r-survival-2.38_3          |         r3.2.2_0         4.4 MB
    r-uuid-0.1_2               |         r3.2.2_0          18 KB
    r-xtable-1.8_0             |         r3.2.2_0         320 KB
    r-yaml-2.1.13              |         r3.2.2_1          81 KB
    r-catools-1.17.1           |         r3.2.2_2         157 KB
    r-class-7.3_14             |         r3.2.2_0          82 KB
    r-data.table-1.9.6         |         r3.2.2_0         1.5 MB
    r-dplyr-0.4.3              |         r3.2.2_0         1.7 MB
    r-foreach-1.4.3            |         r3.2.2_0         366 KB
    r-hexbin-1.27.1            |         r3.2.2_0         779 KB
    r-htmltools-0.2.6          |         r3.2.2_2          84 KB
    r-httpuv-1.3.3             |         r3.2.2_0         332 KB
    r-irdisplay-0.3            |         r3.2.2_0          23 KB
    r-markdown-0.7.7           |         r3.2.2_1         104 KB
    r-matrix-1.2_2             |         r3.2.2_0         3.1 MB
    r-minqa-1.2.4              |         r3.2.2_1         105 KB
    r-munsell-0.4.2            |         r3.2.2_1         121 KB
    r-nlme-3.1_122             |         r3.2.2_0         2.0 MB
    r-plyr-1.8.3               |         r3.2.2_0         740 KB
    r-stringr-1.0.0            |         r3.2.2_0          78 KB
    r-zoo-1.7_12               |         r3.2.2_1         856 KB
    r-evaluate-0.8             |         r3.2.2_0          39 KB
    r-glmnet-2.0_2             |         r3.2.2_0         1.6 MB
    r-htmlwidgets-0.5          |         r3.2.2_0         646 KB
    r-matrixmodels-0.4_1       |         r3.2.2_0         249 KB
    r-mgcv-1.8_9               |         r3.2.2_0         1.8 MB
    r-rcppeigen-0.3.2.5.1      |         r3.2.2_0         1.6 MB
    r-reshape2-1.4.1           |         r3.2.2_1         102 KB
    r-scales-0.3.0             |         r3.2.2_0         209 KB
    r-shiny-0.12.2             |         r3.2.2_0         1.6 MB
    r-tidyr-0.3.1              |         r3.2.2_0         154 KB
    r-xts-0.9_7                |         r3.2.2_0         605 KB
    r-ggplot2-1.0.1            |         r3.2.2_0         2.6 MB
    r-irkernel-0.5             |         r3.2.2_1          71 KB
    r-knitr-1.11               |         r3.2.2_0         551 KB
    r-lme4-1.1_10              |         r3.2.2_0         4.4 MB
    r-quantreg-5.19            |         r3.2.2_0         1.8 MB
    r-rbokeh-0.2.2             |         r3.2.2_0         973 KB
    r-recommended-3.2.2        |         r3.2.2_0          707 B
    r-ttr-0.23_0               |         r3.2.2_0         266 KB
    r-pbkrtest-0.4_2           |         r3.2.2_2         204 KB
    r-quantmod-0.4_5           |         r3.2.2_0         475 KB
    r-rmarkdown-0.8.1          |         r3.2.2_0         1.1 MB
    r-car-2.1_0                |         r3.2.2_0         1.4 MB
    r-caret-6.0_62             |         r3.2.2_0         4.3 MB
    r-essentials-1.1           |         r3.2.2_0          927 B
    ------------------------------------------------------------
                                           Total:       103.0 MB

The following NEW packages will be INSTALLED:

    cairo:          1.12.18-6         
    glib:           2.43.0-2          
    harfbuzz:       0.9.35-6          
    libgcc:         4.8.5-1           
    ncurses:        5.9-4             
    nlopt:          2.4.2-1           
    pango:          1.36.8-3          
    pcre:           8.31-0            
    pixman:         0.32.6-0          
    r:              3.2.2-0           
    r-assertthat:   0.1-r3.2.2_1      
    r-base:         3.2.2-0           
    r-base64enc:    0.1_3-r3.2.2_0    
    r-bh:           1.58.0_1-r3.2.2_0 
    r-bitops:       1.0_6-r3.2.2_1    
    r-boot:         1.3_17-r3.2.2_0   
    r-car:          2.1_0-r3.2.2_0    
    r-caret:        6.0_62-r3.2.2_0   
    r-catools:      1.17.1-r3.2.2_2   
    r-chron:        2.3_47-r3.2.2_0   
    r-class:        7.3_14-r3.2.2_0   
    r-cluster:      2.0.3-r3.2.2_0    
    r-codetools:    0.2_14-r3.2.2_0   
    r-colorspace:   1.2_6-r3.2.2_0    
    r-data.table:   1.9.6-r3.2.2_0    
    r-dbi:          0.3.1-r3.2.2_2    
    r-dichromat:    2.0_0-r3.2.2_2    
    r-digest:       0.6.8-r3.2.2_2    
    r-dplyr:        0.4.3-r3.2.2_0    
    r-essentials:   1.1-r3.2.2_0      
    r-evaluate:     0.8-r3.2.2_0      
    r-foreach:      1.4.3-r3.2.2_0    
    r-foreign:      0.8_66-r3.2.2_0   
    r-formatr:      1.2.1-r3.2.2_0    
    r-ggplot2:      1.0.1-r3.2.2_0    
    r-glmnet:       2.0_2-r3.2.2_0    
    r-gtable:       0.1.2-r3.2.2_2    
    r-hexbin:       1.27.1-r3.2.2_0   
    r-highr:        0.5.1-r3.2.2_0    
    r-htmltools:    0.2.6-r3.2.2_2    
    r-htmlwidgets:  0.5-r3.2.2_0      
    r-httpuv:       1.3.3-r3.2.2_0    
    r-irdisplay:    0.3-r3.2.2_0      
    r-irkernel:     0.5-r3.2.2_1      
    r-iterators:    1.0.8-r3.2.2_0    
    r-jsonlite:     0.9.17-r3.2.2_0   
    r-kernsmooth:   2.23_15-r3.2.2_0  
    r-knitr:        1.11-r3.2.2_0     
    r-labeling:     0.3-r3.2.2_1      
    r-lattice:      0.20_33-r3.2.2_0  
    r-lazyeval:     0.1.10-r3.2.2_2   
    r-lme4:         1.1_10-r3.2.2_0   
    r-magrittr:     1.5-r3.2.2_1      
    r-maps:         3.0.0_2-r3.2.2_0  
    r-markdown:     0.7.7-r3.2.2_1    
    r-mass:         7.3_45-r3.2.2_0   
    r-matrix:       1.2_2-r3.2.2_0    
    r-matrixmodels: 0.4_1-r3.2.2_0    
    r-mgcv:         1.8_9-r3.2.2_0    
    r-mime:         0.4-r3.2.2_0      
    r-minqa:        1.2.4-r3.2.2_1    
    r-munsell:      0.4.2-r3.2.2_1    
    r-nlme:         3.1_122-r3.2.2_0  
    r-nloptr:       1.0.4-r3.2.2_1    
    r-nnet:         7.3_11-r3.2.2_0   
    r-pbkrtest:     0.4_2-r3.2.2_2    
    r-plyr:         1.8.3-r3.2.2_0    
    r-proto:        0.3_10-r3.2.2_1   
    r-quantmod:     0.4_5-r3.2.2_0    
    r-quantreg:     5.19-r3.2.2_0     
    r-r6:           2.1.1-r3.2.2_0    
    r-randomforest: 4.6_12-r3.2.2_0   
    r-rbokeh:       0.2.2-r3.2.2_0    
    r-rcolorbrewer: 1.1_2-r3.2.2_2    
    r-rcpp:         0.12.2-r3.2.2_0   
    r-rcppeigen:    0.3.2.5.1-r3.2.2_0
    r-recommended:  3.2.2-r3.2.2_0    
    r-repr:         0.3-r3.2.2_0      
    r-reshape2:     1.4.1-r3.2.2_1    
    r-rjsonio:      1.3_0-r3.2.2_1    
    r-rmarkdown:    0.8.1-r3.2.2_0    
    r-rpart:        4.1_10-r3.2.2_0   
    r-rzmq:         0.7.7-r3.2.2_3    
    r-scales:       0.3.0-r3.2.2_0    
    r-shiny:        0.12.2-r3.2.2_0   
    r-sparsem:      1.7-r3.2.2_0      
    r-spatial:      7.3_11-r3.2.2_0   
    r-stringi:      1.0_1-r3.2.2_0    
    r-stringr:      1.0.0-r3.2.2_0    
    r-survival:     2.38_3-r3.2.2_0   
    r-tidyr:        0.3.1-r3.2.2_0    
    r-ttr:          0.23_0-r3.2.2_0   
    r-uuid:         0.1_2-r3.2.2_0    
    r-xtable:       1.8_0-r3.2.2_0    
    r-xts:          0.9_7-r3.2.2_0    
    r-yaml:         2.1.13-r3.2.2_1   
    r-zoo:          1.7_12-r3.2.2_1   

The following packages will be UPDATED:

    decorator:      4.0.4-py35_0  --> 4.0.6-py35_0      
    nbconvert:      4.0.0-py35_0  --> 4.1.0-py35_0      
    pyzmq:          14.7.0-py35_1 --> 15.1.0-py35_0     

Fetching packages ...
libgcc-4.8.5-1 100% |#############################################################| Time: 0:00:02 324.59 kB/s
pcre-8.31-0.ta 100% |#############################################################| Time: 0:00:01 529.02 kB/s
pixman-0.32.6- 100% |#############################################################| Time: 0:00:01   2.17 MB/s
decorator-4.0. 100% |#############################################################| Time: 0:00:00 908.86 kB/s
pyzmq-15.1.0-p 100% |#############################################################| Time: 0:00:00   1.06 MB/s
cairo-1.12.18- 100% |#############################################################| Time: 0:00:00 841.32 kB/s
harfbuzz-0.9.3 100% |#############################################################| Time: 0:00:01 959.87 kB/s
pango-1.36.8-3 100% |#############################################################| Time: 0:00:01 586.38 kB/s
nbconvert-4.1. 100% |#############################################################| Time: 0:00:00 557.71 kB/s
r-base-3.2.2-0 100% |#############################################################| Time: 0:00:03   6.04 MB/s
r-3.2.2-0.tar. 100% |#############################################################| Time: 0:00:00 479.89 kB/s
r-assertthat-0 100% |#############################################################| Time: 0:00:00 246.80 kB/s
r-base64enc-0. 100% |#############################################################| Time: 0:00:00 276.67 kB/s
r-bh-1.58.0_1- 100% |#############################################################| Time: 0:00:02   2.61 MB/s
r-bitops-1.0_6 100% |#############################################################| Time: 0:00:00 251.95 kB/s
r-boot-1.3_17- 100% |#############################################################| Time: 0:00:02 267.46 kB/s
r-chron-2.3_47 100% |#############################################################| Time: 0:00:00 285.60 kB/s
r-cluster-2.0. 100% |#############################################################| Time: 0:00:00 548.84 kB/s
r-codetools-0. 100% |#############################################################| Time: 0:00:00  75.21 kB/s
r-colorspace-1 100% |#############################################################| Time: 0:00:00 478.59 kB/s
r-dbi-0.3.1-r3 100% |#############################################################| Time: 0:00:00 386.87 kB/s
r-dichromat-2. 100% |#############################################################| Time: 0:00:00 247.06 kB/s
r-digest-0.6.8 100% |#############################################################| Time: 0:00:00 276.47 kB/s
r-foreign-0.8_ 100% |#############################################################| Time: 0:00:00 350.46 kB/s
r-formatr-1.2. 100% |#############################################################| Time: 0:00:00 247.66 kB/s
r-gtable-0.1.2 100% |#############################################################| Time: 0:00:00 249.37 kB/s
r-highr-0.5.1- 100% |#############################################################| Time: 0:00:00 172.28 kB/s
r-iterators-1. 100% |#############################################################| Time: 0:00:00 365.33 kB/s
r-jsonlite-0.9 100% |#############################################################| Time: 0:00:01 768.86 kB/s
r-kernsmooth-2 100% |#############################################################| Time: 0:00:00 268.39 kB/s
r-labeling-0.3 100% |#############################################################| Time: 0:00:00 248.73 kB/s
r-lattice-0.20 100% |#############################################################| Time: 0:00:01 704.15 kB/s
r-lazyeval-0.1 100% |#############################################################| Time: 0:00:00 270.06 kB/s
r-magrittr-1.5 100% |#############################################################| Time: 0:00:00 336.75 kB/s
r-maps-3.0.0_2 100% |#############################################################| Time: 0:00:02   1.64 MB/s
r-mass-7.3_45- 100% |#############################################################| Time: 0:00:01 780.02 kB/s
r-mime-0.4-r3. 100% |#############################################################| Time: 0:00:00 264.31 kB/s
r-nloptr-1.0.4 100% |#############################################################| Time: 0:00:01 720.61 kB/s
r-nnet-7.3_11- 100% |#############################################################| Time: 0:00:00 291.69 kB/s
r-proto-0.3_10 100% |#############################################################| Time: 0:00:02 189.07 kB/s
r-r6-2.1.1-r3. 100% |#############################################################| Time: 0:00:00 375.92 kB/s
r-randomforest 100% |#############################################################| Time: 0:00:00 205.54 kB/s
r-rcolorbrewer 100% |#############################################################| Time: 0:00:00 283.86 kB/s
r-rcpp-0.12.2- 100% |#############################################################| Time: 0:00:02 828.52 kB/s
r-repr-0.3-r3. 100% |#############################################################| Time: 0:00:00 313.87 kB/s
r-rjsonio-1.3_ 100% |#############################################################| Time: 0:00:02 392.81 kB/s
r-rpart-4.1_10 100% |#############################################################| Time: 0:00:01 441.44 kB/s
r-rzmq-0.7.7-r 100% |#############################################################| Time: 0:00:00 301.02 kB/s
r-sparsem-1.7- 100% |#############################################################| Time: 0:00:02 344.45 kB/s
r-spatial-7.3_ 100% |#############################################################| Time: 0:00:00 432.29 kB/s
r-stringi-1.0_ 100% |#############################################################| Time: 0:00:02   3.82 MB/s
r-survival-2.3 100% |#############################################################| Time: 0:00:01   2.35 MB/s
r-uuid-0.1_2-r 100% |#############################################################| Time: 0:00:00 245.38 kB/s
r-xtable-1.8_0 100% |#############################################################| Time: 0:00:00 574.62 kB/s
r-yaml-2.1.13- 100% |#############################################################| Time: 0:00:00 319.75 kB/s
r-catools-1.17 100% |#############################################################| Time: 0:00:00 362.01 kB/s
r-class-7.3_14 100% |#############################################################| Time: 0:00:00 257.90 kB/s
r-data.table-1 100% |#############################################################| Time: 0:00:01   1.16 MB/s
r-dplyr-0.4.3- 100% |#############################################################| Time: 0:00:01   1.09 MB/s
r-foreach-1.4. 100% |#############################################################| Time: 0:00:00 505.62 kB/s
r-hexbin-1.27. 100% |#############################################################| Time: 0:00:01 405.93 kB/s
r-htmltools-0. 100% |#############################################################| Time: 0:00:00 381.85 kB/s
r-httpuv-1.3.3 100% |#############################################################| Time: 0:00:00 465.43 kB/s
r-irdisplay-0. 100% |#############################################################| Time: 0:00:00  80.32 kB/s
r-markdown-0.7 100% |#############################################################| Time: 0:00:00 379.62 kB/s
r-matrix-1.2_2 100% |#############################################################| Time: 0:00:01   1.95 MB/s
r-minqa-1.2.4- 100% |#############################################################| Time: 0:00:00 298.59 kB/s
r-munsell-0.4. 100% |#############################################################| Time: 0:00:00 341.88 kB/s
r-nlme-3.1_122 100% |#############################################################| Time: 0:00:01   1.24 MB/s
r-plyr-1.8.3-r 100% |#############################################################| Time: 0:00:01 685.02 kB/s
r-stringr-1.0. 100% |#############################################################| Time: 0:00:00 280.56 kB/s
r-zoo-1.7_12-r 100% |#############################################################| Time: 0:00:01 588.23 kB/s
r-evaluate-0.8 100% |#############################################################| Time: 0:00:00 271.71 kB/s
r-glmnet-2.0_2 100% |#############################################################| Time: 0:00:02 553.15 kB/s
r-htmlwidgets- 100% |#############################################################| Time: 0:00:00 762.62 kB/s
r-matrixmodels 100% |#############################################################| Time: 0:00:00 508.65 kB/s
r-mgcv-1.8_9-r 100% |#############################################################| Time: 0:00:02 671.17 kB/s
r-rcppeigen-0. 100% |#############################################################| Time: 0:00:01 866.65 kB/s
r-reshape2-1.4 100% |#############################################################| Time: 0:00:00 263.76 kB/s
r-scales-0.3.0 100% |#############################################################| Time: 0:00:00 397.18 kB/s
r-shiny-0.12.2 100% |#############################################################| Time: 0:00:04 379.67 kB/s
r-tidyr-0.3.1- 100% |#############################################################| Time: 0:00:00 436.02 kB/s
r-xts-0.9_7-r3 100% |#############################################################| Time: 0:00:01 577.09 kB/s
r-ggplot2-1.0. 100% |#############################################################| Time: 0:00:01   1.71 MB/s
r-irkernel-0.5 100% |#############################################################| Time: 0:00:00 337.23 kB/s
r-knitr-1.11-r 100% |#############################################################| Time: 0:00:00 714.83 kB/s
r-lme4-1.1_10- 100% |#############################################################| Time: 0:00:01   2.52 MB/s
r-quantreg-5.1 100% |#############################################################| Time: 0:00:01   1.33 MB/s
r-rbokeh-0.2.2 100% |#############################################################| Time: 0:00:01 988.22 kB/s
r-recommended- 100% |#############################################################| Time: 0:00:00 179.43 kB/s
r-ttr-0.23_0-r 100% |#############################################################| Time: 0:00:00 477.84 kB/s
r-pbkrtest-0.4 100% |#############################################################| Time: 0:00:00 405.81 kB/s
r-quantmod-0.4 100% |#############################################################| Time: 0:00:00 680.45 kB/s
r-rmarkdown-0. 100% |#############################################################| Time: 0:00:01   1.12 MB/s
r-car-2.1_0-r3 100% |#############################################################| Time: 0:00:01   1.17 MB/s
r-caret-6.0_62 100% |#############################################################| Time: 0:00:01   2.47 MB/s
r-essentials-1 100% |#############################################################| Time: 0:00:00  27.13 kB/s
Extracting packages ...
Extracting packages ...
[      COMPLETE      ]|################################################################################| 100%
Unlinking packages ...
[      COMPLETE      ]|################################################################################| 100%
Linking packages ...
[      COMPLETE      ]|################################################################################| 100%
```


## Possible errors

### `LOCKERROR`

If you see a `LOCKERROR`, this is `conda` being extra paranoid and cowardly not doing anything if it sees that there seems to be some other `conda` process going on. Follow the instructions in the text and do `conda clean --lock`

```
    LOCKERROR: It looks like conda is already doing something.
    The lock /home/ucsd-train01/anaconda3/pkgs/.conda_lock-34447 was found. Wait for it to finish before continuing.
    If you are sure that conda is not running, remove it and try again.
    You can also use: $ conda clean --lock
```
