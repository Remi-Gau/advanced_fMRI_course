# On-line neuroimaging resources

I try to list here links to softwares, databases, tutorials, blogs and other resources list that I or others have found relevant to learn about neuroimaging or to help us perform neuroimaging analysis. Most of the things listed here are for fMRI but feel free to point towards EEG, MEG, TMS things too. Feel free to add things: see the **How to contribute** section below.

This document is mostly meant for me to be able to quickly find things without having to google them or browse through my bookmarks, pocket, github stars and repos. But if it can help others, that's great.

Also I am by no means an expert or even have used or done all the things I list... But I wish I had and I wish someone had told me some of those things 5 years ago.

I am also working on a companion [reading list] (  ???  ).

---

**How to use this document**
Most people don't use a map by starting in the upper left corner, scanning horizontally till they end up in the bottom right corner (or however it is that people read in the region of the world you are in at the moment). Similarly this document is obviously not meant to be read from top to bottom. The best is to browse the **Table of content** below and jump to section that interests you. For that reason there is some redundancy in the content. This also means that this document is not a cookbook: I just try to list things that could apply a to wide variety of topics and context, but in many cases only a handful of those will be relevant to you.

Note also that some of the sectioning is bit arbitrary: I try to put cross-links where useful.

---

**How to contribute**
Feel free to add your own resource or any material you have found useful. Send me a pull request to this repository or raise an issue. Or if you don't know how to do that you can reach me on twitter https://twitter.com/RemiGau.

You can check the **looking for** section right below to see what sections of this document need populating. I have also tried to flag with `???` in the table of content and in the main document the areas where I am pretty sure I have missed existing gems.

 ---

**Looking for**
* Material on the BOLD signal: origin and biophysics
* Material on preprocessing, denoising
* Material on statistical inference in neuroimaging: peak, voxel, cluster based
* Material on multiple comparison correction in neuroimaging
* Material on DTI, ASL
* Material on connectivity: PPI, DCM, granger causality

---

**To add in the list**

http://cbs.fas.harvard.edu/science/core-facilities/neuroimaging/information-investigators/MRphysicsfaq

https://emmarobinson01.com/2016/10/07/forget-weak-statistics-fmri-studies-suffer-from-oversimplified-assumptions-made-during-pre-processing/

http://cbs.fas.harvard.edu/science/core-facilities/neuroimaging/information-investigators/MRphysicsfaq

specific talks from mumfordbrainstats, OHBM conference and other video series

---



**Table of content**

