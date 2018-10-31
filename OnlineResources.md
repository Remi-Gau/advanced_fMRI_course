# On-line resources

**Table of Contents**

* [Online courses](#Online-courses)
* [Video series](#Video-series)
* [Blogs](#Blogs)
* [Matlab and SPM specific resources](#Matlab-and-SPM-specific-resources)
* [UNIX command line](#UNIX-command-line)
* [Code and data management](#Code-and-data-management)
* [Laminar and high-resolution MRI](#Laminar-and-high-resolution MRI)
* [Planning your study](Planning-your-study)
* [Methods and results reporting](#Methods-and-results-reporting)
* [Sharing your results](#Sharing-your-results)
* [Where to ask for help](#Where-to-ask-for-help)


---


There are tons of on-line resources for neuroimaging data analysis so the following list is not meant to be exhaustive. There are also similar lists here and there that might partly overlap with this one.

* [Stephan Heunis](https://twitter.com/fmrwhy) has a [list](https://www.fmrwhy.com/2018/06/28/spm12-matlab-scripting-tutorial-4/) to many SPM and matlab material.
* [Jonathan Peelle](@jpeelle) has a great [list of resources](http://jonathanpeelle.net/mri-resources-for-beginners) for beginners.
* Check the [wiki](http://imaging.mrc-cbu.cam.ac.uk/imaging/CbuImaging) from the CBU in Cambridege.
* [https://github.com/brainhack101](https://github.com/brainhack101) also has a [collections or links](https://brainhack101.github.io/neurolinks/) to courses, data...
* ReproNim is a good [site](http://www.reproducibleimaging.org/index.html) to get up to date on doing reproducible research.



## Online courses

There are quite a few courses for fMRI analysis out there that I am aware of. Also most of the main analysis softwares have at least one video series that works as a course +/- tutorial.

### Coursera
[Tor Wager](https://twitter.com/torwager) and Martin Lindquist offer a 2 parts MOOC on coursera.

* [part 1](https://en.coursera.org/learn/functional-mri)
* [part 2](https://en.coursera.org/learn/functional-mri-2)

### SPM
[here](http://www.fil.ion.ucl.ac.uk/spm/course/video/)

### Freesurfer
[Here](https://www.youtube.com/channel/UCruQerP8aa-gYttXkAcyveA)

### FSL
???

### AFNI
???

### Nipype
Nipype is best viewed a way to create and run software-agnostic analysis-pipeline. It becomes very powerful when you need to use different softwares in your analysis. There is a course/tutorial that can be found [here](https://miykael.github.io/nipype_tutorial/).

### Neurohackademy
Neurohackademy is not exactly an fMRI course for beginners: it is broader in scope as it covers reproducibility and open science issues in neuroimaging. It is also very practical and definitely python oriented. To know more, see this [post](http://www.talyarkoni.org/blog/2018/08/16/neurohackademy-2018-a-wrap-up/) by [Tal Yarkoni](https://twitter.com/talyarkoni) about the 2018 edition of Neurohackademy.

* [videos to the edition 2017/2018](https://www.youtube.com/playlist?list=PLA6PlfxWZPLTLJ2qTN9enG0tkizpmwWaq)
* [videos to the edition 2016](https://www.youtube.com/playlist?list=PLEdFhTRBFLObkatJOX9wp3BCueH4wNSl7)
* [2018 course material](https://github.com/neurohackademy)



## Video series

Youtube has some useful channels if you want to learn more about fMRI data analysis. I also list here some other repository of MRI related videos.

### mumfordbrainstats
Jeanette Mumford has a fantastic series of videos on neuroimaging analysis on [youtube](https://www.youtube.com/channel/UCZ7gF0zm35FwrFpDND6DWeA). The channel also has [Facebook group](https://www.facebook.com/groups/mumfordbrainstats/) (as well as a [tumblr](http://mumfordbrainstats.tumblr.com/) and [twitter account](https://twitter.com/mumbrainstats) ) if you have questions.

### Andrew Jahn
[Here](https://www.youtube.com/user/Shala5ha5ka) for the videos but he also as a [blog](https://www.andysbrainblog.com/) (see the old version [here](http://andysbrainblog.blogspot.com)). He has some very good follow along 'tutorials' for FSL, Freesurfer and AFNI amongst other things.

### Center for Brains, Minds and Machines
[Here](https://www.youtube.com/channel/UCGoxKRfTs0jQP52cfHCyyRQ)

### Organization from human brain mapping (OHBM)
The videos of the lectures and workshops from the previous HBM conferences are available online [here](https://www.pathlms.com/ohbm/courses).

### fMRIf summer courses from the NIH
[Here](https://fmrif.nimh.nih.gov/public/fmri-course/)



## Blogs

There are many excellent blogs run by neuroscientists where you can find interesting and more or less technical information on neuroimaging analysis. I list a few below but you can find a subsample of my neuroscience blogroll in the file `blogroll_a_sample.opml` that you can import into your favorite news reader (e.g [feedly](https://feedly.com)).

* [Jo Etzel](https://twitter.com/JosetAEtzel) has a great blog if you want to know more about multivariate analysis: [MVPA meandering](http://mvpa.blogspot.co.uk)
* [practiCal fMRI](https://twitter.com/practiCalfMRI) has a great [blog](http://practicalfmri.blogspot.co.uk) with posts that cover the basics of fMRI, MRI artefacts, as well as a all the things that can affect the BOLD signal
* [Chris Chambers](https://twitter.com/chrisdc77) blog is [Neurochambers](http://neurochambers.blogspot.co.uk)s
* [Neuroskeptic](https://twitter.com/Neuro_Skeptic) blogs at [Neuroskeptic](http://blogs.discovermagazine.com/neuroskeptic/)
* [Dorothy Bishop](https://twitter.com/deevybee) is [there](http://deevybee.blogspot.com/).
* [Russel Poldracks](https://twitter.com/russpoldrack) posts can be found [here](http://www.russpoldrack.org)
* [Peter Bandettini](https://twitter.com/fMRI_today) blogs at [the brain blog](http://www.thebrainblog.org)



## Matlab and SPM specific resources

* [The clever machine](https://theclevermachine.wordpress.com/category/fmri/) blog has some very useful matlab codes for fMRI analysis
* [Tom Nichols](https://twitter.com/ten_photos) has tagged SPM related posts on his [website](http://blogs.warwick.ac.uk/nichols/) if you are looking for some good code snippets: see for example some of John Ashburner's [gems](http://blogs.warwick.ac.uk/nichols/tag/johns-gems/).
* Check out [Cyril Pernet](https://twitter.com/cyrilrpernet) website for SPM/matlab code: [here](http://www.sbirc.ed.ac.uk/cyril/teaching.html) or [there](http://www.sbirc.ed.ac.uk/cyril/Stats.html)
* Some good tutorials on the CBU if you want to understand [design efficiency](http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency), [smoothing](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesSmoothing), [SPM GLM stats](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesStatistics) or [how random field theory works to correct for multiple comparison](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields)
* And also [too many repos on Github to list them all](https://github.com/search?q=matlab+fmri) but here are some you might come across: [Rik Henson's](https://github.com/MRC-CBU/riksneurotools), the [canlab]() https://github.com/canlab)



## UNIX command line

Even if you have only used Windows in your life the odds are that you will at some point have to use a UNIX command line (like the one you can find on a linux computer or a Mac) to do some of your MRI analysis. Best case scenario you might only need it to explore some folder structure on some server, worst case you might have to write some scripts to automate some tasks. Either way, having some basics ideas about how to interact with a UNIX is a good idea.

* from the FSL [website](https://fsl.fmrib.ox.ac.uk/fslcourse/lectures/scripting/all.htm)
* on the MRC-CBU [wiki](http://imaging.mrc-cbu.cam.ac.uk/methods/unixsurvivalguide)
* from software carpentry for [beginners](http://swcarpentry.github.io/shell-novice/) and more [advanced users](http://swcarpentry.github.io/shell-extras/)
* for [more advanced scripting](https://wilsonericn.wordpress.com/2011/08/25/find-grep-sed-and-awk)



## Code and data management

In general I suggest you have a look at some of the courses and material offered by the Carpentries for [data](https://datacarpentry.org/) and [code](https://software-carpentry.org/).

If you are going to do some fMRI analysis you will quickly drown in data if you are not a bit organized so I highly recommend you use the brain imaging data structure standard ([BIDS](http://bids.neuroimaging.io/)) to organize your data. The current version of BIDS only talks about raw data but it should soon cover derivatives (i.e preprocessed data). In general BIDS also allows you to more easily share your data and use plenty of analytical [tools](bids-apps.neuroimaging.io/apps/).

As for managing your code, if you don't already I suggest you make version control with [GIT](https://git-scm.com/) part of every day workflow. GIT might seem scary and confusing at first but it is well worth the effort: the good news is that there are plenty of tutorials available (for example: [here](http://swcarpentry.github.io/git-novice/), [there](https://www.codecademy.com/learn/learn-git) or [there](https://www.youtube.com/playlist?list=PL0lo9MOBetEHhfG9vJzVCTiDYcbhAiEqL))

Even though GIT is most powerful when using a command line interface, there are also some decent graphic interface that might just be enough for what you need. Plus the graphic interface might be enough to get you started to then help you move to use the command line only. There is no shame in using a GUI: just don't tell the GIT purists this is what you do otherwise you will never hear the end of it.



## Laminar and high-resolution MRI

[Renzo Hubert](https://twitter.com/layerfmri) is keeping track of the most recent development of laminar MRI via twitter but also on his [blog](https://layerfmri.com/). He also curates laminar-fMRI related talks on his [Youtube channel](https://www.youtube.com/channel/UCMjtQ3FD41pAh1VJz-UZGJQ/videos) or papers in this [google spreahsheet](https://docs.google.com/spreadsheets/d/1DFdXA98bYPzK5Gf0M_PbNu3opvO-DIcrv7TMP5ywTMk/edit#gid=0).



## Planning your study:

### Pre-registration

[Pre-registering your study](http://help.osf.io/m/registrations) is good way to decide in advance how you are going to collect and analyze your data. It helps make it clear to yourself and to others what part of your study was predicted (i.e confirmatory) and which part wasn't (i.e exploratory). This way pre-registration are a good way to restrict the number of researchers degrees of freedom and limit the possibility to engage (most often unknowingly) in questionable research practices like procedural overfitting (also known as p-hacking) or HARKing (Hypothesising After the Resuts are Known). You can also opt for [registered reports](https://osf.io/8mpji/wiki/home/) where you submit your methods to a journal and get reviews on the protocol before the data collection and analysis is conducted.

For examples of studies that were pre-registered you can search in the [zotero libraries](https://www.zotero.org/groups/479248/osf/items?) curated by the [open science framework](https://osf.io/).

Pre-registering neuroimaging studies can be quite challenging and comes with a whole set of constraints that might be absent in other fields. [Jessica Flannery](https://twitter.com/j_flan) has created a [template](https://osf.io/6juft/) for pre-registering fMRI studies that you might find useful.



### Power and design efficiency

Before you run your study there are a few things you can do to optimize your design. Two of them are doing a power analysis and optimizing the efficiency of your fMRI design.

For the latter you have few options:
* from computing the efficiency by hand and tweaking your design [to see what options work best](http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency)
* There are also more systematic ways to optimize your protocol: see here(http://surfer.nmr.mgh.harvard.edu/optseq/), here(http://psych.colorado.edu/~tor/Software/genetic_algorithms.html) or there(http://www.cabiatl.com/CABI/resources/fmrisim/)

The website [neuropowertools](http://www.neuropowertools.org/) actually offers options to run both your design efficiency optimization and your power analysis.



## Methods and results reporting

The organization from human brain mapping (OHBM) created the Committee on Best practices In Data Analysis and Sharing (COBIDAS) that published a report with a set of [guidelines](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5685169/) with an appended [checklist](https://www.biorxiv.org/content/early/2016/07/10/054262.full.pdf+html) on how to conduct and report fMRI studies. It is a very useful resource to use to make sure you are not forgetting anything when writing up your article.
See also Jeanette Mumford's [video](https://www.youtube.com/watch?v=bsM4KowO5Vc) about it.



## Sharing your data and your results

There are [many](https://brainhack101.github.io/neurolinks/) [possibilities](https://en.wikipedia.org/wiki/List_of_neuroscience_databases) to share your raw and/or pre-processed data but [openneuro](https://openneuro.org/) is an option that supports the BIDS format and also allows you to analyze your data online.

Sharing your final results can be useful for reviewers to check them but also for future researchers that would like to base new research on them or to run a meta-analysis of similar studies.

If you want to share your results I suggest your [export your final SPM results using the NIDM format](https://github.com/incf-nidash/nidmresults-spm) that is supported by SPM12. This makes your results easily viewable by other softwares and facilitates uploading them to a site like [neurovault](https://neurovault.org/) where you can store them and share them with others.

Another thing you can do to share your published results is to add them to meta-analytical databases like [brainmap](http://www.brainmap.org/) or [neurosynth](http://neurosynth.org/): for this you could use [brainspell](http://brainspell.org/) and [Scribe](http://brainspell.org/).



## Where to ask for help

Most software specific questions are usually [best addressed on the mailing list](https://kirstiewhitaker.com/2014/12/16/how-to-use-the-fsl-and-freesurfer-mailing-lists-for-success-in-your-phd/) related to that software: but always start by looking through the archives of those mailing lists first before sending a question that has already been answered.

But if you have more general questions you can also try :
* the [neurostars](https://neurostars.org/) forum
* social medias: there are some specialised Facebook groups or good hashtags on twitter that will succeed when your google fu fails you.
* the slack channel of [brainhack](https://www.brainhack.org/)
