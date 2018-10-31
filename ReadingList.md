# Reading list


*Here, we outline the basic areas of knowledge that we think are essential to becoming an expert at fMRI analysis, roughly in order of importance.*

1. *Probability and statistics. There is probably no more important foundation for fMRI analysis than a solid background in basic probability and statistics. Without this, nearly all of the concepts that are central to fMRI analysis will be foreign.*
2. *Computer programming. It is our opinion that one simply cannot become an effective user of fMRI analysis without strong computer programming skills. There are many languages that are useful for fMRI analysis, including MATLAB, Python, and UNIX shell scripting. The particular language is less important than an underlying understanding of the methods of programming, and this is a place where practice really does make perfect, particularly with regard to debugging programs when things go wrong.*
3. *Linear algebra. The importance of linear algebra extends across many different aspects of fMRI analysis, from statistics (where the general inear model is most profitably defined in terms of linear algebra) to image processing (where many operations on images are performed using linear algebra). A deep understanding of fMRI analysis requires basic knowledge of linear algebra.*
4. *Magnetic resonance imaging. One can certainly analyze fMRI data without knowing the details of MRI acquisition, but a full understanding of fMRI data requires that one understand where the data come from and what they are actually measuring. This is particularly true when it comes to understanding the various ways in which MRI artifacts may affect data analysis.*
5. *Neurophysiology and biophysics. fMRI signals are interesting because they are an indirect measure of the activity of individual neurons. Understanding how neurons code information, and how these signals are reflected in blood flow, is
crucial to interpreting the results that are obtained from fMRI analysis.*
6. *Signal and image processing. A basic understanding of signal and image processing methods is important for many of the techniques discussed in this book. In particular, an understanding of Fourier analysis is very useful for nearly every aspect of fMRI analysis.*


http://jonathanpeelle.net/mri-reading-list
https://www.scienceopen.com/search#collection/873f3e77-23c2-4586-bf82-9985a55a0894
https://www.fil.ion.ucl.ac.uk/spm/doc/spmbib.html

**Table of Contents**

