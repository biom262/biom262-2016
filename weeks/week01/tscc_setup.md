# TSCC

[TSCC](http://rci.ucsd.edu/computing/index.html) houses the 640-core supercomputer as part of a resource sharing
system which allows researchers to perform calculations and experiments when they need extra
computing power.

The main contacts for questions about TSCC is the
[TSCC users](tscc-l@mailman.ucsd.edu) mailing lists. The main contact for problems with TSCC is (Jim Hayes)[jhayes@sdsc.edu].


.. _TSCC: http://rci.ucsd.edu/computing/index.html
.. _dry lab: dryyeo-l@googlegroups.com
.. _TSCC users: tscc-l@mailman.ucsd.edu
.. _Jim Hayes: jhayes@sdsc.edu

## My First Supercomputer Login Session

Your first login session will include some of the following commands,
which will familiarize you with the cluster, teach you how to do some useful
tasks on the queue, and help you set up a common directory structure shared
by everyone in the lab.

### 1. Locate your terminal program

Mac: Terminal

PC: Putty for SSH
- Leave blank for shashank to fill out

Color coding for files/ls - "Homebrew" theme

**Emily can you write this?**

#### Mac

Search for "Terminal" in spotlight

#### Windows - Shashank fill in here

Download [putty](http://putty.com) **shashank fill in the rest**

#### GNU/BSD/Linux

Open the Terminal program

### 2. Log in to TSCC

In your terminal, type the following (you'll need to replace `username` with your actual username)

```
ssh username@tscc.sdsc.edu
```

### 3. Organize your home directory

Organize your home directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an organized ``home`` directory structure following a common
template, so others can find your scripts, workflows,
and even final results/papers!  Do not store actual data in your home
directory as is is limited to 100 GB only.



Link your scratch directory to your home
++++++++++++++++++++++++++++++++++++++++

The "``scratch``" storage on TSCC is for temporary (after 90 days it gets
purged) storage. It's very useful for storing intermediate files,
and outputs from compute jobs because the data there is stored on
solid-state drives (SSDs, currently 300TB) which have incredibly fast
read-write speeds, which is perfect for outputs from alignment algorithms.
It can be annoying to go back and forth between your scratch directory,
so it's convenient to have a link to your scratch from home,
which you can make like this:

.. code::

   ln -s /oasis/tscc/scratch/$USER $HOME/scratch

.. note::

    This is virtually unlimited temporary storage space,
    designed for heavy I/O.  Aside from common reference files (e.g.
    Genomes, GENCODE, etc.) this should be the only space that you can
    read/write to from your scripts/workflows! The '''parallel''' throughput
    of this storage is 100 GB/s (e.g. 10 tasks can each read/write at 10
    GB/s at the same time)

.. warning::

    Anything saved here is subject to deletion without warning after 3 months
    or less of storage. In particular, the large ``.sam`` and ``.bam`` files
    can get deleted, even though their ``.done`` files (produced by the
    GATK Queue RNA-seq pipeline as a placeholder) will still exist, and they
    will seem done to the pipeline. To avoid lost data, here are a few steps:

    1. Keep your metadata sample/cell counts are in your ``$HOME/projects`` or
       ``/projects/ps-yeolab/$USER`` folder, which don't get purged
       periodically.
    2. Delete ``*.done`` files when re-rerunning a partially eroded pipeline
       run.
    3. Use this recursive touch command to "refresh" the decay clock on your
       files before important meetings and re-analysis steps:

       .. code::

            cd important_scratch_dir
            find . | xargs touch

Create workflow and projects folders
++++++++++++++++++++++++++++++++++++

Create ``~/workflows`` for your personal bash, makefile, queue, and so on,
scripts, before you add them to gscripts, and ``~/projects`` for your
projects to organize figures, notebooks, final results, and even manuscripts.

.. code::

    mkdir ~/workflows ~/projects

Here's an example project directory structure:

.. code::

    $ ls -lha /home/gpratt/projects/fox2_iclip/
    total 9.5K
    drwxr-xr-x  2 gpratt yeo-group  5 Sep 16  2013 .
    drwxr-xr-x 40 gpratt yeo-group 40 Nov 24 12:20 ..
    lrwxrwxrwx  1 gpratt yeo-group 49 Aug 21  2013 analysis -> /home/gpratt/scratch/projects/fox2_iclip/analysis
    lrwxrwxrwx  1 gpratt yeo-group 45 Aug 21  2013 data -> /home/gpratt/scratch/projects/fox2_iclip/data
    lrwxrwxrwx  1 gpratt yeo-group 50 Aug 21  2013 scripts -> /home/gpratt/processing_scripts/fox2_iclip/scripts

.. note::

    Notice that all of these are soft-links to either ``~/scratch`` or some
    other processing scripts.

Let us see your stuff
+++++++++++++++++++++

Make everything readable by other yeo lab members and restrict access from
other users (per HIPAA/HITECH requirements)

.. code::

    chmod -R g+r ~/
    chmod -R g+r ~/scratch/
    chmod -R o-rwx ~/
    chmod -R o-rwx ~/scratch/

But ``git`` will get mad at you if your ~/.ssh keys private keys are visible
by others, so make them visible to only you via:

.. code::

    chmod -R go-rwx ~/.ssh/

In the end, your '''home''' directory should look something like this:

.. code::

    $ ls -l $HOME
    lrwxrwxrwx  1 bkakarad yeo-group    29 Jun 24  2013 scratch -> /oasis/tscc/scratch/bkakarad/
    drwxr-x---+ 2 bkakarad yeo-group     2 Jun 24  2013 gscripts
    drwxr-x---+ 3 bkakarad yeo-group     3 Jun 24  2013 projects
    drwxr-x---+ 2 bkakarad yeo-group     2 Jun 24  2013 workflows

### 4. Download Anaconda package manager

We will be using Anaconda is a Python distribution, and includes `conda` which is a command-line package manager that we will use with both R and Python.

```
# this will take a while ...
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-2.4.1-Linux-x86_64.sh
```

```
bash Anaconda3-2.4.1-Linux-x86_64.sh
```


### 5. Create a biom262-specific "environment"

"Environments" can be thought of separate sandboxes on a playground. We'll create a BIOM262-specific sandbox which will contain programs that may conflict with existing programs. For example, let's say you need the `bowtie` aligner for this class, but it's an older version than the one you want. With environments, you can have BOTH versions of the `bowtie` aligner by storing the programs in different folders, and the different environments will know to look in one folder or another.


### 6. Submitting and managing compute jobs on TSCC

### 7. Jupyter notebooks on TSCC



TSCC
====

TSCC_ houses our 640-core supercomputer as part of a condo resource sharing
system which allows other researchers (mostly bioinformaticians from the
Ideker, Ren, Zhang labs) to use our portion for their jobs (with an 8 hour
time limit) which allows us to use their portions when we need extra
computing power. We lead the pack in terms of pure crunching power,
with the Ideker lab in close second place with 512 cores. But they have 2x
the RAM per core for jobs that require lots of memory,
so our purchases are complimentary and sharing is encouraged.

The main contacts for questions about TSCC are the `dry lab`_ and
`TSCC users`_ mailing lists. The main contact for problems with TSCC is `Jim Hayes`_

Important rules
---------------

.. warning::

    1. All sequencing data is stored in the ``/projects/ps-yeolab/seqdata`` folder
    2. The folder ``seqdata`` is intended as permanent storage and no folders
       or files there should ever be deleted
    3. Do not process data in ``seqdata``. Use the directory structure
       described in `Organize your home directory`_ to create a ``scratch``
       folder for all data processing.

First Steps
-----------

Your first login session should include some of the following commands,
which will familiarize you with the cluster, teach you how to do some useful
tasks on the queue, and help you set up a common directory structure shared
by everyone in the lab.

Locate your terminal program
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mac: Terminal

PC: Putty for SSH
- Leave blank for shashank to fill out

Color coding for files/ls - "Homebrew" theme


Log on!
~~~~~~~

First, log in to TSCC!

# Maybe

.. code::

    ssh YOUR_TSCC_USERNAME@tscc-login2.sdsc.edu

TSCC has two login nodes, ``login1`` and ``login2`` for load-balancing (i.e.
so if you just log on to ``tscc.sdsc.edu``, it'll choose whichever login
node is less occupied. We're logging in to a specific node because then
we'll always have our screen session on the same node) This is logging
specifically on to ``login2``. You can do ``login1`` if you like, as well,
to balance it out :)

Start a screen session
~~~~~~~~~~~~~~~~~~~~~~

Screen_ is an awesome tool which allows you to have multiple "tabs" open in
the same login session, and you can easily transition between screens. Plus,
they're persistent, so you can leave something running in a screen session,
log out of TSCC, and it will still be running! Amazing! If you have
suggestions of things to add to this ``.screenrc``, feel free to make a pull
request on Olga's rcfiles_ github repo.

To get a nice status bar at the bottom of your terminal window, get this
``.screenrc`` file:

.. code::

    cd
    wget https://raw.githubusercontent.com/olgabot/rcfiles/master/.screenrc

.. note::

    The control letter is ``j``, not ``a`` in the documentation above,
    so for example to create a new window, do ``Ctrl-j c`` and to kill the
    current window, do ``Ctrl-j k``. Do ``Ctrl-j j`` to switch between
    windows, and ``Ctrl-j #``, where # is some window number,
    to switch to a numbered tab specifically (e.g. ``Ctrl-j 2`` to switch to
    tab number 2.

This ``.screenrc`` adds a status bar at the bottom of your screen, like this:

.. image:: screen_status.png

Now to start a screen session do:

.. code::

    screen

If you're re-logging in and you have an old screen session,
do this to "re-attach" the screen window.

.. code::

    screen -x

Every time you log in to TSCC, you'll want to reattach the screens from
before, so the first step I always take when I log in to TSCC is exactly
that, ``screen -x``.

Get ``gscripts`` access to software
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

0. Before you're able to clone the gscripts github repo, you'll need to add
   your ssh keys on TSCC to your Github account. Follow `Github's instructions
   for generating SSH keys`_.

1. First, clone the ``gscripts`` github repo to your home directory on TSCC
   (this assumes you've already created a github account).

.. code::

    # <on TSCC>
    cd
    git clone http://github.com/YeoLab/gscripts

2. Add this line to the **end** of your ``~/.bashrc`` file (using either
   ``emacs`` or ``vi``/``vim``, your choice)

.. code::

    source ~/gscripts/bashrc/tscc_bash_settings_current

.. note::

    Make sure to add ``source ~/gscripts/bashrc/tscc_bash_settings_current``
    to your ``~/.bashrc`` file so that it always loads up the correct yeolab
    environment variables!

3. "source the ``.bashrc`` file so you load all the convenient environment
    variables we've created.

.. code::

    source ~/.bashrc

Make a virtual environment on TSCC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On TSCC, the easiest way to create a virtual evironment (aka ``virtualenv``)
is by making one off of the ``base`` environment, which already has a bunch of
modules that we use all the time (``numpy``, ``scipy``, ``matplotlib``, ``pandas``, ``scikit-learn``, ``ipython``, the list goes on). Here's how you do it:

.. note::

    The command ``$USER`` is meant to be literal, meaning you can exactly copy
    the below command, and TSCC will create an environment with your username.
    If you don't believe me, compare the output of:

    .. code::

        echo USER

    to the output of:

    .. code::

        echo $USER

    The second one should output your TSCC username, because the ``$`` dollar
    sign indicates to the shell that you're asking for the variable ``$USER``,
    not the literal word "USER".

.. code::

    conda create --clone base --name $USER

.. note::
    You can also create an environment from scratch using ``conda`` to install
    all the Anaconda Python packages, and then using ``pip`` in the environment
    to install the remaining packages, like so:

    .. code::

        conda create --yes --name ENVIRONMENT_NAME pip numpy scipy cython matplotlib nose six scikit-learn ipython networkx pandas tornado statsmodels setuptools pytest pyzmq jinja2 pyyaml pymongo biopython markupsafe seaborn joblib semantic_version
        source activate ENVIRONMENT_NAME
        conda install --yes --channel https://conda.binstar.org/daler pybedtools
        conda install --yes --channel https://conda.binstar.org/kyleabeauchamp fastcluster
        pip install gspread brewer2mpl husl gffutils matplotlib-venn HTSeq misopy
        pip install https://github.com/YeoLab/clipper/tarball/master
        pip install https://github.com/YeoLab/gscripts/tarball/master
        pip install https://github.com/YeoLab/flotilla/tarball/master

    These commands is how the ``base`` environment was created.

Then activate your environment with

.. code::

    source activate $USER

You'll probably stay in this environment all the time.

.. warning::

    Make sure to add ``source activate $USER`` to your ``~/.bashrc`` file!
    Then you will always be in your environment

If you need to switch to another environment, then exit your environment with:

.. code::

    source deactivate

.. note::

    Now that you've created your own environment, go to your gscripts folder
    and install your own personal gscripts, to make sure it's the most updated
    version.

    .. code::

        cd ~/gscripts
        pip install .  # The "." means install "this," as in "this folder where I am"

Add the location of ``GENOME`` to your ``~/.bashrc``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To run the analysis pipeline, you will need to specify where the genomes are
on TSCC, and you can do this by adding this line to your ``~/.bashrc``:

.. code::

    GENOME=/projects/ps-yeolab/genomes

Organize your home directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an organized ``home`` directory structure following a common
template, so others can find your scripts, workflows,
and even final results/papers!  Do not store actual data in your home
directory as is is limited to 100 GB only.



Link your scratch directory to your home
++++++++++++++++++++++++++++++++++++++++

The "``scratch``" storage on TSCC is for temporary (after 90 days it gets
purged) storage. It's very useful for storing intermediate files,
and outputs from compute jobs because the data there is stored on
solid-state drives (SSDs, currently 300TB) which have incredibly fast
read-write speeds, which is perfect for outputs from alignment algorithms.
It can be annoying to go back and forth between your scratch directory,
so it's convenient to have a link to your scratch from home,
which you can make like this:

.. code::

   ln -s /oasis/tscc/scratch/$USER $HOME/scratch

.. note::

    This is virtually unlimited temporary storage space,
    designed for heavy I/O.  Aside from common reference files (e.g.
    Genomes, GENCODE, etc.) this should be the only space that you can
    read/write to from your scripts/workflows! The '''parallel''' throughput
    of this storage is 100 GB/s (e.g. 10 tasks can each read/write at 10
    GB/s at the same time)

.. warning::

    Anything saved here is subject to deletion without warning after 3 months
    or less of storage. In particular, the large ``.sam`` and ``.bam`` files
    can get deleted, even though their ``.done`` files (produced by the
    GATK Queue RNA-seq pipeline as a placeholder) will still exist, and they
    will seem done to the pipeline. To avoid lost data, here are a few steps:

    1. Keep your metadata sample/cell counts are in your ``$HOME/projects`` or
       ``/projects/ps-yeolab/$USER`` folder, which don't get purged
       periodically.
    2. Delete ``*.done`` files when re-rerunning a partially eroded pipeline
       run.
    3. Use this recursive touch command to "refresh" the decay clock on your
       files before important meetings and re-analysis steps:

       .. code::

            cd important_scratch_dir
            find . | xargs touch

Create workflow and projects folders
++++++++++++++++++++++++++++++++++++

Create ``~/workflows`` for your personal bash, makefile, queue, and so on,
scripts, before you add them to gscripts, and ``~/projects`` for your
projects to organize figures, notebooks, final results, and even manuscripts.

.. code::

    mkdir ~/workflows ~/projects

Here's an example project directory structure:

.. code::

    $ ls -lha /home/gpratt/projects/fox2_iclip/
    total 9.5K
    drwxr-xr-x  2 gpratt yeo-group  5 Sep 16  2013 .
    drwxr-xr-x 40 gpratt yeo-group 40 Nov 24 12:20 ..
    lrwxrwxrwx  1 gpratt yeo-group 49 Aug 21  2013 analysis -> /home/gpratt/scratch/projects/fox2_iclip/analysis
    lrwxrwxrwx  1 gpratt yeo-group 45 Aug 21  2013 data -> /home/gpratt/scratch/projects/fox2_iclip/data
    lrwxrwxrwx  1 gpratt yeo-group 50 Aug 21  2013 scripts -> /home/gpratt/processing_scripts/fox2_iclip/scripts

.. note::

    Notice that all of these are soft-links to either ``~/scratch`` or some
    other processing scripts.

Let us see your stuff
+++++++++++++++++++++

Make everything readable by other yeo lab members and restrict access from
other users (per HIPAA/HITECH requirements)

.. code::

    chmod -R g+r ~/
    chmod -R g+r ~/scratch/
    chmod -R o-rwx ~/
    chmod -R o-rwx ~/scratch/

But ``git`` will get mad at you if your ~/.ssh keys private keys are visible
by others, so make them visible to only you via:

.. code::

    chmod -R go-rwx ~/.ssh/

In the end, your '''home''' directory should look something like this:

.. code::

    $ ls -l $HOME
    lrwxrwxrwx  1 bkakarad yeo-group    29 Jun 24  2013 scratch -> /oasis/tscc/scratch/bkakarad/
    drwxr-x---+ 2 bkakarad yeo-group     2 Jun 24  2013 gscripts
    drwxr-x---+ 3 bkakarad yeo-group     3 Jun 24  2013 projects
    drwxr-x---+ 2 bkakarad yeo-group     2 Jun 24  2013 workflows

Share your Dropbox account for easy figure syncing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Installing and upgrading Python packages
----------------------------------------

To install Python packages first try ``conda install``:

.. code::

    conda install <package name>

If there is no package in conda, then (and ONLY then) try `pip`:

.. code::

    pip install <package name>

To upgrade packages, do:

(using ``conda``)

.. code::

    conda update <package name>

(using ``pip``)

.. code::

    pip install -U <package name>

Installing R packages (beta!)
----------------------------

You can also use ``conda`` to install ``R`` and ``R`` packages. Currently, you
need to reference one of Anaconda's developer's channel ``asmeurer`` to install
it. Here is the command to install R in your environment. You can see the list
of `R packages he's added so far`_.

.. code::

    conda install -c asmeurer r


Submitting and managing compute jobs on TSCC
--------------------------------------------

Submit jobs
~~~~~~~~~~~

To submit a script that you wrote, in this case called ``myscript.sh``,
to TSCC, do:

.. code::

    qsub -q home-yeo -l nodes=1:ppn=2 -l walltime=0:30:00 myscript.sh

Submit interactive jobs
~~~~~~~~~~~~~~~~~~~~~~~

To submit interactive jobs, do:

.. code::

    qsub -I -q home-yeo -l nodes=1:ppn=2 -l walltime=0:30:00

Submit jobs to ``home-scrm``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To submit to the ``home-scrm`` queue, add ``-W group_list=scrm-group`` to
your ``qsub`` command:

.. code::

    qsub -I -l walltime=0:30:00 -q home-scrm -W group_list=scrm-group


Submitting many jobs at once
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have a bunch of commands you want to run at once,
you can use this script to submit them all at once. In the next example,
``commands.sh`` is a file has the commands you want on their own line,
i.e. one command per line.

.. code::

    java -Xms512m -Xmx512m -jar /home/yeo-lab/software/gatk/dist/Queue.jar \
    -S ~/gscripts/qscripts/do_stuff.scala --input commands.sh -run -qsub \
    -jobQueue <queue> -jobLimit <n> --ncores <n> --jobname <name> -startFromScratch

This runs a scala job that submits sub-jobs to the PBS queue under name you
fill in where <name> now sits as a placeholder.

Check job status, aka "why is my job stuck?"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check the status of your jobs:

.. code::

    qme

.. note:: This will only work if you have followed instructions and have
``source``'d the ``~/gscripts/tscc_bash_settings_current``  :)

``qme`` outputs,

.. code::

    (olga)[obotvinnik@tscc-login2 ~]$ qme

    tscc-mgr.sdsc.edu:
                                                                                      Req'd    Req'd       Elap
    Job ID                  Username    Queue    Jobname          SessID  NDS   TSK   Memory   Time    S   Time
    ----------------------- ----------- -------- ---------------- ------ ----- ------ ------ --------- - ---------
    2006527.tscc-mgr.local  obotvinnik  home-yeo STDIN             35367     1     16    --   04:00:00 R  02:35:36
    2007542.tscc-mgr.local  obotvinnik  home-yeo STDIN              6168     1      1    --   08:00:00 R  00:28:08
    2007621.tscc-mgr.local  obotvinnik  home-yeo STDIN               --      1     16    --   04:00:00 Q       --

Check job status of array jobs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check the status of your array jobs, you need to specify ``-t`` to see the
status of the individual array pieces.

.. code::

    qstat -t


Killing jobs
~~~~~~~~~~~~

If you have a job you want to stop, kill it with ``qdel JOBID``, e.g.

.. code::

    qdel 2006527

Kill an array job
~~~~~~~~~~~~~~~~~

If the job is an array job, you'll need to add brackets, like this:

.. code::

    qdel 2006527[]


Kill all your jobs
~~~~~~~~~~~~~~~~~~

To kill all the jobs that you've submitted, do:

.. code::

    qdel $(qselect -u $USER)


Which queue do I submit to? (check status of queues)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check the status of the queue (so you know which queues to NOT submit to!)

.. code::

    qstat -q

Example output is,

.. code::

    (olga)[obotvinnik@tscc-login2 ~]$ qstat -q

    server: tscc-mgr.local

    Queue            Memory CPU Time Walltime Node  Run Que Lm  State
    ---------------- ------ -------- -------- ----  --- --- --  -----
    home-dkeres        --      --       --      --    2   0 --   E R
    home-komunjer      --      --       --      --    0   0 --   E R
    home-ong           --      --       --      --    2   0 --   E R
    home-tg            --      --       --      --    0   0 --   E R
    home-yeo           --      --       --      --    3   1 --   E R
    home-visres        --      --       --      --    0   0 --   E R
    home-mccammon      --      --       --      --   15  29 --   E R
    home-scrm          --      --       --      --    1   0 --   E R
    hotel              --      --    168:00:0   --  232  26 --   E R
    home-k4zhang       --      --       --      --    0   0 --   E R
    home-kkey          --      --       --      --    0   0 --   E R
    home-kyang         --      --       --      --    2   1 --   E R
    home-jsebat        --      --       --      --    1   0 --   E R
    pdafm              --      --    72:00:00   --    1   0 --   E R
    condo              --      --    08:00:00   --   18   6 --   E R
    gpu-hotel          --      --    336:00:0   --    0   0 --   E R
    glean              --      --       --      --   24  75 --   E R
    gpu-condo          --      --    08:00:00   --   16  36 --   E R
    home-fpaesani      --      --       --      --    4   2 --   E R
    home-builder       --      --       --      --    0   0 --   E R
    home               --      --       --      --    0   0 --   E R
    home-mgilson       --      --       --      --    0   4 --   E R
    home-eallen        --      --       --      --    0   0 --   E R
                                                   ----- -----
                                                     321   180

So right now is not a good time to submit to the ``hotel`` queue,
since it has a bunch of both running and queued jobs!

Show available "Service Units"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

List the available Service Units (1 SU = 1 core*hour) ... for a quick ego
boost. Also note that our supercomputer is separated in two: yeo-group and
scrm-group, but the total balance is 5.29 million SU, just enough secure us
the top honors :-)

.. code::

    gbalance | sort -nrk 3 | head

    Id Name                 Amount  Reserved Balance CreditLimit Available
    -- -------------------- ------- -------- ------- ----------- ---------
    19 tideker-group        5211035    27922 5183113           0   5183113
    82 yeo-group            3262925        0 3262925           0   3262925
    81 scrm-group           2039328        0 2039328           0   2039328
    14 mgilson-group         663095   208000  455095           0    455095
    73 nanosprings-ucm       650000        0  650000           0    650000
    17 kkey-group            635056     7104  627952           0    627952
    16 k4zhang-group         534430        0  534430           0    534430

List the available TORQUE queues, for a quick boost in motivation!

.. code::

    qstat -q

    Queue            Memory CPU Time Walltime Node  Run Que Lm  State
    ---------------- ------ -------- -------- ----  --- --- --  -----
    home-tideker       --      --       --       16   1   0 --   E R
    home-visres        --      --       --        1   0   0 --   E R
    hotel              --      --    72:00:00   --   25  18 --   E R
    home-k4zhang       --      --       --        4  21   0 --   E R
    home-kkey          --      --       --        5   0   0 --   E R
    pdafm              --      --    72:00:00   --    0   0 --   E R
    condo              --      --    08:00:00   --    0   0 --   E R
    glean              --      --       --      --    0   0 --   E R
    home-builder       --      --       --        8   0   0 --   E R
    home               --      --       --      --    0   0 --   E R
    home-ewyeo         --      --       --       15   0   0 --   E R
    home-mgilson       --      --       --        8   0   0 --   E R
                                               ----- -----
                                                  47    18

Show available processors
~~~~~~~~~~~~~~~~~~~~~~~~~

To show available processors, do

.. code::

    showbf

Show specs of all nodes
~~~~~~~~~~~~~~~~~~~~~~~

.. code::

    pbsnodes -a


IPython notebooks on TSCC
-------------------------

This has two sections: Setup and Running. They should be done in order :)

Setup IPython notebooks on TSCC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. First, on your personal computer,
   you will want to set up
   `passwordless ssh`_ from your laptop to TSCC. For reference, ``a@A`` is you from your laptop, and ``b@B`` is TSCC. So everywhere you see ``b@B``, replace that with ``yourusername@tscc.sdsc.edu``. For ``a@A``, since your laptop likely doesn't have a fixed IP address or a way to log in to it, you don't need to worry about replacing it. Instead, use ``a@A`` as a reference point for whether you should be doing the command from your laptop (``a@A``) or TSCC (``b@B``)

2. To set up IPython notebooks on TSCC, you will want to add some ``alias``
   variables to your ``~/.bash_profile`` (for Mac) or ``~/.bashrc`` (for Linux)

.. code::

    IPYNB_PORT=[some number above 1024]
    alias tscc='ssh obotvinnik@tscc-login2.sdsc.edu'
    


This way, I can just type ``tscc`` and log onto ``tscc-login2``
**specifically**. It is important for IPython notebooks that you always log
on to the same node. You can use ``tscc-login1`` instead, too,
this is just what I have set up. Just replace my login name
("``obotvinnik``") with yours.

2. To activate all the commands you just added, on your laptop, type ``source ~/.bash_profile``. (``source`` is a command which will run all the lines in the file you gave it, i.e. here it will assign the variable ``IPYNB_PORT`` to the value you gave it, and run the ``alias`` command so you only have to type ``tscc`` to log in to TSCC)

2. Next, type ``tscc`` and log on to the server.

3. On TSCC, add these lines to your ``~/.bashrc`` file.

   .. code::

       IPYNB_PORT=same number as the above IPYNB_PORT from your laptop
       alias ipynb="ipython notebook --no-browser --port $IPYNB_PORT &"
       alias sshtscc="ssh -NR $IPYNB_PORT:localhost:$IPYNB_PORT tscc-login2 &"

   Notice that in ``sshtscc``, I use the same port as I logged in to,
   `tscc-login2`. The ampersands "`&`" at the end of the lines tell the computer
   to run these processes in the background, which is super useful.
   
4. You'll need to run ``source ~/.bashrc`` again on TSCC, so the ``$IPYNB_PORT`` variable, and ``ipynb``, ``sshtscc`` aliases are available.

5. Set up passwordless ssh between the compute nodes and TSCC with:

.. code::

    cat .ssh/id_rsa.pub >> .ssh/authorized_keys

6. Back on your home laptop, edit your `~/.bash_profile` on macs,
   `~/.bashrc` for other unix machines to add the line:

   .. code::

       alias tunneltscc="ssh -NL $IPYNB_PORT\:localhost:$IPYNB_PORT obotvinnik@tscc-login2.sdsc.edu &"

   Make sure to replace "``obotvinnik``" with your TSCC login :) It is
   also important that these are double-quotes and not single-quotes, because the double-quotes evaluate the ``$IPYNB_PORT`` to the number you chose, e.g. ``4000``, whereas the single-quotes will keep it as the letters ``$IPYNB_PORT``.

Run IPython Notebooks on TSCC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that you have everything configured, you can run IPython notebooks on TSCC!
Here are the steps to follow.

1. Log on to TSCC
4. Now that you have those set up, start up a ``screen`` session, which allows you to have something running continuously, without being logged in.

.. code::

    screen -x

.. note::
   If this gives you an error saying "There is no screen to be attached"
   then you need to run plain old ``screen`` (no ``-x``) first.

   If this gives you an error saying you need to pick one session, make
   life easier for yourself and pick one to kill all the windows in,
   (using ``Ctrl-j K`` if you're using the ``.screenrc`` that I recommended
   earlier, otherwise the default is ``Ctrl-a K``). Once you've killed all
   screen sessions except for one, you can run ``screen -x`` with abandon,
   and it will connect you to the only one you have open.

2. In this ``screen`` session, now request an interactive job, e.g.:

.. code::

    qsub -I -l walltime=2:00:00 -q home-yeo -l nodes=1:ppn=2

3. Wait for the job to start.

4. Run your TSCC-specific aliases on the compute node:

.. code::

    ipynb
    sshtscc

4. **Back on your laptop**, now run your tunneling command:

.. code::

    tunneltscc

5. Open up ``http://localhost:[YOUR IPYNB PORT]`` on your browser.


Random notes
------------

Software goes in ``/projects/ps-yeolab/software``

Make sure to recursively set group read/write permissions to the software
directory so others can use and update the common software, using:

.. code::

    chmod ug+rw /projects/ps-yeolab/software

If your'e installing something from source and using ``./configure``
and ``make`` and all that, then always set the flag
``--prefix=/projects/ps-yeolab/software`` when you run ``./configure``

.. code::

    ./configure --prefix /projects/ps-yeolab/software

When possible install bins to ``/projects/ps-yeolab/software/bin``

Running RNA-seq, CLIP-Seq, Ribo-Seq, etc qscripts GATK Queue pipelines
----------------------------------------------------------------------

We use the Broad Institute's Genome Analysis Toolkit (GATK_) Queue_ software
to run our pipelines. This software solves a lot of problems for us, such as
dealing with multiple-stage pipelines that have cross-dependencies (e.g. you
can't calculate splicing until you've mapped the reads, and you can't map
the reads until after you've removed adapters and repetitive genomic regions
from them), and properly scheduling jobs so that one person's analysis doesn't
completely take over the compute cluster.

Gabe has created a bunch of helpful template scripts for GATK Queue in his
folder ``/home/gpratt/templates``:

.. code::

    $ ls -lh /home/gpratt/templates
    total 26K
    -rwxr-xr-x 1 gpratt yeo-group 660 May  7  2014 bacode_split.sh
    -rwxr-xr-x 1 gpratt yeo-group 554 May  7  2014 bacode_split.sh~
    -rwxr-xr-x 1 gpratt yeo-group 524 Sep 18 00:08 #clipseq.sh#
    -rwxr-xr-x 1 gpratt yeo-group 524 Jul 12  2014 clipseq.sh
    -rwxr-xr-x 1 gpratt yeo-group 516 Mar 26  2014 clipseq.sh~
    -rwxr-xr-x 1 gpratt yeo-group 473 Aug 21 18:47 riboseq.sh
    -rwxr-xr-x 1 gpratt yeo-group 528 Aug 21 18:46 riboseq.sh~
    -rwxr-xr-x 1 gpratt yeo-group 530 Sep  5 17:29 rnaseq.sh
    -rwxr-xr-x 1 gpratt yeo-group 527 Mar 26  2014 rnaseq.sh~

Each Queue job requires a manifest file with a list of all files to process,
and the genome to process them on.

.. warning::

    All further instructions depend on you having followed the directions in
    `Create workflow and projects folders`_, where for this particular project,
    you've created these folders:

    .. code::

        ~/projects/PROJECT_NAME
        ~/processing_scripts/PROJECT_NAME/scripts
        ~/scratch/PROJECT_NAME/data
        ~/scratch/PROJECT_NAME/analysis

    And that you've linked the scratch and home directories correctly. For
    example, here's how you can create the project directory structure for a
    project called ``singlecell_pnms``:

    .. code::

        NAME=singlecell_pnms
        mkdir -p ~/projects/$NAME ~/scratch/$NAME ~/scratch/$NAME/data ~/scratch/$NAME/analysis ~/processing_scripts/$NAME/scripts
        ln -s ~/scratch/$NAME/data ~/projects/$NAME/data
        ln -s ~/scratch/$NAME/analysis ~/projects/$NAME/analysis
        ln -s ~/processing_scripts/$NAME/scripts ~/projects/$NAME/scripts

Here's an example queue script for single-end, not strand-specific RNA-seq,
from the file ``singlecell_pnms_se_v3.sh``:

.. code::

    #!/bin/bash

    NAME=singlecell_pnms_se
    VERSION=v3
    DIR=singlecell_pnms
    java -Xms512m -Xmx512m -jar /projects/ps-yeolab/software/gatk/dist/Queue.jar -S $HOME/gscripts/qscripts/analyze_rna_seq.scala --input ${NAME}_${VERSION}.txt --adapter TCGTATGCCGTCTTCTGCTTG --adapter ATCTCGTATGCCGTCTTCTGCTTG --adapter CGACAGGTTCAGAGTTCTACAGTCCGACGATC --adapter GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -qsub -jobQueue home-yeo -runDir ~/projects/${DIR}/analysis/${NAME}_${VERSION}  -log ${NAME}_${VERSION}.log --location ${NAME}  --strict -keepIntermediates --not_stranded -single_end -run

Notice that the "``--input``" is the file ``${NAME}_${VERSION}.txt``, which
translates to ``singlecell_pnms_se_v3.txt`` in this case, since
``NAME=singlecell_pnms_se`` and ``VERSION=v3`` are defined at the beginning of
the file. This file is the "manifest" of the sequencing run. In the case of
single-end reads, this is a file where each line has,
``/path/to/read1.fastq.gz\tspecies\n``,
where ``\t`` indicates a tab (using the ``<TAB>`` character), and ``\n``
indicates a new line, created by ``<ENTER>``. Here is the first
10 lines of ``singlecell_pnms_se_v3.txt`` (obtained via
``head singlecell_pnms_se_v3.txt``):

.. code::

    /home/obotvinnik/projects/singlecell_pnms/data/CVN_01_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_02_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_03_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_04_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_05_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_06_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_07_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_08_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_09_R1.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/CVN_10_R1.fastq.gz       hg19

For paired-end, not strand-specific RNA-seq, here's the script of the file
``singlecell_pnms_pe_v3.sh``

.. code::

    #!/bin/bash

    NAME=singlecell_pnms_pe
    VERSION=v3
    DIR=singlecell_pnms
    java -Xms512m -Xmx512m -jar /projects/ps-yeolab/software/gatk/dist/Queue.jar -S $HOME/gscripts/qscripts/analyze_rna_seq.scala --input ${NAME}_${VERSION}.txt --adapter TCGTATGCCGTCTTCTGCTTG --adapter ATCTCGTATGCCGTCTTCTGCTTG --adapter CGACAGGTTCAGAGTTCTACAGTCCGACGATC --adapter GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -qsub -jobQueue home-yeo -runDir ~/projects/${DIR}/analysis/${NAME}_${VERSION}  -log ${NAME}_${VERSION}.log --location ${NAME}  --strict -keepIntermediates --not_stranded -run

Notice that the "``--input``" is the file ``${NAME}_${VERSION}.txt``, which
translates to ``singlecell_pnms_pe_v3.txt`` in this case, since
``NAME=singlecell_pnms_pe`` and ``VERSION=v2`` are defined at the beginning of
the file. This file is the "manifest" of the sequencing run. In the case of
single-end reads, this is a file where each line has:
``read1.fastq.gz;read2.fastq.gz\tspecies\n``,
where ``\t`` indicates a tab (using the ``<TAB>`` character), and ``\n``
indicates a new line, created by ``<ENTER>``. Here is the first
10 lines of ``singlecell_pnms_pe_v3.txt`` (obtained via
``head singlecell_pnms_pe_v3.txt``):

.. code::

    /home/obotvinnik/projects/singlecell_pnms/data/M1_01_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_01_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_02_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_02_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_03_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_03_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_04_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_04_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_05_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_05_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_06_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_06_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_07_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_07_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_08_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_08_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_09_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_09_R2.fastq.gz       hg19
    /home/obotvinnik/projects/singlecell_pnms/data/M1_10_R1.fastq.gz;/home/obotvinnik/projects/singlecell_pnms/data/M1_10_R2.fastq.gz       hg19

For this project, I had a mix of both paired-end and single-end reads, so
that's why ``DIR`` is the same for both the ``singlecell_pnms_se_v3.sh`` and
``singlecell_pnms_pe_v3.sh`` scripts, but ``NAME`` was different - then they're
saved in different folders.


Running GATK Queue pipeline scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that you've created manifest file called ``${NAME}_${VERSION}.txt`` and
``${NAME}_${VERSION}.sh``, you are almost ready to run the pipeline.

.. note::

    You should be using ``screen`` quite often now. You'll want to run your
    pipeline in a ``screen`` session, because then even when you log out of
    TSCC, the pipeline will still be running.

    If you've already run ``screen``, reattach the session with:

    .. code::

        screen -x

    If that gives you the error: ``There is no screen to be attached.``, then
    you haven't run ``screen`` before, and you can start a session with:

    .. code::

        screen

These scripts take quite a bit of memory to compile, so to be nice to everyone,
log into a compute node by requesting an interactive job on TSCC. Also your
script may just run out of memory and fail if you're not a compute node, so
that is even more incentive to log into a compute node!

This command will create an interactive job for 40 hours, on the ``home-scrm``
queue, and with 1 node and 1 processor (you don't need more than that for the
script, and the script will submit jobs that request more nodes/processors for
compute-intensive stuff like STAR or Sailfish). If you have a lot of samples,
you may need more time, but try just 40 hours first.

So here's what you do:

.. code::

    qsub -I -l walltime=40:00:00 -q home-scrm
    # Wait for the job to be ready. This may take a while
    cd ~/projects/$NAME/scripts
    sh ${NAME}_${VERSION}.sh

For example, for the ``singlecell_pnms`` project from before, I would do:

.. code::

    qsub -I -l walltime=40:00:00 -q home-scrm
    # Waited for job to get scheduled/be ready ....
    cd ~/projects/singlecell_pnms/scripts
    sh singlecell_pnms_se_v3.sh

This outputs:

.. code::

    INFO  12:24:42,840 QScriptManager - Compiling 1 QScript
    INFO  12:24:55,100 QScriptManager - Compilation complete
    INFO  12:24:55,359 HelpFormatter - ----------------------------------------------------------------------
    INFO  12:24:55,359 HelpFormatter - Queue v2.3-1095-gdb26a3f, Compiled 2015/01/26 15:22:32
    INFO  12:24:55,359 HelpFormatter - Copyright (c) 2012 The Broad Institute
    INFO  12:24:55,359 HelpFormatter - For support and documentation go to http://www.broadinstitute.org/gatk
    INFO  12:24:55,360 HelpFormatter - Program Args: -S /home/obotvinnik/gscripts/qscripts/analyze_rna_seq.scala --input singlecell_pnms_se_v3.txt --adapter TCGTATGCCGTCTTCTGCTTG --adapter ATCTCGTATGCCGTCTTCTGCTTG --adapter CGACAGGTTCAGAGTTCTACAGTCCGACGATC --adapter GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -qsub -jobQueue home-yeo -runDir /home/obotvinnik/projects/singlecell_pnms/analysis/singlecell_pnms_se_v3 -log singlecell_pnms_se_v3.log --location singlecell_pnms_se --strict -keepIntermediates --not_stranded -single_end -run
    INFO  12:24:55,360 HelpFormatter - Date/Time: 2015/01/27 12:24:55
    INFO  12:24:55,360 HelpFormatter - ----------------------------------------------------------------------
    INFO  12:24:55,361 HelpFormatter - ----------------------------------------------------------------------
    INFO  12:24:55,370 QCommandLine - Scripting AnalyzeRNASeq
    INFO  12:24:58,436 QCommandLine - Added 773 functions
    INFO  12:24:58,438 QGraph - Generating graph.
    INFO  12:24:58,664 QGraph - Running jobs.
    ... more output ...

Pipeline frequently asked questions (FAQ)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

How do I ...
++++++++++++

... deal with multiple species? Do I have to create different manifest files?
    Fortunately, no! You can create a single manifest file.

Looking at ``/home/gpratt/projects/msi2/scripts``, we see the file
``msi2_v2.txt``, which has the contents:

.. code::

    /home/gpratt/projects/msi2/data/msi2/MSI2_ACAGTG_ACAGTG_L008_R1.fastq.gz        hg19
    /home/gpratt/projects/msi2/data/msi2/MSI2_CAGATC_CAGATC_L008_R1.fastq.gz        mm9
    /home/gpratt/projects/msi2/data/msi2/MSI2_GCCAAT_GCCAAT_L008_R1.fastq.gz        mm9
    /home/gpratt/projects/msi2/data/msi2/MSI2_TAGCTT_TAGCTT_L008_R1.fastq.gz        hg19
    /home/gpratt/projects/msi2/data/msi2/MSI2_TGACCA_TGACCA_L008_R1.fastq.gz        hg19
    /home/gpratt/projects/msi2/data/msi2/MSI2_TTAGGC_TTAGGC_L008_R1.fastq.gz        hg19

So you can reference multiple genomes in a single manifest file!


... deal with both single-end and paired-end reads in one project? Do I need to create separate manifest files?
    Yes, unfortunately. :( Check out the ``singlecell_pnms`` project above as
    an example.

... see the documentation for a queue script?
    This command will show documentation for ``analyze_rna_seq.scala``. For
    further documentation, see the `GATK Queue website`_.

.. code::

    java -Xms512m -Xmx512m -jar /projects/ps-yeolab/software/gatk/dist/Queue.jar -S ~/gscripts/qscripts/analyze_rna_seq.scala


analyze_rna_seq
~~~~~~~~~~~~~~~

The queue script ``analyze_rna_seq.scala`` runs or generates:

1. RNA-SeQC_
2. cutadapt
3. miso
4. OldSplice
5. Sailfish
6. A->I editing predictions
7. bigWig files
8. Counts of reads mapping to repetitive elements
9. Estimates of PCR Duplication

Detailed description of `analyze_rna_seq.scala`_ outputs.

analyze_rna_seq_gently
~~~~~~~~~~~~~~~~~~~~~~

The queue script ``analyze_rna_seq_gently.scala`` runs:

1. RNA-SeQC_
2. ...

Combining outputs from the pipeline into matrices
-------------------------------------------------

See the rnaseek_ software for how to combine Sailfish, STAR and MISO outputs.

.. _TSCC: http://rci.ucsd.edu/computing/index.html
.. _dry lab: dryyeo-l@googlegroups.com
.. _TSCC users: tscc-l@mailman.ucsd.edu
.. _Jim Hayes: jhayes@sdsc.edu
.. _hub: https://hub.github.com/
.. _Screen: https://kb.iu.edu/d/acuy
.. _rcfiles: https://github.com/olgabot/rcfiles
.. _passwordless ssh: http://www.linuxproblem.org/art_9.html
.. _GATK Queue website: http://gatkforums.broadinstitute.org/discussion/1306/overview-of-queue
.. _RNA-SeQC: http://www.broadinstitute.org/cancer/cga/rna-seqc
.. _analyze_rna_seq.scala: analyze_rna_seq
.. _Github's instructions     for generating SSH keys: https://help.github.com/articles/generating-ssh-keys/
.. _GATK: https://www.broadinstitute.org/gatk/
.. _Queue: http://gatkforums.broadinstitute.org/discussion/1306/overview-of-queue
.. _R packages he's added so far: https://binstar.org/asmeurer/
.. _rnaseek: http://github.com/olgabot/rnaseek
