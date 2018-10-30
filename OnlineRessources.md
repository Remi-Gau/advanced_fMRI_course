# On-line ressources

**Table of Contents**
* [Online courses](#Online-courses)
* [Video series](#Video-series)
* [Blogs](#Blogs)
* [Methods and results reporting](#Methods-and-results-reporting)
* [Code and data management](#Code-and-data-management)
* [Where to ask for help](#Where-to-ask-for-help)


---


There are tons of resources neuroimaging data analysis on-line so the following list is not meant to be exhaustive. There are also similar lists here and there that might partly overlap with this one.

* [Stephan Heunis](https://twitter.com/fmrwhy) has a [list](https://www.fmrwhy.com/2018/06/28/spm12-matlab-scripting-tutorial-4/) to many SPM and matlab related ressources 
* [Jonathan Peelle](@jpeelle) has a great [list of ressources ](http://jonathanpeelle.net/mri-resources-for-beginners) for beginners
* [https://github.com/brainhack101](https://github.com/brainhack101) also has a good [collections or links](https://brainhack101.github.io/neurolinks/) to courses, data...
* ReproNim has a good [site](http://www.reproducibleimaging.org/index.html) to check for ressources on how to get up to date on doing reproducible research



## Online courses

There are quite a few courses out there that I am aware of. Also most of the main analysis softwares have at least one video series that works as a course +/- turorial.

### Coursera

[Tor Wager](@torwager) and Martin Lindquist offer a 2 parts MOOC on coursera.

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

### Neurohackademy
Neurohackademy is not exactly a beginner's course for fMRI: it is broader than that as it covers reproducibility amd open science issues in neuroimaging. It is also very practical and definitely more python oriented. To know more see this [post](http://www.talyarkoni.org/blog/2018/08/16/neurohackademy-2018-a-wrap-up/) by [Tal Yarkoni](https://twitter.com/talyarkoni) about the 2018 edition of Neurohackademy.

* [videos to the edition 2017/2018](https://www.youtube.com/playlist?list=PLA6PlfxWZPLTLJ2qTN9enG0tkizpmwWaq)
* [videos to the edition 2016](https://www.youtube.com/playlist?list=PLEdFhTRBFLObkatJOX9wp3BCueH4wNSl7)
* [2018 course material](https://github.com/neurohackademy)



## Video series

### mumfordbrainstats

Jeanette Mumford has a fantastic series of videos on neuroimaging analysis on [youtube](https://www.youtube.com/channel/UCZ7gF0zm35FwrFpDND6DWeA). The channel also has [facebook group](https://www.facebook.com/groups/mumfordbrainstats/) (as well as a [tumblr](http://mumfordbrainstats.tumblr.com/) and [twitter account](https://twitter.com/mumbrainstats) ) if you have questions.

### Andrew Jahn
[Here](https://www.youtube.com/user/Shala5ha5ka) for the videos but he also as a [blog](https://www.andysbrainblog.com/) (see the old version [here](http://andysbrainblog.blogspot.com)). He has some very good follow along for FSL, Freesurfer and AFNI amongst other things.

### Center for Brains, Minds and Machines
[Here](https://www.youtube.com/channel/UCGoxKRfTs0jQP52cfHCyyRQ)

### Organization from human brain mapping (OHBM)
The videos of the lectures and workshops from the previous HBM conferences are available online [here](https://www.pathlms.com/ohbm/courses).

### fMRIf summer courses from the NIH
[Here](https://fmrif.nimh.nih.gov/public/fmri-course/)



## Blogs

There are quite a few descent blogs run by neuroscientists where you can find interesting and more or less technical information on neuroimaging analysis. I list a few below but you can find a subsample of my neuroscience blogroll in the file `blogroll_a_sample.opml` that you can import into your favorite news reader (e.g [feedly](https://feedly.com)).

* [Jo Etzel](https://twitter.com/JosetAEtzel) has a great blog if you want to know more about multivariate analysis: [MVPA meandering](http://mvpa.blogspot.co.uk) 
* [Chris Chambers](https://twitter.com/chrisdc77) blog is [Neurochambers](http://neurochambers.blogspot.co.uk) (
* [Neuroskeptic](https://twitter.com/Neuro_Skeptic) blogs at [Neuroskeptic](http://blogs.discovermagazine.com/neuroskeptic/) 
* [practiCal fMRI](https://twitter.com/practiCalfMRI) has a great [blog](http://practicalfmri.blogspot.co.uk) with posts that cover the basics of fMRI, MRI artifacts, as well as a all the things that can affect the BOLD signal 
* [Russel Poldracks](https://twitter.com/@russpoldrack) posts can be found [here](http://www.russpoldrack.org)
* [The clever machine](https://theclevermachine.wordpress.com/category/fmri/) has some very useful posts with matlab codes for fMRI analysis
* [Peter Bandettini](https://twitter.com/fMRI_today) blogs at [the brain blog](http://www.thebrainblog.org)



## Methods and results reporting

The OHBM created Committee on Best Practices in Data Analysis and Sharing (COBIDAS) that published a report with a set of [guidelines](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5685169/) with an appended [checklist](https://www.biorxiv.org/content/early/2016/07/10/054262.full.pdf+html) on how to conduct and report fMRI studies. See also Jeanette Mumford's [video](https://www.youtube.com/watch?v=bsM4KowO5Vc) about it.
       


## Code and data management

If you are going to do some fMRI analysis you will quickly drown in data if you are not a bit organized so I highly recommend you use the brain imaging data structure standard ([BIDS](http://bids.neuroimaging.io/)) to organize your data. This also allows you to more easily share your data and use plenty of [tools](bids-apps.neuroimaging.io/apps/).

As for managing your code, if you don't already I suggest you make version control with [GIT](https://git-scm.com/) part of every day workflow. GIT might seem scary and confusing at first but it is well worth the effort: the good news is that there are plenty of tutorials available to learn.



## Where to ask for help

Most software specific questions are usually [best adressed on the mailing list](https://kirstiewhitaker.com/2014/12/16/how-to-use-the-fsl-and-freesurfer-mailing-lists-for-success-in-your-phd/) related to that software. But if you have more general questions you can also try :

* the slack channel of [brainhack](https://www.brainhack.org/)
* the [neurostars](https://neurostars.org/) forum