* [Refresh your maths](#Refresh-your-maths)
* [Refresh your physics](#)
* [Reproducibility](#Reproducibility)
* [Data sharing](#)
* [analytic flexibility](#)
* [Experimental design](#)
* [Power](#Power)
* [Design efficiency](#)
* [Realignement](#Realignement)
* [Unwarping](#Unwarping)
* [Slice timing](#)
* [Scrubbing](#Scrubbing)
* [Smoothing](#Smoothing)
* [Preprocessing](#Preprocessing)
* [Quality control](#)
* [GLM](#GLM)
* [Correction for multiple comparisons](#)
* [Effect size and percent signal change](#)
* [Circularity](#Circularity)
* [Anatomical localization](#)
* [Multivariate analysis](#)
* [High-resolution MRI](#)
* [Reporting](#Reporting)
* [Meta analysis](#)



## Refresh your maths

If you feel that your background in mathematics and signal processing is a bit weak please have a look at [these slides](https://figshare.com/s/be5a73a1e0a31fb9b6ed). This file has been put up by Joana Leitao and covers several topics that are important to be familiar with:
* basic linear algebra
* ordinary least square solution for the general linear model
* the BOLD response and convolution: what is a linear time invariant system and why is matters when doing a fMRI study ?
* how to do t-test and ANOVAS within a general linear model

Khan Academy is a great free resource for all sorts of topics. Their series on [linear algebra](https://www.khanacademy.org/math/linear-algebra) is particularly useful and relevant to our needs. The Fourier [series](https://www.khanacademy.org/science/electrical-engineering/ee-signals/ee-fourier-series/v/ee-fourier-series-intro) and [statistics](https://www.khanacademy.org/math/statistics-probability) videos may also prove useful in helping you to understand some of the content of this course.

An introduction to the Fourier transform - what it does and how it. http://practicalfmri.blogspot.co.uk/2011/06/physics-for-understanding-fmri_15.html


## Refresh your biophysics

On the physics principle of fMRI and on the artifact you might encounter http://practicalfmri.blogspot.co.uk/search/label/Contents

When designing an experiment it is also important to remember that many other factors may affect your results: here (http://practicalfmri.blogspot.co.uk/2014/12/concomitant-physiological-changes-as.html). is a non-exhaustive list of those factors.



## Reproducibility

Here is a blog post on how running the same analysis on different versions of FSL or different of Mac OS gives... different results:
- http://neuroskeptic.blogspot.co.uk/2012/06/brains-are-different-on-macs.html .



## Data sharing



## Analytic flexibility

Given how many parameters can be changed in the pre-processing pipelines, the number of the researcher's degree of freedom can allow to show quite different results on the same data:
- http://blogs.discovermagazine.com/neuroskeptic/2012/10/14/more-on-false-positive-neuroimaging .



## Experimental design

You will find more information in this chapter of the SPM manual: Chapter_Experimental_Design.pdf

The "pure insertion assumption" (the assumption that there is no interaction between experimental factors), mentioned in this lecture, is conceptually related to a statistical analysis error that was recently shown to be quite widespread in neuroscience (http://www.nature.com/neuro/journal/v14/n9/full/nn.2886.html). For a lighter read, here are two blog posts about it:

- http://www.theguardian.com/commentisfree/2011/sep/09/bad-science-research-error.
- http://bigthink.com/Mind-Matters/study-a-lot-of-mind-and-brain-research-depends-on-flawed-statistics



## Power



## Design efficiency



## Realignement
On the importance of head movement correction (the peer reviewed papers are referenced in the blog posts):
- in functionnal connectivty analysis: http://neuroskeptic.blogspot.co.uk/2011/07/brain-connectivity-or-head-movement.html .
- in tractography studies: http://blogs.discovermagazine.com/neuroskeptic/2013/11/26/head-movement-bad-news-neuroscience
On why there might be some residual effects of movement in your data even after realigning (AKA "spin history effect") and why you should always add your realignment parameters as regressors of no interest to correct for that effect: I suggest reading this article (http://cream.fil.ion.ucl.ac.uk/spm/doc/papers/fMRI_1/fMRI_1.pdf) where the following passage is from.

*Time-dependent changes in a fMRI signal, at a given point in the brain, have many components. This paper is concerned with movement-related components. These components can arise from:*
* *Differences in the position of the object in the scanner Spatial variation in sensitivity will render the signal a function of the object's position at the time of scanning. This spatial variability can include large scale field inhomogeneity or can be expressed at a much finer scale. An important example of the latter is found in slice-selective irradiation, used for example in multi-slice acquisition. The degree to which spins are excited in any small volume of the object will depend on an interaction between the local magnetic field and the Fourier transform of the slice-selective pulse. For example the excitation of spins in a small region on the edge of a slice will be exquisitely sensitive to small displacements in and out of that slice. In other words signal intensity will be a strong function of position relative to the volume excited or the scanner's frame of reference.*
* *Differences due to the history of the position of the object. If the number of excited spins is a function of position in the scanner it follows that the number of excited spins (and implicitly the signal) will also be a function of position in previous scans. This dependency is due to changes in saturation of spin magnetization, that is a function of the number of spins excited in the previous scan. This excitation will in turn be a function of position and so, by induction, a function of all previous positions. In summary the current signal is a function of current position and the spin excitation history. The spin excitation history is in turn determined by the history of past movements. This effect will manifest if the recovery of magnetization in the z direction is incomplete by the time the next slice-selective pulse arrives (i.e. if TR is comparable to T1 which is certainly the case for many fMRI studies). In general movement within the plane of the slice will not change the set of spins excited and should not contribute to this effect.*



## Unwarping

On unwarping : this passage of the SPM manual might help you understand what this problem this preprocessing tries to solve and how it does it.

"EPI images are not particularly faithful reproductions of the object, and in particular there are severe geometric distortions in regions where there is an air-tissue interface (e.g. orbitofrontal cortex and the anterior medial temporal lobes). In these areas in particular the observed image is a severely warped version of reality, much like a funny mirror at a fair ground. When one moves in front of such a mirror ones image will distort in different ways and ones head may change from very elongated to seriously flattened. If we were to take digital snapshots of the reflection at these different positions it is rather obvious that realignment will not suffice to bring them into a common space.
The situation is similar with EPI images, and an image collected for a given subject position will not be identical to that collected at another. We call this effect susceptibility-by-movement interaction. Unwarp is predicated on the assumption that the susceptibility-by- movement inter-action is responsible for a sizable part of residual movement related variance. Assume that we know how the deformations change when the subject changes position (i.e. we know the derivatives of the deformations with respect to subject position). That means that for a given time series and a given set of subject movements we should be able to predict the ”shape changes” in the object and the ensuing variance in the time series. It also means that, in principle, we should be able to formulate the inverse problem, i.e. given the observed variance (after realignment) and known (estimated) movements we should be able to estimate how deformations change with subject movement. We have made an attempt at formulating such an inverse model, and at solving for the ”derivative fields”. A deformation field can be thought of as little vectors at each position in space showing how that particular location has been deflected. A ”derivative field” is then the rate of change of those vectors with respect to subject movement. Given these ”derivative fields” we should be able to remove the variance caused by the susceptibility-by-movement interaction. Since the underlying model is so restricted we would also expect experimentally induced variance to be preserved."



## Slice timing
This article (http://www.sciencedirect.com/science/article/pii/S1053811911007245). shows data suggesting it always better to slice-timing correct your data (especially if you have an event-related protocol and long TRs).



## Scrubbing



## Smoothing
If you are still unclear about how smoothing works and what the match filter theorem is, have a look at the page below. There is also another good visual example of how convolution works.
- http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesSmoothing



## Preprocessing



## Quality control



## GLM
More information on the implementation of the GLM and the visualization of design matrices in SPM.

- http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesStatistics

This article (http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3896880/)Links to an external site. has some good things to say on the the use of GLM in fMRI and explains in a bit more detail some issues. It also comes with a set of matlab scripts to run some simulations to drive the point home.



## Correction for multiple comparisons
The following page explains the multiple comparison problem we face in neuroimaging and how random field theory is used to solve it.

http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields

On the downside of using cluster level inferences, this paper (http://www.sciencedirect.com/science/article/pii/S1053811914000020)Links to an external site. has some interesting things to say.



## Effect size and percent signal change



## Circularity



## Anatomical localization



## Multivariate analysis



## High-resolution MRI



## Reporting

A short article on to make better figures (with links to some matlab code): Data Visualization in the Neurosciences: Overcoming the Curse of Dimensionality (http://www.sciencedirect.com/science/article/pii/S089662731200428X.

This blog post has also some additional (http://practicalfmri.blogspot.co.uk/2012/07/methods-reporting-in-fmri-literature.html. interesting (http://practicalfmri.blogspot.co.uk/2012/10/draft-checklist-for-fmri-methods.html. suggestions.

An interesting paper that shows how little information is sometimes provided by authors : The secret lives of experiments: Methods reporting in the fMRI literature (http://www.sciencedirect.com/science/article/pii/S1053811912007057



## Misc

Here are some articles and similar materials, mostly quite accessible, relating either to specific course content or addressing general issues within the neuroscience community.

On statistical errors commonly made by neuroscientists:

Erroneous analyses of interactions in neuroscienceLinks to an external site. http://www.nature.com/neuro/journal/v14/n9/full/nn.2886.html

The statistical error that just keeps on comingLinks to an external site. http://www.theguardian.com/commentisfree/2011/sep/09/bad-science-research-error

Study: A lot of mind and brain research depends on flawed statisticsLinks to an external site. http://bigthink.com/Mind-Matters/study-a-lot-of-mind-and-brain-research-depends-on-flawed-statistics

On the interpretation of removable interactionsLinks to an external site. http://www.ejwagenmakers.com/2012/WagenmakersEtAl2012Loftus.pdf