* [Metalist](#metalist)
  + [Neuroimaging Informatics Tools and Resources Clearinghouse](#neuroimaging-informatics-tools-and-resources-clearinghouse)
  + [Lab guides and lab wikis](#lab-guides-and-lab-wikis)
  + [Others](#others)
* [Online courses](#online-courses)
  + [Math and linear algebra courses](#math-and-linear-algebra-courses)
  + [MRI courses ( ??? )](#mri-courses-------)
  + [fMRI courses ( ??? )](#fmri-courses-------)
  + [Machine learning ( ??? )](#machine-learning-------)
  + [Resting state courses ( ??? )](#resting-state-courses-------)
  + [Neurohackademy](#neurohackademy)
  + [Software specific ( ??? )](#software-specific-------)
    - [SPM](#spm)
    - [Freesurfer](#freesurfer)
    - [FSL](#fsl)
    - [AFNI](#afni)
    - [Nipype](#nipype)
    - [Others ( ??? )](#others-------)
  + [Statistics courses](#statistics-courses)
  + [Open-science and reproducibility](#open-science-and-reproducibility)
* [Video series](#video-series)
  + [Mumford brainstats](#mumford-brainstats)
  + [Andrew Jahn](#andrew-jahn)
  + [Center for Brains, Minds and Machines](#center-for-brains-minds-and-machines)
  + [Organization from human brain mapping (OHBM)](#organization-from-human-brain-mapping-ohbm)
  + [fMRIf summer courses from the NIH](#fmrif-summer-courses-from-the-nih)
  + [Conference on Cognitive Computational Neuroscience (CCN)](#conference-on-cognitive-computational-neuroscience-ccn)
* [Blogs](#blogs)
* [Where to ask for help](#where-to-ask-for-help)
* [UNIX command line](#unix-command-line)
* [Matlab and SPM specific resources](#matlab-and-spm-specific-resources)
  + [Matlab ( ??? )](#matlab-------)
  + [SPM](#spm-1)
* [The python ecosystem ( ??? )](#the-python-ecosystem-------)
* [Web apps ( ??? )](#web-apps-------)
  + [R based apps](#r-based-apps)
  + [Vizualizaton](#vizualizaton)
  + [Anatomy atlases ( ??? )](#anatomy-atlases-------)
* [BEFORE YOU START: Reproducibility ( ??? )](#before-you-start-reproducibility-------)
* [BEFORE YOU START: Ethics and consent forms](#before-you-start-ethics-and-consent-forms)
* [BEFORE YOU START: Code and data management ( ??? )](#before-you-start-code-and-data-management-------)
  + [Code management](#code-management)
    - [Version control](#version-control)
    - [Coding style](#coding-style)
    - [Avoid selective debugging: unit tests, positive and negative control](#avoid-selective-debugging-unit-tests-positive-and-negative-control)
  + [Data: BIDS, Datalad and YODA](#data-bids-datalad-and-yoda)
    - [BIDS](#bids)
    - [Datalad](#datalad)
    - [YODA](#yoda)
  + [Documentation ( ??? )](#documentation-------)
* [PLANNING YOUR STUDY](#planning-your-study)
  + [Reusing data](#reusing-data)
  + [Defining your terms and your task](#defining-your-terms-and-your-task)
    - [Ontologies](#ontologies)
  + [Piloting ( ??? )](#piloting-------)
  + [Pre-registration](#pre-registration)
  + [Optimizing your design](#optimizing-your-design)
    - [Design efficiency ( ??? )](#design-efficiency-------)
    - [Power](#power)
    - [For MVPA: same analysis approach](#for-mvpa-same-analysis-approach)
  + [Defining your region of interest ( ??? )](#defining-your-region-of-interest-------)
    - [Using previous results ( ??? )](#using-previous-results-------)
    - [Localizers ( ??? )](#localizers-------)
    - [Atlases](#atlases)
  + [Non-standard templates ( ??? )](#non-standard-templates-------)
* [ONCE YOU HAVE DATA: quality control](#once-you-have-data-quality-control)
* [ONCE YOU HAVE DATA: preprocessing](#once-you-have-data-preprocessing)
  + [Pipelines ( ??? )](#pipelines--------)
  + [Artefact/Noise removal ( ??? )](#artefactnoise-removal-------)
    - [PCA ( ??? )](#pca--------)
    - [ICA ( ??? )](#ica--------)
    - [ART ( ??? )](#art-------)
    - [ART repair ( ??? )](#art-repair-------)
    - [Physiological noise ( ??? )](#physiological-noise--------)
* [ANALYSIS: general linear model](#analysis-general-linear-model)
* [ANALYSIS: Resting state ( ??? )](#analysis-resting-state-------)
* [ANALYSIS: Model selection ( ??? )](#analysis-model-selection-------)
* [ANALYSIS: Statistical inferences and multiple comparison correction (MCP) ( ??? )](#analysis-statistical-inferences-and-multiple-comparison-correction-mcp-------)
  + [Cluster based inference ( ??? )](#cluster-based-inference-------)
  + [Family wise error (FWE) ( ??? )](#family-wise-error-fwe-------)
  + [False discovery rate (FDR) ( ??? )](#false-discovery-rate-fdr-------)
  + [Permutation tests ( ??? )](#permutation-tests-------)
    - [SnPM ( ??? )](#snpm-------)
    - [FSL PALM and Randomize( ??? )](#fsl-palm-and-randomize------)
    - [Freesurfer PALM ( ??? )](#freesurfer-palm-------)
* [ANALYSIS: Multivariate analysis ( ??? )](#analysis-multivariate-analysis-------)
  + [Matlab based](#matlab-based)
    - [TDT](#tdt)
    - [ProNTo](#pronto)
    - [RSA toolbox](#rsa-toolbox)
    - [PCM toolbox](#pcm-toolbox)
    - [cvMANOVA](#cvmanova)
    - [SAMSRF](#samsrf)
  + [Python based](#python-based)
    - [pyMVPA](#pymvpa)
    - [nilearn](#nilearn)
    - [Popeye](#popeye)
  + [R based ( ??? )](#r-based-------)
* [ANALYSIS: Robustness checks](#analysis-robustness-checks)
* [ANALYSIS: Computational neuroscience](#analysis-computational-neuroscience)
  + [Free energy](#free-energy)
  + [Dynamic causal modelling](#dynamic-causal-modelling)
* [ANALYSIS: Laminar and high-resolution MRI](#analysis-laminar-and-high-resolution-mri)
* [ANALYSIS: Meta analysis ( ??? )](#analysis-meta-analysis-------)
* [REPORTING METHODS AND RESULTS (also useful for reviewing papers)](#reporting-methods-and-results-also-useful-for-reviewing-papers)
  + [A checklist: COBIDAS report](#a-checklist-cobidas-report)
  + [Percent signal change ( ??? )](#percent-signal-change-------)
  + [Making figures ( ??? )](#making-figures-------)
  + [Tools to check results/statistics ( ??? )](#tools-to-check-resultsstatistics-------)
  + [Peer review ( ??? )](#peer-review-------)
* [YOU ARE NOT DONE YET: sharing your code, data and your results](#you-are-not-done-yet-sharing-your-code-data-and-your-results)
  + [Sharing code](#sharing-code)
  + [NeuroImaging Data Model (NIDM)](#neuroimaging-data-model-nidm)
  + [Sharing your data](#sharing-your-data)
  + [Meta-analysis databases](#meta-analysis-databases)



---



## Metalist
There are tons of on-line resources for neuroimaging data analysis so the following list is not meant to be exhaustive. There are also similar lists here and there that might partly overlap with this one, so here is a list of lists.


### Neuroimaging Informatics Tools and Resources Clearinghouse
The most obvious place where everything is centralized is the [Neuroimaging Informatics Tools and Resources Clearinghouse](https://www.nitrc.org/). Many tools, atlases, courses are there but if your favorite isn't make sure to add it.


### Lab guides and lab wikis
If your lab does not have a lab guide/wiki, it is well worth the time to make one. Lab wikis can save a lot of time for newcomers to get set up and started (rather than reinvent the wheel or take time from other lab members), while lab guides will also help PIs, PhD students and post-docs know what to expect from each others and to promote a [healthier lab culture](https://www.nature.com/articles/d41586-018-05142-9). [Mariam Aly](https://twitter.com/mariam_s_aly) explains that well [here](https://www.nature.com/articles/d41586-018-06167-w).

If you lab does not have a guide and/or wiki here is a [list](https://docs.google.com/spreadsheets/d/1kn4A0nR4loUOSDn9Qysd3MqFJ9cGU91dCDM6x9aga-8/edit#gid=0) you can use to create your own. But I suggest that you go beyond a copy-paste as the ones you find in there might not be tailored to your lab's needs.

And here are some neuroimaging oriented lab wikis:
* [Mariam Aly's](https://twitter.com/mariam_s_aly) lab wiki is [there](https://osf.io/kgd9b/wiki/home/).
* [Jonathan Peelle](@jpeelle) has a great [list of resources](http://jonathanpeelle.net/mri-resources-for-beginners) for beginners.
* Check the [wiki](http://imaging.mrc-cbu.cam.ac.uk/imaging/CbuImaging) from the CBU in Cambridge.
* The one from [Tor Wager's](https://twitter.com/torwager) [lab](https://canlabweb.colorado.edu/wiki/doku.php/help/fmri_tools_documentation)
* Michael Beauchamp's lab [wiki](https://openwetware.org/wiki/Beauchamp:Lab_Notebook)
* Chris Rorden's Neuropsychology Lab [wiki](https://www.mccauslandcenter.sc.edu/crnl/tools)
* The [Kording](https://twitter.com/KordingLab) lab and Kendrick Kay's labs are more computational oriented and so check [them](http://kordinglab.com/resources/) [out](http://cvnlab.net/resources.html) if this is what you do.


### Others
* [Stephan Heunis](https://twitter.com/fmrwhy) has a [list](https://www.fmrwhy.com/2018/06/28/spm12-matlab-scripting-tutorial-4/) to many SPM and matlab material.
* [https://github.com/brainhack101](https://github.com/brainhack101) also has a [collections or links](https://brainhack101.github.io/neurolinks/) to courses, data...
* ReproNim is a good [site](http://www.reproducibleimaging.org/index.html) to get up to date on doing reproducible neuroimaging research.
* [Open neuroscience](https://openeuroscience.com/) points to a lot of open things related to neuroscience.
* There [MOOC on open-science](https://opensciencemooc.eu/) is still under construction but already has an insane [list of resources](https://opensciencemooc.eu/resources/).



## Online courses


### Math and linear algebra courses
Khan Academy is a great free resource for all sorts of topics.
* Their series on [linear algebra](https://www.khanacademy.org/math/linear-algebra) is particularly useful and relevant to our needs.
* The Fourier [series](https://www.khanacademy.org/science/electrical-engineering/ee-signals/ee-fourier-series/v/ee-fourier-series-intro) and the
* [statistics one](https://www.khanacademy.org/math/statistics-probability) videos may also prove useful (h/t [Sam Jones] (   ???   ) ).

If you feel that your background in mathematics and signal processing is a bit weak please have a look at [these slides](https://figshare.com/s/be5a73a1e0a31fb9b6ed). This file was put together by [Joana Leitao](https://twitter.com/JoanaLeitao8) and covers several topics that are important to be familiar with in neuroimaging:
* basic linear algebra
* ordinary least square solution for the general linear model
* the BOLD response and convolution: what is a linear time invariant system and why is matters when doing a fMRI study ?
* how to do t-test and ANOVAS within a general linear model


### MRI courses (   ???   )
If you need to dust up your knowledge about MRI.
* the [e-MRI course]([https://www.imaios.com/en/e-Courses/e-MRI)
* [MRI fundamentals](https://www.coursera.org/learn/mri-fundamentals) on coursera
* A [Magnetic Resonance Imaging Lab](https://cfmriweb.ucsd.edu/ecwong/BE278W14.html) from UCSD
* [MRI question](http://mriquestions.com/how-does-fmri-work.html) is not a course but a VERY VERY comprehensive FAQ on MRI.

There are also blog posts series on [practicalfmri](http://practicalfmri.blogspot.co.uk) (and on its companion winnower account) that cover
* [the physics of fMRI artefacts](https://practicalfmri.blogspot.com/2012/02/physics-for-understanding-fmri.html)
* the type of [artefacts](https://practicalfmri.blogspot.com/2012/09/understanding-fmri-artifacts-contents.html) you might encounter and what to look for
* a list of potential confounds to the [BOLD signal](https://thewinnower.com/papers/concomitant-physiologic-changes-as-potential-confounds-for-bold-based-fmri-a-checklist)
* [quality control on MRI and fMRI](https://practicalfmri.blogspot.com/2014/08/qa-for-fmri-part-3-facility-qa-what-to.html)


http://technicalfmri.blogspot.com/2018/02/physiological-monitoring-and-recording.html?m=1


### fMRI courses (   ???   )
There are quite a few courses for fMRI analysis out there that I am aware of.
* On coursera
A few courses on [coursera](https://www.coursera.org/courses?query=mri) with notably
  - [Tor Wager's](https://twitter.com/torwager) and Martin Lindquist's 2 parts MOOC ([part 1](https://en.coursera.org/learn/functional-mri)
 and [part 2](https://en.coursera.org/learn/functional-mri-2))
 - and the [Introduction to Neurohacking In R](https://www.coursera.org/learn/neurohacking)
* Others
   - the [fMRI Image Acquisition and Analyses course](https://www.mrn.org/education-outreach/courses-and-events) from the mind research network is an IRL course but links to useful resources too
   - the [functional MRI methods - psych 214](https://bic-berkeley.github.io/psych-214-fall-2016/) from Berkeley


### Machine learning (   ???   )
If you are going to do some multivariate analysis, it is likely you will need to know a ~~bit~~ lot of machine learning. I did find that that [this class](https://www.coursera.org/learn/machine-learning) on coursera covered a lot of ground. It is not specific to neuroimaging but gives you a good overview of the basic concept you need to understand.

Worst case it will let you understand [why John von Neumann said](https://www.johndcook.com/blog/2011/06/21/how-to-fit-an-elephant/)
> With four parameters I can fit an elephant, and with five I can make him wiggle his trunk.


### Resting state courses (   ???   )
There is one on the rMRI [website](http://rfmri.org/Course).


### Neurohackademy
Neurohackademy is more than a neuroimaging course: it is broader in scope as it covers reproducibility and open science issues in neuroimaging. It is also very practical and definitely python oriented. To know more, see this [post](http://www.talyarkoni.org/blog/2018/08/16/neurohackademy-2018-a-wrap-up/) by [Tal Yarkoni](https://twitter.com/talyarkoni) about the 2018 edition of Neurohackademy.
* [videos to the edition 2017/2018](https://www.youtube.com/playlist?list=PLA6PlfxWZPLTLJ2qTN9enG0tkizpmwWaq)
* [videos to the edition 2016](https://www.youtube.com/playlist?list=PLEdFhTRBFLObkatJOX9wp3BCueH4wNSl7)
* [2018 course material](https://github.com/neurohackademy)


### Software specific (   ???   )
Most of the main analysis packages on top of the IRL courses usually have one video series that works as a course +/- tutorial.

#### SPM
* [website](https://www.fil.ion.ucl.ac.uk/spm/)
* [manual](https://www.fil.ion.ucl.ac.uk/spm/doc/)
* [mailing list](https://www.fil.ion.ucl.ac.uk/spm/support/)
* [course/tutorial](http://www.fil.ion.ucl.ac.uk/spm/course/)

#### Freesurfer
* [website](https://surfer.nmr.mgh.harvard.edu/)
* [manual](https://surfer.nmr.mgh.harvard.edu/fswiki)
* [mailing list](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSupport)
* [course](https://www.youtube.com/channel/UCruQerP8aa-gYttXkAcyveA) and [videos](https://surfer.nmr.mgh.harvard.edu/fswiki/CourseDescription)

#### FSL
* [website](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki)
* [manual](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Support)
* [mailing list](https://www.jiscmail.ac.uk/cgi-bin/webadmin?A0=fsl)
* [course/tutorial](https://fsl.fmrib.ox.ac.uk/fslcourse/)

#### AFNI
* [website](https://afni.nimh.nih.gov/)
* [manual](https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/index.html)
* [mailing list](https://afni.nimh.nih.gov/afni/community/board/list.php?1)
* [course/tutorial]: Video recordings from the [AFNI bootcamp](https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/bootcamp_recordings.html), with slides, and [example data](https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/unix_tutorial/misc/install.data.html).

#### Nipype
Nipype is best viewed as a way to create and run software-agnostic preprocessing/analysis-pipeline. It becomes very powerful when you need to use different softwares in your analysis.
* [website](https://nipype.readthedocs.io/en/latest/)
* [manual](https://nipype.readthedocs.io/en/latest/documentation.html)
* [course/tutorial](https://miykael.github.io/nipype_tutorial/)

[Tim Van Mourik](https://twitter.com/tim_van_mourik) and a few other people have developed tool to facilitate building pipelines with nipype:
* [Porcupine](https://timvanmourik.github.io/Porcupine/) stands for "PORcupine Creates Ur PipelINE" which is probably *the worst recursive acronym with bad capitalisation and annoying use of slang*. This software allows researchers to build pipelines using a GUI and generates the code that is needed to run the pipeline created.
* [Giraffe](https://giraffe.tools/porcupine) is web-based "Graphical Interface for Reproducible Analysis oF workFlow Experiments" that can take advantage of Porcupine to create pipelines.

#### Others (   ???   )


### Statistics courses
Some of those are clearly not specific to neuroimaging but are well worth going through even if you are a PI.

* If you have no idea what the distribution of p-value would look like if there were only noise in your data, then the odds are you will learn at least one thing in [Daniel Lakens](https://twitter.com/lakens) course on [how to improve your statistical inferences](https://www.coursera.org/learn/statistical-inferences). Most likely you will learn more than one thing.

Daniel also has a blog [blog](http://daniellakens.blogspot.com/) is very useful of stats related knowledge. Similarly [Guillaumme Rousselet's](https://twitter.com/robustgar) has a series of posts on his [blog](https://garstats.wordpress.com/) where you learn more about robust statistics and how to improve your data visualizations.

### Open-science and reproducibility
There is a [MOOC on open-science](https://opensciencemooc.eu/) is still under construction but on top of an insane [list of resources](https://opensciencemooc.eu/resources/) has the [module 5](https://github.com/OpenScienceMOOC/Module-5-Open-Research-Software-and-Open-Source/tree/master/content_development) already up and running to teach you how to use github and zenodo to create a time stamped screenshot of your code to link to in your papers.



## Video series
If you run out of things to binge on on Netflix, Youtube has some useful channels if you want to learn more about fMRI data analysis. I also list here other repository of MRI related videos.


### Mumford brainstats
Jeanette Mumford has a fantastic series of videos on neuroimaging analysis on [youtube](https://www.youtube.com/channel/UCZ7gF0zm35FwrFpDND6DWeA). The channel also has [Facebook group](https://www.facebook.com/groups/mumfordbrainstats/) (as well as a [tumblr](http://mumfordbrainstats.tumblr.com/) and [twitter account](https://twitter.com/mumbrainstats)) if you have questions.


### Andrew Jahn
[Here](https://www.youtube.com/user/Shala5ha5ka) for the videos but he also as a [blog](https://www.andysbrainblog.com/) (see the old version [here](http://andysbrainblog.blogspot.com)). He has some very good follow along 'tutorials' for FSL, Freesurfer and AFNI amongst other things.


### Center for Brains, Minds and Machines
[Here](https://www.youtube.com/channel/UCGoxKRfTs0jQP52cfHCyyRQ)


### Organization from human brain mapping (OHBM)
The videos of the lectures and workshops from the previous HBM conferences are available online [here](https://www.pathlms.com/ohbm/courses).


### fMRIf summer courses from the NIH
[Here](https://fmrif.nimh.nih.gov/public/fmri-course/)


### Conference on Cognitive Computational Neuroscience (CCN)
This new [conference](https://ccneuro.org/) has the videos from its first edition [here](https://ccneuro.org/2017/index.html@p=602.html)



## Blogs
There are many excellent blogs run by neuroscientists where you can find interesting and more or less technical information on neuroimaging analysis. I list a few below but you can find a subsample of my neuroscience blogroll in the file [blogroll_a_sample.opml](.blogroll_a_sample.opml) that you can import into your favorite news reader (e.g [feedly](https://feedly.com)).

* [Jo Etzel](https://twitter.com/JosetAEtzel) has a great blog if you want to know more about multivariate analysis: [MVPA meandering](http://mvpa.blogspot.co.uk)
* [practiCal fMRI](https://twitter.com/practiCalfMRI) has good [blog](http://practicalfmri.blogspot.co.uk) posts that cover the basics of fMRI, MRI artefacts, as well as a all the things that can affect the BOLD signal
* [techniCal fMRI](http://technicalfmri.blogspot.com/) companion to practiCal fMRI that covers topics related to ancillary equipment for fMRI scanning.
* [Chris Chambers](https://twitter.com/chrisdc77) blog is [Neurochambers](http://neurochambers.blogspot.co.uk)s
* [Neuroskeptic](https://twitter.com/Neuro_Skeptic) blogs at [Neuroskeptic](http://blogs.discovermagazine.com/neuroskeptic/)
* [Dorothy Bishop](https://twitter.com/deevybee) is [there](http://deevybee.blogspot.com/).
* [Russel Poldracks](https://twitter.com/russpoldrack) posts can be found [here](http://www.russpoldrack.org)
* [Peter Bandettini](https://twitter.com/fMRI_today) blogs at [the brain blog](http://www.thebrainblog.org)
* [Peter Molfese](https://twitter.com/commander_crash) blogs at [Crash Log](http://blog.cogneurostats.com/), somewhat AFNI focused.



## Where to ask for help
If you have question linked to a specific software, check the documentation/FAQ/manual/wiki/tutorial for that software first. Then you can turn to [the mailing list](https://kirstiewhitaker.com/2014/12/16/how-to-use-the-fsl-and-freesurfer-mailing-lists-for-success-in-your-phd/) related to that software: but always start by looking through the archives of those mailing lists first before sending a question that has already been answered.

But if you have more general questions you can also try :
* the [neurostars](https://neurostars.org/) forum
* social medias: there are some specialised Facebook groups or good hashtags on twitter that will succeed when your google fu fails you.
* the slack channel of [brainhack](https://www.brainhack.org/)



## UNIX command line
Even if you have only used Windows in your life, the odds are that you will at some point have to use a UNIX command line (like the one you can find on a linux computer or a Mac) to do some of your MRI analysis. Best case scenario you might only need it to explore some folder structure on some server, worst case you might have to write some scripts to automate some tasks. Either way, having some basics ideas about how to interact with a UNIX is a good idea.

* from the FSL [website](https://fsl.fmrib.ox.ac.uk/fslcourse/lectures/scripting/all.htm)
* on the MRC-CBU [wiki](http://imaging.mrc-cbu.cam.ac.uk/methods/unixsurvivalguide)
* from software carpentry for [beginners](http://swcarpentry.github.io/shell-novice/) and more [advanced users](http://swcarpentry.github.io/shell-extras/)
* also for [beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/)
* for [more advanced scripting](https://wilsonericn.wordpress.com/2011/08/25/find-grep-sed-and-awk) (h/t [Tom Nichols](https://twitter.com/ten_photos))



## Matlab and SPM specific resources

### Matlab (   ???   )
* tutorials
I learnt matlab with a book and by reading other's scripts and with a lot of coffee, patience, sweat, tears and, trial and errors. I am sure there are better ways to do it than that but I don't really know what the best tutorials are these days.

### SPM
* The first place to look is the [SPM wiki book](https://en.wikibooks.org/wiki/SPM) that could become a even better resource if users contributed even more to it.
* Then you can check the [add-ons for SPM](https://www.fil.ion.ucl.ac.uk/spm/ext/).
* The spm.mat is the file where SPM stores all the information about your analysis. This [page](http://people.duke.edu/~njs28/spmdatastructure.htm) explains its organization.
* If you want to write scripts and use batches efficiently using SPM see what I wrote [here](./How2Script.md)
* [The clever machine](https://theclevermachine.wordpress.com/category/fmri/) blog has some very useful matlab codes for fMRI analysis
* [Tom Nichols](https://twitter.com/ten_photos) has tagged SPM related posts on his [website](http://blogs.warwick.ac.uk/nichols/) if you are looking for some good code snippets: see for example some of John Ashburner's [gems](http://blogs.warwick.ac.uk/nichols/tag/johns-gems/).
* Check out [Cyril Pernet](https://twitter.com/cyrilrpernet) website for SPM/matlab code: [here](http://www.sbirc.ed.ac.uk/cyril/teaching.html) or [there](http://www.sbirc.ed.ac.uk/cyril/Stats.html)
* Some good tutorials on the CBU if you want to understand [design efficiency](http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency), [smoothing](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesSmoothing), [SPM GLM stats](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesStatistics) or [how random field theory works to correct for multiple comparison](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields)
* Quite a few others on the web
  - [https://sites.google.com/site/mvlombardo/matlab-tutorials](https://sites.google.com/site/mvlombardo/matlab-tutorials)
  - [http://spm.martinpyka.de/](http://spm.martinpyka.de/)
  - [https://www.mccauslandcenter.sc.edu/crnl/tools/spm8-scripts](https://www.mccauslandcenter.sc.edu/crnl/tools/spm8-scripts)
* But also [too many repos on Github to list them all](https://github.com/search?q=matlab+fmri) but here are some you might come across: [Rik Henson's](https://github.com/MRC-CBU/riksneurotools), the [canlab](https://github.com/canlab)



## The python ecosystem (   ???   )
Matlab must still be the most used "language" in neuroimaging (citation needed) but there is huge neuroscience-oriented python ecosystem out there taking advantage of the scientific python community. On top of the financial aspect (those matlab licenses can be quite expensive), there are many good reasons why you might wanna switch if only because [matlab breeds](http://neuroplausible.com/matlab) [bad coding habits](http://www.rath.org/matlab-is-a-terrible-programming-language.html).

Here too there are plenty of generic python courses on [datacamp](https://www.datacamp.com/tracks/python-programmer), [code academy](https://www.codecademy.com/learn/learn-python) or [kaggle](https://www.kaggle.com/learn/python). You can also check things that are more scientific python oriented like the [scipy lectures](http://www.scipy-lectures.org/) or Jake Vanderplas's jupyter notebooks [Whirlwind Tour Of Python](https://github.com/jakevdp/WhirlwindTourOfPython) and [Python Data Science Handbook](https://github.com/jakevdp/PythonDataScienceHandbook).

There are also a [handbook](https://www.enthought.com/white-paper-matlab-to-python) and a [course](https://www.fz-juelich.de/ias/jsc/EN/Expertise/Services/Documentation/presentations/presentation-matlab2python_table.html?nn=362392) that might ease the transition from matlab to python.

If you turn to neuroimaging in python I guess you will first want to go to check the [nipy website](http://nipy.org/) and then turn to [nibabel](http://nipy.org/nibabel/), [nipype](#Nipype), [nilearn](#nilearn), [pyMVPA](#pyMVPA), …



## Web apps (   ???   )


### R based apps
Even if they are not specific to neuroimaging many of the R based web based apps from [shiny apps](http://shinyapps.org/) and [R psychologist](http://rpsychologist.com/) can be very useful to help better understand:
* [p-values](https://www.shinyapps.org/apps/vs-mpr/)
* [confidence intervals](http://rpsychologist.com/d3/CI/)
* [p curves](https://shinyapps.org/apps/p-checker/) and [why with a decent power and a large effect size, it is relatively unlikely to find a value between p<.01 and p<.05](http://rpsychologist.com/d3/pdist/)
* [null hypothesis significance testing](http://rpsychologist.com/d3/NHST/)
* [p hacking](https://www.shinyapps.org/apps/p-hacker/)
* [positive predictive values](http://shinyapps.org/showapp.php?app=https://tellmi.psy.lmu.de/felix/PPV&by=Michael%20Zehetleitner%20and%20Felix%20Sch%C3%B6nbrodt&title=When%20does%20a%20significant%20p-value%20indicate%20a%20true%20effect?&shorttitle=When%20does%20a%20significant%20p-value%20indicate%20a%20true%20effect?)


### Vizualizaton
* the [bioimagesuite](https://bioimagesuiteweb.github.io/webapp/index.html) seems like a convenient way to visualize and do some processing of you images on the fly via a web-browser. (h/t [Renzo](https://twitter.com/layerfmri))


### Anatomy atlases (   ???   )
Some of those might help you learn or revise your neuroanatomy:
* http://www.med.harvard.edu/AANLIB/cases/caseNA/pb9.htm
* http://ghiasi.org/2009/05/10-great-sites-for-reviewing-brain-anatomy/
* http://atlas.brain-map.org/



## BEFORE YOU START: Reproducibility (   ???   )
There are a few options you can investigate to make your analysis more replicable and reproducible. On top of [sharing your data and your code](#Sharing-your-code, data-and-your-results) you can use containers like [docker](https://www.docker.com/) or singularity that allows you to run your analysis in contained environment that has an operating system, the software you need and all their dependencies.

In practice this means that by using this container:
* other researchers can reproduce your analysis **now** on their computer (e.g you can run a linux container with freesurfer on your windows computer),
* you can reproduce your own analysis **in 5 years** from now without facing the problem of knowing which version of the software you used.

[Neurodocker](https://github.com/kaczmarj/neurodocker) allows you to easily create a docker container suited to your needs in terms of neuroimaging analysis. There is nice [tutorial](https://miykael.github.io/nipype_tutorial/notebooks/introduction_neurodocker.html) here on how to use it.

[Code-ocean](https://codeocean.com/) is web based service that relies on docker containers to let you run your analysis online. There is [post](https://www.fmrwhy.com/2018/10/31/reproducible-fmri-codeocean/) by [Stephan Heunis](https://twitter.com/fmrwhy) describing how he did that with an SPM pipeline.

Another thing you can implement is using notebooks like [jupyter](http://jupyter.org/), [jupyter lab](https://jupyterlab.readthedocs.io/en/stable/) or [binder](https://mybinder.org/) (   ???   ). Here is fascinating [talk](https://www.youtube.com/watch?v=zC-3sdPtb0w&list=PLO3l0PnUGHYEqA7rFQT2jM6jxsaC2XiHh&t=384s&index=19) by [Fernando Perez](https://twitter.com/fperez_org), one the person behind the jupyter project.



## BEFORE YOU START: Ethics and consent forms
The [open brain consent form](https://open-brain-consent.readthedocs.io/en/stable/) tries to facilitate neuroimaging data sharing by providing an “out of the box” solution addressing human subjects concerns and consisting of
* widely acceptable consent form allowing deposition of anonymized data to public data archives
* collection of tools/pipelines to help anonymization of neuroimaging data making it ready for sharing



## BEFORE YOU START: Code and data management (   ???   )
In general I suggest you have a look at some of the courses and material offered by the Carpentries for [data](https://datacarpentry.org/) and [code](https://software-carpentry.org/).


### Code management

#### Version control
For managing your code, if you don't already, I suggest you make version control with [GIT](https://git-scm.com/) part of every day your every day workflow. GIT might seem scary and confusing at first but it is well worth the effort: the good news is that there are plenty of tutorials available (for example: [here](http://swcarpentry.github.io/git-novice/), [there](https://www.codecademy.com/learn/learn-git) or [there](https://www.youtube.com/playlist?list=PL0lo9MOBetEHhfG9vJzVCTiDYcbhAiEqL)). Another advantage of using GIT is that it allows you to collaborate on many projects on [github](https://github.com) but which already makes a lot of sense even simply [at the scale of a lab](https://ourcodingclub.github.io/2017/05/15/git-for-labs.html).

Even though GIT is most powerful when using the command line, there are also many [graphic interfaces](https://git-scm.com/downloads/guis/) that might just be enough for what you need. Plus the graphic interface can help you get started to then you move on to use the command line only. There is no shame in using a GUI: just don't tell the GIT purists this is what you do otherwise you will never hear the end of it.

#### Coding style
Another good coding practice to have is a consistent coding style. For python you have the [PEP8 standard](https://www.python.org/dev/peps/pep-0008/) and some tools like [pylint](https://www.pylint.org/), [pycodestyle](https://pypi.org/project/pycodestyle/2.2.0/), or [pep8online](http://pep8online.com/) that help you make sure that your code complies with this standard.

You can also have a look at the code style used by [google for many languages](https://github.com/google/styleguide) (h/t [Kelly Garner](@garner_theory)). You will notice that matlab is not in the list so you might want to check this [here](https://fr.mathworks.com/matlabcentral/fileexchange/46056-matlab-style-guidelines-2-0?s_tid=mwa_osa_a).

#### Avoid selective debugging: unit tests, positive and negative control
Having a bug is annoying. Having your code run but give you an obviously wrong answer is more annoying. Having your code run and give you a plausible but wrong answer is scary (and potentially expensive when it [crashes a spaceship onto a planet](https://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure)). Having your code run and give you the answer you want but not the true answer is the worst and keeps me up at night.

Selective debugging happens when we don't check the code that gives us the answer we want but we do check it when it gives us an answer that goes against our expectation. In a way it is a quite insidious form of p-hacking.

There are some [recent](http://blogs.discovermagazine.com/neuroskeptic/2016/08/21/software-errors-in-fmri/#.V8B1vZ7TU-i) [examples](http://www.russpoldrack.org/2013/02/anatomy-of-coding-error.html) in [neuroimaging](http://the-brain-box.blogspot.com/2013/02/biased-debugging.html).

Some things that can be done about it:
- organize code reviews in your lab: basically make sure that the code has been checked by another person. Pairing a beginner with a more senior member of the lab can also be a way to improve learning and skill transfer in the lab.
- [test your code](http://www.reproducibleimaging.org/module-dataprocessing/06-testing/). These tests can be implemented automatically to your project by continuous integration services like [Travis](https://travis-ci.org/).
- test your pipeline with positive negative control. A negative control is testing your analysis by running on random noise or on data that should have no signal in it. The latter was the approach used by [Anders Eklund](https://twitter.com/wandedob) and [Tom Nichols](https://twitter.com/ten_photos) in their [cluster failure paper series](http://blogs.discovermagazine.com/neuroskeptic/2018/07/22/cluster-failure-revisited/). A positive control is making sure that your analysis can detect VERY obvious things it should detect (e.g motor cortex activation following button presses, classify responses to auditory versus visual stimuli in V1, …). [Jo Etzel](https://twitter.com/JosetAEtzel) has post about [this](https://mvpa.blogspot.com/2015/11/positive-control-analyses-and-checking.html).


### Data: BIDS, Datalad and YODA

#### BIDS
If you are going to do some fMRI analysis you will quickly drown in data if you are not a bit organized, so I highly recommend you use the brain imaging data structure standard ([BIDS](http://bids.neuroimaging.io/)) to organize your data. The current version of BIDS only talks about raw data but it should soon cover derivatives (e.g preprocessed data). In general BIDS also allows you to more easily share your data and use plenty of analytical [tools](bids-apps.neuroimaging.io/apps/).

If you would like to use BIDS but you have no idea what a JSON file or the length of the specification document scares you, head over to the [BIDS starter kit](https://github.com/bids-standard/bids-starter-kit) to find tutorials and scripts to help you rearrange your data.

#### Datalad
[Datalad](https://www.datalad.org/for/data-consumers) is to data what git is to code. It allows curation of data and version controlling of but also lets you crawl databases to explore and download data from them and it facilitates data sharing. Several of these features are described [here](https://www.datalad.org/features.html) with scripts that act as tutorial. There are videos presentation of it [there](https://www.youtube.com/watch?v=59CE6iOr45k).

#### YODA
Having a standard way to organize not only your data but also your code, the results, the documentation... from the beginning of a project can go a long way to save you a lot of time down the line (when communicating within or outside your lab, or when you have to wrap things up when moving to a new project/job). The [YODA template](https://github.com/myyoda/template) is folder structure recommended by [ReproNim](http://www.reproducibleimaging.org/index.html) that you can use.

Other good habits:
* a simple, transparent and systematic filenaming is a good [start](https://www.google.fr/search?q=good+file+naming+conventions&rlz=1C1CHBD_en-GBGB758GB758&oq=good+filenaming+&aqs=chrome.1.69i57j0l3j69i64.6421j0j7&sourceid=chrome&ie=UTF-8)
* if you have to deal with data in spreadsheet I think you will enjoy [this paper](https://www.tandfonline.com/doi/full/10.1080/00031305.2017.1375989) and this [cookbook](https://www.polydesmida.info/cookbook/)

### Documentation (   ???   )
It is often said to:
> Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.

Proper documentation of a project and good commenting of your code will help others to use it or pick it up later. But there are good selfish reasons to document your project and comment your code: it will most likely help future you when you have to respond to reviewers or when you want to check something in that data set or in that function you used 6 months ago.

>- Most likely, you will have to re-run your analysis more than once.
>- In the future, you or a collaborator may have to re-visit part of the project.
>- Your most likely collaborator is your future self, and your past self doesn’t answer emails.

See [here](http://bioconnector.github.io/bims8382/r-repres.html) for more.

There are plenty of recommendations out there about writing documentation. I did find [this one](https://www.divio.com/blog/documentation/) useful and this [list](https://github.com/matiassingers/awesome-readme#tools) or this [checklist](https://github.com/Remi-Gau/readme-checklist) that are more specific to README files.

In terms of code I guess the ideal is [self-documenting code](http://wiki.c2.com/?SelfDocumentingCode). [Read the docs](https://readthedocs.org/) is a good option that also allows for continuous integration.  Python also apparently has this thing called [Sphinx](http://www.sphinx-doc.org/en/master/) that helps *create intelligent and beautiful documentation* (that alone should make matlab users envious). There are also ways to make it part of a [continuous integration](https://predictablynoisy.com/circle-documentation-build).



## PLANNING YOUR STUDY


### Reusing data
Some of the main databases are:
* [OpenNeuro](https://openneuro.org/)
* [neurovault](https://neurovault.org/)
* [BALSA](https://balsa.wustl.edu/)
* [LORIS](https://github.com/aces/Loris/wiki/Open-LORIS)
* [XNAT](https://www.nitrc.org/ir/)
* [Pain repository](https://www.painrepository.org/])

But there are [many](https://brainhack101.github.io/neurolinks/) [possibilities](https://en.wikipedia.org/wiki/List_of_neuroscience_databases) [of](https://www.nitrc.org/search/?type_of_search=group&rows=20&s=relevancy&cat=325%3AData) [databases](https://www.nitrc.org/search/?type_of_search=group&offset=0&removeterm=&cat=313%3ADatabase&compare=&q=&rows=20&s=relevancy&file=%2Ffrs%2Fdownloadlink.php%2F9275&file=%2Ffrs%2Fdownloadlink.php%2F9336&file=%2Ffrs%2Fdownloadlink.php%2F3981&file=%2Ffrs%2Fdownload.php%2F9300%2Fdti_atlas.nrrd&file=%2Ffrs%2Fdownload.php%2F6716%2F3DMetricTools1.4.3-Windows.tar&file=%2Ffrs%2Fdownloadlink.php%2F5884&file=%2Ffrs%2Fdownload.php%2F860%2FLesionSegmentationTutorialData.tgz&file=%2Ffrs%2Fdownloadlink.php%2F10354&file=%2Ffrs%2Fdownload.php%2F7345%2FCONFREP_new_bvecs.zip&file=%2Ffrs%2Fdownload.php%2F5348%2FDemoData.zip&file=%2Ffrs%2Fdownload.php%2F10036%2F7T3T_NITRC.tar.gz&file=%2Ffrs%2Fdownloadlink.php%2F6725&file=%2Ffrs%2Fdownload.php%2F9277%2FLC_prob_atlas_mni05.zip&file=%2Ffrs%2Fdownloadlink.php%2F4074&file=%2Ffrs%2Fdownload.php%2F4969%2FaBEAT.zip&xrowsx=20&s=relevancy) where you can find your raw and/or pre-processed data. Maybe your university or your institute already ahs a repository of published data (e.g the [Donders institute](https://data.donders.ru.nl/?0).

The recent [google extension for databases](https://toolbox.google.com/datasetsearch) can also be useful to locate datasets that might be of interest.

There are some tools that help you search through them like the metasearch tool on the [Open Neuroimaging Laboratory](http://openneu.ro) but this is also where [Datalad](#datalad) can become useful to [browse or crawl those databases](https://www.datalad.org/for/data-discovery).


### Defining your terms and your task


#### Ontologies

> Inigo Montoya: You keep using that word. I don't think it means what you think it means.
> Ayotnom Ogini: Funny you should say that! I was about to tell you the same thing.

The use of alternate and even competitive terminologies can often impede scientific discoveries.

 * [The cognitive atlas](http://www.cognitiveatlas.org/)
 * [The cognitive paradigm ontology](http://www.cogpo.org/)




 * [Declare design]() seems to be something to look into. See what [Dorothy Bishop](https://twitter.com/deevybee) had to say about it.
 * [flexible measures](http://www.flexiblemeasures.com/) by [Malte Elson](https://twitter.com/maltoesermalte)




### Piloting (   ???   )
Good piloting is very important but piloting is not meant to be about finding a hypothesis you want to test: because of the small sample size of pilot studies, anything interesting you see there is very likely to be a fluke. Piloting is more about checking the overall feasibility of that experiment and that you can get high [quality data](#ONCE YOU-HAVE-DATA:-quality-control), judged by criteria that are unrelated to your hypothesis.

[Sam Schwarzkopf](https://twitter.com/sampendu) has a few interesting posts on the topic [here](https://neuroneurotic.net/2016/08/29/on-the-worthlessness-of-inappropriate-piloting/) and [there](https://neuroneurotic.net/2016/08/30/on-the-magic-of-independent-piloting/)

Piloting is usually a phase where it would be good to check with your local MRI physicist and statistician. And you also might already have to make choices about [pre-processing](ONCE-YOU-HAVE-DATA:-preprocessing) and data analysis.


### Pre-registration
If your work is not purely exploratory you might want to consider [pre-registering your study](http://help.osf.io/m/registrations). It is good way to decide in advance how you are going to collect and analyze your data. It helps make it clear to yourself and to others what part of your study was predicted (i.e confirmatory) and which part wasn't (i.e exploratory). This way pre-registration are a good way to restrict the number of researchers degrees of freedom and limit the possibility to engage (most often unknowingly) in questionable research practices like procedural overfitting (also known as p-hacking) or HARKing (Hypothesising After the Results are Known). You can also opt for [registered reports](https://osf.io/8mpji/wiki/home/) where you submit your methods to a journal and get reviews on the protocol before the data collection and analysis is conducted. At the moment there are more than a 140 [journals that accept registered reports](https://cos.io/rr/#journals).

For examples of studies that were pre-registered you can search in the [zotero libraries](https://www.zotero.org/groups/479248/osf/items?) curated by the [open science framework](https://osf.io/).

Pre-registering neuroimaging studies can be quite challenging and comes with a whole set of constraints that might be absent in other fields. [Jessica Flannery](https://twitter.com/j_flan) has created a [template](https://osf.io/6juft/) for pre-registering fMRI studies that you might find useful.


### Optimizing your design
Before you run your study there are a few things you can do to [optimize your design](http://mumfordbrainstats.tumblr.com/post/149759511091/designing-your-pre-fmri-behavioral-study). Two of them are doing a power analysis and optimizing the efficiency of your fMRI design.

#### Design efficiency (   ???   )
If you need a reminder about what [design efficiency](http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency) is.
When you want to optimize it you have few options:
* you can compute the efficiency by hand and tweaking your design [to see what options work best](http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency)
* but there are also more systematic ways to optimize your protocol: see [here](http://surfer.nmr.mgh.harvard.edu/optseq/), [here](http://psych.colorado.edu/~tor/Software/genetic_algorithms.html) or [there](http://www.cabiatl.com/CABI/resources/fmrisim/)

#### Power
> In order to investigate whether an effect exists, one should design an experiment that has a reasonable chance of detecting it. I take this insight as common sense. In statistical language, an experiment should have sufficient statistical power.
> Yet the null [hypothesis significant testing] ritual knows no statistical power.

Gerd Gigerenzer in *Statistical Rituals: The Replication Delusion and How We Got There*, [DOI: 10.1177/2515245918771329](http://journals.sagepub.com/doi/10.1177/2515245918771329)

There is good evidence that the average statistical power has remained low for several decades in psychology which increases the false negative rate and reduces the positive predictive value of findings (i.e the chance that a significant finding is actually true). Maybe neuroimaging could learn from that mistake, especially that a large majority of neuroimaging studies seem to have even lower statistical power.

[fMRI power](http://fmripower.org/) is a matlab based toolbox to help you run your power analysis.

The website [neuropowertools](http://www.neuropowertools.org/) actually offers options to run both your design efficiency optimization and your power analysis. They also have their respective python packages.

#### For MVPA: same analysis approach
If you intend to run a MVPA - classification analysis on your data, there are a few things you can do BEFORE you start collecting data to optimize your design. There is no app/toolbox for that so I am afraid you will have to read the [paper](https://arxiv.org/abs/1703.06670)


### Defining your region of interest (   ???   )
If you don't want to run a whole brain analysis, then you will most likely need to define your regions of interest (ROI). This must be done using data that is independent from the data you will use in the end otherwise you will have a [circularity] (   ???   ) problem (also known as double dipping or [voodoo correlation] (   ???   )).
* around a coordinate identified in a previous study or in a [meta-analysis](#meta-analysis-(   ???   )), or by using Neurosynth.
* using a localizer
* or relying on a functional or anatomical atlas.

#### Using previous results (   ???   )




[Neurosynth](http://neurosynth.org/) can help with to run a meta-analysis to create mask to define your ROI. See for example [this](http://neurosynth.org/analyses/terms/auditory/) if you wanted to have a ROI for brain region matching the search term `auditory` and see here for a [tutorial](http://nbviewer.jupyter.org/github/neurosynth/neurosynth/blob/master/examples/neurosynth_demo.ipynb).




#### Localizers (   ???   )
A typical example of a localizer are retinotopic mappings. [Sam Schwarzkopf](https://twitter.com/sampendu) has good [tutorial](https://figshare.com/articles/Retinotopic_mapping_tutorial/1513839) for those.

#### Atlases
There are many atlases you could use to create ROIS. Some ship automatically with some softwares otherwise you can find lists on the
* [SPM website](https://en.wikibooks.org/wiki/SPM/Atlases)
* [FSL website](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Atlases)
* [AFNI website](https://afni.nimh.nih.gov/Atlases_page)
* [CARET website](http://brainvis.wustl.edu/wiki/index.php/Caret:Atlases)
* [NITRC website](https://www.nitrc.org/search/?type_of_search=group&offset=0&removeterm=&cat=578%3AAtlas+Data&compare=&q=&rows=20&s=relevancy&file=%2Ffrs%2Fdownloadlink.php%2F9275&file=%2Ffrs%2Fdownloadlink.php%2F9336&file=%2Ffrs%2Fdownloadlink.php%2F3981&file=%2Ffrs%2Fdownload.php%2F9300%2Fdti_atlas.nrrd&file=%2Ffrs%2Fdownload.php%2F6716%2F3DMetricTools1.4.3-Windows.tar&file=%2Ffrs%2Fdownloadlink.php%2F5884&file=%2Ffrs%2Fdownload.php%2F860%2FLesionSegmentationTutorialData.tgz&file=%2Ffrs%2Fdownloadlink.php%2F10354&file=%2Ffrs%2Fdownload.php%2F7345%2FCONFREP_new_bvecs.zip&file=%2Ffrs%2Fdownload.php%2F5348%2FDemoData.zip&file=%2Ffrs%2Fdownload.php%2F10036%2F7T3T_NITRC.tar.gz&file=%2Ffrs%2Fdownloadlink.php%2F6725&file=%2Ffrs%2Fdownload.php%2F9277%2FLC_prob_atlas_mni05.zip&file=%2Ffrs%2Fdownloadlink.php%2F4074&file=%2Ffrs%2Fdownload.php%2F4969%2FaBEAT.zip&xrowsx=20&s=relevancy)

Some other retinotopics maps are apparently not listed in the above so here they are:
* An anatomical template of human striate retinotopy (https://cfn.upenn.edu/aguirre/wiki/public:data_currbio_2012_benson)
* The HCP 7T Retinotopy Dataset: data1(https://balsa.wustl.edu/study/show/9Zkk); [data2](https://osf.io/bw9ec/); [paper](https://www.biorxiv.org/content/early/2018/08/30/308247)
* Probabilistic Maps of Visual Topography in Human Cortex: [data](https://scholar.princeton.edu/napl/resources); [paper](https://www.ncbi.nlm.nih.gov/pubmed/25452571)  

The problem then becomes **which atlas to choose**. To help you with this the [Online Brain Atlas Reconciliation](https://www.nitrc.org/projects/obart/) Tool can show the overlap that exist between some of those atlases. The links I had to the website ([here](http://qnl.bu.edu/obart) and [there](http://www.braincircuits.org/human-brain)) are broken at the moment so at least here is a link to the [paper](https://www.ncbi.nlm.nih.gov/pubmed/19787067)

Some toolboxes out there also allow you to create your own ROI and rely on anatomical / cytoarchitectonic atlases:
* [AAL toolbox](http://www.gin.cnrs.fr/en/tools/aal-aal2/)
* [anatomy toolbox](http://www.fz-juelich.de/inm/inm-1/DE/Forschung/_docs/SPMAnatomyToolbox/SPMAnatomyToolbox_node.html)
* [MarsBAR](http://marsbar.sourceforge.net/)


### Non-standard templates (   ???   )
In case you want to normalize brains of children it might be better to use a pediatric template. Some of them are listed [here](https://www.nitrc.org/search/?type_of_search=group&rows=20&s=relevancy&cat=578%3AAtlas+Data).



## ONCE YOU HAVE DATA: quality control




* [quality control on MRI and fMRI](https://practicalfmri.blogspot.com/2014/08/qa-for-fmri-part-3-facility-qa-what-to.html)
* [COBIDacq](https://practicalfmri.blogspot.com/2017/12/cobidacq.html)
* https://en.wikibooks.org/wiki/Neuroimaging_Data_Processing/Data_Quality
* [Neuroimaging quality control task force](https://crossinvalidation.com/2018/07/31/neuroimaging-quality-control-niqc-task-force-to-develop-protocols-tools-and-manuals/)
* [References for quality control](https://www.zotero.org/groups/2221093/niqc)

* [MRIQC](https://mriqc.readthedocs.io/en/stable/) MRI quality control. A BIDS app that runs a pipeline to assess the quality of your data.
* [the PCP Quality Assessment Protocol](https://github.com/BIDS-Apps/QAP) is another BIDS app based on the protocol of [the connectome project data}(http://preprocessed-connectomes-project.org/quality-assessment-protocol/)
* [Scripts for quality control of diffusion data](http://davidroalf.com/script_download/)
* https://github.com/memobc/memolab-fmri-qa




## ONCE YOU HAVE DATA: preprocessing

### Pipelines  (   ???   )
There are some ready made pipeline as [BIDS apps](http://bids-apps.neuroimaging.io/apps/) that already exist and have been tested. Using them might save you time and make your results more reproducible.
* [AFNI based](https://github.com/BIDS-Apps/afni_proc)
* [HCP Pipelines](https://github.com/BIDS-Apps/HCPPipelines): a set of tools (primarily, but not exclusively, shell scripts) for processing MRI images for the Human Connectome Project.
* [fMRIprep](https://fmriprep.readthedocs.io/en/stable/)
* [The NeuroImaging Analysis Kit](https://github.com/BIDS-Apps/niak): NIAK is a library of pipelines for the preprocessing and mining of large functional neuroimaging data.
* [Automatic Analysis](https://github.com/BIDS-Apps/aa): is a [pipeline system for neuroimaging](http://automaticanalysis.org/) written primarily in Matlab. It robustly supports recent versions of SPM, as well as selected functions from other software packages. The goal is to facilitate automatic, flexible, and replicable neuroimaging analyses through a comprehensive pipeline system.
* [nipypelines](https://github.com/BIDS-Apps/nipypelines)
* [Configurable Pipeline for the Analysis of Connectomes](https://github.com/BIDS-Apps/CPAC): C-PAC is a software for performing high-throughput preprocessing and analysis of functional connectomes data using high-performance computers.


There is also an [OPPNI](https://github.com/BIDS-Apps/oppni) for Optimization of Preprocessing Pipelines for NeuroImaging.


### Artefact/Noise removal (   ???   )

#### PCA  (   ???   )

#### ICA  (   ???   )

#### ART (   ???   )

#### ART repair (   ???   )

#### Physiological noise  (   ???   )



## ANALYSIS: general linear model




* a FAQ [article](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3896880/) on the GLM by Cyril Pernet with [matlab code](https://www.frontiersin.org/articles/file/downloadfile/58014_supplementary-materials_datasheets_1_zip/octet-stream/Data%20Sheet%201.ZIP/2/58014) to go through
* see the section on [percent signal change](#percent-signal-change) to better understand how to report results
* orthogonalization of regressors can be a bit hard to wrap your head aroudnd at first but Jeanette Mumford (   ???   ) has great [paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0126255) on the topic with a [jupyter notebook](http://nbviewer.jupyter.org/github/jmumford/orthogonalizaton_ipynb/blob/master/orthogonalization.ipynb).




## ANALYSIS: Resting state (   ???   )




I know almost nothing about resting state but I have been told [this site](http://rfmri.org/) is worth having a look at.
* [Course/Tutorials](http://rfmri.org/Course)
* Tools (   ???   )




## ANALYSIS: Model selection (   ???   )




[Analytical flexibility](http://blogs.discovermagazine.com/neuroskeptic/2012/06/30/false-positive-neuroscience/) is a big [problem in neuroimaging](http://blogs.discovermagazine.com/neuroskeptic/2012/10/14/more-on-false-positive-neuroimaging/) most likely the source of a lot of false positive results.

If several analysis are attempted it can be good to have ways to decide amongst them. There is bad way to do like the one described in the [overfitting toolbox](https://www.researchgate.net/publication/319208937_The_Overfitting_Toolbox_TOT_Large-Scale_Search_in_Model_Space_for_Expected_Neuroimaging_Effects).

But there are better ways to do it:
* The [MACS](https://github.com/JoramSoch/MACS) SPM toolbox by [Joram Soch](https://twitter.com/JoramSoch)
* (   ???   )




## ANALYSIS: Statistical inferences and multiple comparison correction (MCP) (   ???   )


### Cluster based inference (   ???   )


### Family wise error (FWE) (   ???   )




In case you do not remember how random field theory works to correct for multiple comparison, [check this](http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields).




### False discovery rate (FDR) (   ???   )


### Permutation tests (   ???   )

A talk by Carsten Allefeld on permutation test at OHBM 2018: https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/116074


The [prevalence test](https://github.com/allefeld/prevalence-permutation)




#### SnPM (   ???   )
* [website](https://warwick.ac.uk/fac/sci/statistics/staff/academic-research/nichols/software/snpm)

#### FSL PALM and Randomize(   ???   )

#### Freesurfer PALM (   ???   )



## ANALYSIS: Multivariate analysis (   ???   )

A talk by [Pradeep Reedy Raamana]() at OHBM 2018 on cross-validation: https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/116075

Neuroimaging toolboxes for representation similarity analysis (RSA), support vector machine (SVM), population receptive field (pRF), encoding model and others...


### Matlab based

#### TDT
TDT is the The Decoding Toolbox.
* [website](https://sites.google.com/site/tdtdecodingtoolbox/)

#### ProNTo
PRoNTo is the Pattern Recognition for Neuroimaging Toolbox developed at UCL (UK).
* [website](http://www.mlnl.cs.ucl.ac.uk/pronto/prtsoftware.html)
* [manual](http://www.mlnl.cs.ucl.ac.uk/pronto/prtdocs.html)
* [course/tutorial](http://www.mlnl.cs.ucl.ac.uk/pronto/prtcourses.html)

#### RSA toolbox
* [website](https://github.com/rsagroup/rsatoolbox)
* [manual](https://github.com/rsagroup/rsatoolbox/blob/develop/Documentation/toolbox%20documentation.pdf)

#### PCM toolbox
The pattern components modelling toolbox of the [Diedrichsen lab]()
* [website](https://github.com/jdiedrichsen/pcm_toolbox)
* [manual](https://github.com/jdiedrichsen/pcm_toolbox/blob/master/documentation/pcm_toolbox_manual.pdf)

#### cvMANOVA
From [Carsten Allefeld](https://twitter.com/c_allefeld)
* [website](https://github.com/allefeld/cvmanova)

#### SAMSRF
A pRF analysis toolbox called the Seriously Annoying Matlab SuRFer from [Sam Schwarzkopf](https://twitter.com/sampendu).
* [website](https://sampendu.net/seriously-annoying-matlab-surfer/)


### Python based

#### pyMVPA
Intended to ease statistical learning analyses of large datasets.
* [website](http://www.pymvpa.org/)
* [manual](http://www.pymvpa.org/docoverview.html)
* [course/tutorial](http://www.pymvpa.org/tutorial.html)

#### nilearn
Nilearn is a Python module for fast and easy statistical learning on NeuroImaging data.
* [website](http://nilearn.github.io/)
* [manual](http://nilearn.github.io/user_guide.html)
* [course/tutorial](http://nilearn.github.io/introduction.html#python-for-neuroimaging-a-quick-start)

#### Popeye
For pRF analysis.
* [website]https://popeye.readthedocs.io/en/latest/index.html)


### R based (   ???   )



## ANALYSIS: Robustness checks

Non neuroimaging cases
* [multiverse analysis]()
* [specification curves]()


## ANALYSIS: Computational neuroscience



This [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5230746/) comes with [some material](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005142#sec011) to apply bayesian decoding analysis to neuronal data can be of interest.



### Free energy

As someone said on twitter there is a cottage industry of blog posts trying to understand/explain this:
* https://medium.com/@solopchuk/intuitions-on-predictive-coding-and-the-free-energy-principle-3fc5bcedc754
* http://romainbrette.fr/what-is-computational-neuroscience-xxix-the-free-energy-principle/
* https://kaiu.me/2017/06/23/deep-active-inference-for-artificial-general-intelligence/
* http://slatestarcodex.com/2018/03/04/god-help-us-lets-try-to-understand-friston-on-free-energy
* http://www.aliannajmaren.com/2017/07/27/how-to-read-karl-friston-in-the-original-greek/


And a [tutorial](https://medium.com/@solopchuk/tutorial-on-active-inference-30edcf50f5dc)

### Dynamic causal modelling



## ANALYSIS: Laminar and high-resolution MRI
[Renzo Hubert](https://twitter.com/layerfmri) is keeping track of the most recent development of laminar MRI via twitter but also on his [blog](https://layerfmri.com/). He also curates laminar-fMRI related talks on his [Youtube channel](https://www.youtube.com/channel/UCMjtQ3FD41pAh1VJz-UZGJQ/videos) or papers in this [google spreahsheet](https://docs.google.com/spreadsheets/d/1DFdXA98bYPzK5Gf0M_PbNu3opvO-DIcrv7TMP5ywTMk/edit#gid=0).

* This [blog post](https://layerfmri.com/2018/01/04/layer-fmri-software-in-the-field/) has a list of most of the softwares that are related to laminar fMRI.
* A [more recent tool](https://github.com/kwagstyl/surface_tools) not listed in there for creating equivolumetric surfaces.



## ANALYSIS: Meta analysis (   ???   )




a [talk](https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/116072) by [Tom Nichols]() at OHBM 2018 for an [overview](https://figshare.com/articles/Overview_of_Meta-Analysis_Approaches/6723839)
a [practical](https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/116073) by [Camille Maumet]() at OHBM 2018 on meta-analysis: [slides] (   ???   )

a talk on ALE and brainmap
https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/116066


[NiMARE](https://github.com/neurostuff/NiMARE) is a Python library for coordinate- and image-based meta-analysis. [Chris Gorgolewski](https://twitter.com/ChrisFiloG) wrote a [tutorial](https://www.kaggle.com/chrisfilo/coordinate-and-image-metaanalysis-with-nimare) on how to use it.

For coordinate based meta-analysis:
* [brainmap](http://www.brainmap.org/) with [Sleuth](http://www.brainmap.org/software.html#Sleuth) and [GingerALE](http://www.brainmap.org/software.html#GingerALE)


For image based meta-analysis:
* [IBMA](https://github.com/NeuroimagingMetaAnalysis/ibma) is the Image-Based Meta-Analysis toolbox for SPM.




## REPORTING METHODS AND RESULTS (also useful for reviewing papers)


### A checklist: COBIDAS report
The organization from human brain mapping (OHBM) created the Committee on Best practices In Data Analysis and Sharing (COBIDAS) that published a report with a set of [guidelines](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5685169/) with an appended [checklist](https://www.biorxiv.org/content/early/2016/07/10/054262.full.pdf+html) on how to conduct and report fMRI studies. It is a very useful resource to use to make sure you are not forgetting anything when writing up your article.
See also Jeanette Mumford's [video](https://www.youtube.com/watch?v=bsM4KowO5Vc) about it.




* Journal specific requirements or checklists
* [21 words solution] (   ???   )
* [Constraints on generality] (   ???   )
* Other checklists:
  - [here](http://biostat.mc.vanderbilt.edu/wiki/Main/ManuscriptChecklist)
  - http://jonathanpeelle.net/blog/2016/3/23/a-manuscript-checklist-for-improving-science





### Percent signal change (   ???   )




* a FAQ [article](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3896880/) on the GLM by Cyril Pernet with [matlab code](https://www.frontiersin.org/articles/file/downloadfile/58014_supplementary-materials_datasheets_1_zip/octet-stream/Data%20Sheet%201.ZIP/2/58014) to go through has some mention on reporting PSC.
* See also this FSL [guide](http://mumford.bol.ucla.edu/perchange_guide.pdf) by Jeanette Mumford (   ???   ) for reporting results in PSC.
* This [post](http://blogs.warwick.ac.uk/nichols/entry/spm_plot_units/) by Tom Nichols (   ???   ) can be helpful to understand what are the units that SPM paranter estimates are reported in.
* The [MarsBAR](http://marsbar.sourceforge.net/) SPM toolbox can also help you deal with PSC.




### Making figures (   ???   )




I keep hearing that the books by Edward R. Tufte are great
https://www.amazon.com/dp/0961392118/?tag=codihorr-20
https://www.amazon.com/dp/0961392126/?tag=codihorr-20

http://mkweb.bcgsc.ca/essentials.of.data.visualization/
https://www.jisc.ac.uk/full-guide/data-visualisation
https://jimgrange.wordpress.com/2016/06/15/solution-to-barbarplots-in-r/
https://f1000research.com/articles/4-466/v1

* Color maps
color blind friendly

* Dual coded statistical maps
[Code](http://mialab.mrn.org/datavis/) to display beta values and t values on the same map. From the *Data visualization in the neurosciences: overcoming the curse of dimensionality* [paper](https://www.ncbi.nlm.nih.gov/pubmed/22632718).




### Tools to check results/statistics (   ???   )
Those recent tools cannot be applied to statistical maps but they can be useful for any behavioural results. Many of them can be used on a paper you are about to publish to check for errors or on a paper you are reviewing / reading.

* [Statcheck](http://statcheck.io/) developed by automatically checks for errors in statistical reporting making sure that your p values match with your t/F values and degrees of freedom.
* [GRIM test](http://www.prepubmed.org/grim_test/) checks for Granularity-Related Inconsistency of Means. Developed by [Nick Brown](https://twitter.com/sTeamTraen) and [James Heathers](https://twitter.com/jamesheathers) makes sure that the mean reported are plausible given a measurement scale (liek a Likert scale or a visual analog scale) and a sample size. There are [GRIMMER](http://www.prepubmed.org/grimmer/, GRIMMEST extension to standard deviations and F values.
* [SPRITE](https://peerj.com/preprints/26968v1/) stands for Sample Parameter Reconstruction via Iterative TEchniques and allows to generate the possible data distribution given a scale, a mean and variability measure [web app](http://www.prepubmed.org/sprite/), [shiny app](https://steamtraen.shinyapps.io/rsprite/), [code](https://osf.io/pwjad/).


https://shinyapps.org/apps/p-checker/
* p-curves
* test of insufficient variance
* z-curves



### Peer review (   ???   )




* Peer review openness (PRO) initiative to ask for data: https://opennessinitiative.org/






## YOU ARE NOT DONE YET: sharing your code, data and your results
There should be at least 3 boxes on your to do list once your study is completed.
* sharing the code
* sharing the data
* sharing the statistical map
* updating meta-analysis databases
If the 3 first points are done before an article submission it can be useful for reviewers to check what you have done. But all of those points are important also for future researchers that would like to base new research on your results or to run a meta-analysis of similar studies.


### Sharing code
You might be tempted to not [share your code](https://sinews.siam.org/Details-Page/top-ten-reasons-to-not-share-your-code-and-why-you-should-anyway). If your code and/or your jupyter notebooks are on a [github repository](#version-control), you can make snapshot of it to publish on zenodo as explained [here](https://github.com/OpenScienceMOOC/Module-5-Open-Research-Software-and-Open-Source/tree/master/content_development).


### NeuroImaging Data Model (NIDM)
If you want to share your results I suggest you export your final results using the NIDM format that is supported natively by [SPM12](https://github.com/incf-nidash/nidmresults-spm). There are also tools for exporting [FSL](https://github.com/incf-nidash/nidmresults-fsl) results and things are under development for [AFNI](https://github.com/incf-nidash/nidmresults-afni). The NIDM format makes your results easily viewable by other softwares (check the [INCF-NIDASH](https://github.com/incf-nidash) repo for more information). There are extension in development for the NIDM to cover not only non-parametric statistical maps but also to export in very compact way [many of the details of about your experiment and analysis](http://nidm.nidash.org/specs/nidm-experiment_dev.html).

Another good reason to use the NIDM model is that it facilitates uploading them to a site like [neurovault](https://neurovault.org/) where you can store them and share them with others.


### Sharing your data
Some of the main databases where you can put your data are:
* [OpenNeuro](https://openneuro.org/) that
* [neurovault](https://neurovault.org/)
* [BALSA](https://balsa.wustl.edu/)
* [LORIS](https://github.com/aces/Loris/wiki/Open-LORIS)
* [XNAT](https://www.nitrc.org/ir/)
* [Pain repository](https://www.painrepository.org/])

But there are [many](https://brainhack101.github.io/neurolinks/) other [possibilities](https://en.wikipedia.org/wiki/List_of_neuroscience_databases) to share your raw and/or pre-processed data. Maybe your university or your institute has ways to help you share your data (e.g the [Donders institute](https://data.donders.ru.nl/?0).


FAIR data

https://www.pathlms.com/ohbm/courses/8246/sections/12542/video_presentations/115883


### Meta-analysis databases
Another thing you can do to share your published results is to add them to meta-analytical databases like [ANIMA](http://anima.modelgui.org), [brainmap](http://www.brainmap.org/) or [neurosynth](http://neurosynth.org/): for this you could use [brainspell](http://brainspell.org/) and [Scribe](http://www.brainmap.org/software.html#Scribe).
