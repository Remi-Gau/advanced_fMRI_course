
Refresh your maths

If you feel that your background in mathematics and signal processing is a bit weak please have a look at this: Maths4SPM.pdfPreview Maths4SPM.pdfView in a new windowPreview Maths4SPM.pdf

This file has been put up by one of our colleagues and covers several topics that are important to be familiar with:
- Basic linear algebra,
- Ordinary least square solution for the general linear model,
- The BOLD response and convolution: what is a linear time invariant system and why is matters when doing a fMRI study ?
- How to do t-test and ANOVAS within a general linear model.


It can be very helpful for anyone taking this course to be comfortable with the relevant mathematics, such as linear algebra and basic signal processing. Though we do cover these to some degree during the lectures, the below resources may help you to further improve your proficiency in your own time.


    Khan Academy is a great free resource for all sorts of topics. Their series on linear algebra https://www.khanacademy.org/math/linear-algebra. is particularly useful and relevant to our needs. The Fourier series https://www.khanacademy.org/science/electrical-engineering/ee-signals/ee-fourier-series/v/ee-fourier-series-intro. and statistics https://www.khanacademy.org/math/statistics-probability. videos may also prove useful in helping you to understand some of the content of this course.


https://www.mathsisfun.com/algebra/matrix-multiplying.html



    On the physics principle of fMRI and on the artifact you might encounter

http://practicalfmri.blogspot.co.uk/search/label/Contents (Links to an external site.)Links to an external site. (Links to an external site.)Links to an external site.



Experimental designs

You will find more information in this chapter of the SPM manual: Chapter_Experimental_Design.pdf

The "pure insertion assumption" (the assumption that there is no interaction between experimental factors), mentioned in this lecture, is conceptually related to a statistical analysis error that was recently shown to be quite widespread in neuroscience (http://www.nature.com/neuro/journal/v14/n9/full/nn.2886.html). For a lighter read, here are two blog posts about it:

- http://www.theguardian.com/commentisfree/2011/sep/09/bad-science-research-error.
- http://bigthink.com/Mind-Matters/study-a-lot-of-mind-and-brain-research-depends-on-flawed-statistics

When designing an experiment it is also important to remember that many other factors may affect your results: here (http://practicalfmri.blogspot.co.uk/2014/12/concomitant-physiological-changes-as.html)Links to an external site. is a non-exhaustive list of those factors.


Preprocessing

On the importance of head movement correction (the peer reviewed papers are referenced in the blog posts):
- in functionnal connectivty analysis: http://neuroskeptic.blogspot.co.uk/2011/07/brain-connectivity-or-head-movement.html .
- in tractography studies: http://blogs.discovermagazine.com/neuroskeptic/2013/11/26/head-movement-bad-news-neuroscience 
 
On why there might be some residual effects of movement in your data even after realigning (AKA "spin history effect") and why you should always add your realignment parameters as regressors of no interest to correct for that effect: I suggest reading this article (http://cream.fil.ion.ucl.ac.uk/spm/doc/papers/fMRI_1/fMRI_1.pdf) where the following passage is from. 

"Time-dependent changes in a fMRI signal, at a given point in the brain, have many components. This paper is concerned with movement-related components. These components can arise from:
♣ Differences in the position of the object in the scanner Spatial variation in sensitivity will render the signal a function of the object's position at the time of scanning. This spatial variability can include large scale field inhomogeneity or can be expressed at a much finer scale. An important example of the latter is found in slice-selective irradiation, used for example in multi-slice acquisition. The degree to which spins are excited in any small volume of the object will depend on an interaction between the local magnetic field and the Fourier transform of the slice-selective pulse. For example the excitation of spins in a small region on the edge of a slice will be exquisitely sensitive to small displacements in and out of that slice. In other words signal intensity will be a strong function of position relative to the volume excited or the scanner's frame of reference.

♣ Differences due to the history of the position of the object. If the number of excited spins is a function of position in the scanner it follows that the number of excited spins (and implicitly the signal) will also be a function of position in previous scans. This dependency is due to changes in saturation of spin magnetization, that is a function of the number of spins excited in the previous scan. This excitation will in turn be a function of position and so, by induction, a function of all previous positions. In summary the current signal is a function of current position and the spin excitation history. The spin excitation history is in turn determined by the history of past movements. This effect will manifest if the recovery of magnetization in the z direction is incomplete by the time the next slice-selective pulse arrives (i.e. if TR is comparable to T1 which is certainly the case for many fMRI studies). In general movement within the plane of the slice will not change the set of spins excited and should not contribute to this effect."

 
On unwarping : this passage of the SPM manual might help you understand what this problem this preprocessing tries to solve and how it does it.

"EPI images are not particularly faithful reproductions of the object, and in particular there are severe geometric distortions in regions where there is an air-tissue interface (e.g. orbitofrontal cortex and the anterior medial temporal lobes). In these areas in particular the observed image is a severely warped version of reality, much like a funny mirror at a fair ground. When one moves in front of such a mirror ones image will distort in different ways and ones head may change from very elongated to seriously flattened. If we were to take digital snapshots of the reflection at these different positions it is rather obvious that realignment will not suffice to bring them into a common space.
The situation is similar with EPI images, and an image collected for a given subject position will not be identical to that collected at another. We call this effect susceptibility-by-movement interaction. Unwarp is predicated on the assumption that the susceptibility-by- movement inter-action is responsible for a sizable part of residual movement related variance. Assume that we know how the deformations change when the subject changes position (i.e. we know the derivatives of the deformations with respect to subject position). That means that for a given time series and a given set of subject movements we should be able to predict the ”shape changes” in the object and the ensuing variance in the time series. It also means that, in principle, we should be able to formulate the inverse problem, i.e. given the observed variance (after realignment) and known (estimated) movements we should be able to estimate how deformations change with subject movement. We have made an attempt at formulating such an inverse model, and at solving for the ”derivative fields”. A deformation field can be thought of as little vectors at each position in space showing how that particular location has been deflected. A ”derivative field” is then the rate of change of those vectors with respect to subject movement. Given these ”derivative fields” we should be able to remove the variance caused by the susceptibility-by-movement interaction. Since the underlying model is so restricted we would also expect experimentally induced variance to be preserved."

This article (http://www.sciencedirect.com/science/article/pii/S1053811911007245). shows data suggesting it always better to slice-timing correct your data (especially if you have an event-related protocol and long TRs).

Here is a blog post on how running the same analysis on different versions of FSL or different of Mac OS gives... different results:
- http://neuroskeptic.blogspot.co.uk/2012/06/brains-are-different-on-macs.html .

If you are still unclear about how smoothing works and what the match filter theorem is, have a look at the page below. There is also another good visual example of how convolution works.
- http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesSmoothing

Given how many parameters can be changed in the pre-processing pipelines, the number of the researcher's degree of freedom can allow to show quite different results on the same data:
- http://blogs.discovermagazine.com/neuroskeptic/2012/10/14/more-on-false-positive-neuroimaging .

GLM

More information on the implementation of the GLM and the visualization of design matrices in SPM.

- http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesStatistics

This article (http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3896880/)Links to an external site. has some good things to say on the the use of GLM in fMRI and explains in a bit more detail some issues. It also comes with a set of matlab scripts to run some simulations to drive the point home.

Design efficiency

For this course it might good to have in mind what the Fourrier transform is : have a look here (http://practicalfmri.blogspot.co.uk/2011/06/physics-for-understanding-fmri_15.html. Once that is done, you might find the following page quite useful.

- http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency

You can also find tools that allow you to:

calculate the efficiency of a design
- http://www.mrc-cbu.cam.ac.uk/people/rik.henson/personal/analysis/

optimize the efficiency of your designs
- http://surfer.nmr.mgh.harvard.edu/optseq/ 
- http://surfer.nmr.mgh.harvard.edu/optseq/optseq2.help.txt 
- http://psych.colorado.edu/~tor/Software/genetic_algorithms.html 

or simulate fMRI designs
- http://www.cabiatl.com/CABI/resources/fmrisim/ 

Multiple comparison and random field theory

The following page explains the multiple comparison problem we face in neuroimaging and how random field theory is used to solve it.

http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields

 On the downside of using cluster level inferences, this paper (http://www.sciencedirect.com/science/article/pii/S1053811914000020)Links to an external site. has some interesting things to say.
 
 
 
 
 
 Interesting extras: Articles

Here are some articles and similar materials, mostly quite accessible, relating either to specific course content or addressing general issues within the neuroscience community. 

On statistical errors commonly made by neuroscientists:

    Erroneous analyses of interactions in neuroscienceLinks to an external site. http://www.nature.com/neuro/journal/v14/n9/full/nn.2886.html
    The statistical error that just keeps on comingLinks to an external site. http://www.theguardian.com/commentisfree/2011/sep/09/bad-science-research-error
    Study: A lot of mind and brain research depends on flawed statisticsLinks to an external site. http://bigthink.com/Mind-Matters/study-a-lot-of-mind-and-brain-research-depends-on-flawed-statistics
    On the interpretation of removable interactionsLinks to an external site. http://www.ejwagenmakers.com/2012/WagenmakersEtAl2012Loftus.pdf

On the importance of head movement correction...

    ...in functional connectivity analysisLinks to an external site. http://neuroskeptic.blogspot.co.uk/2011/07/brain-connectivity-or-head-movement.html
    ...in tractography researchLinks to an external site. http://blogs.discovermagazine.com/neuroskeptic/2013/11/26/head-movement-bad-news-neuroscience



On spatial smoothing and the matched filter theorem:

    An introduction to smoothing http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesSmoothing

On the General Linear Model:

    Introduction to SPM statistics http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesStatistics
    Misconceptions in the use of the General Linear Model applied to functional MRILinks to an external site. http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3896880/

On the Fourier transform:

    An introduction to the Fourier transform - what it does and how it worksLinks to an external site. http://practicalfmri.blogspot.co.uk/2011/06/physics-for-understanding-fmri_15.html

On design efficiency:

    Design efficiency in fMRI http://imaging.mrc-cbu.cam.ac.uk/imaging/DesignEfficiency
    Rik Henson's MATLAB script for fMRI GLM design efficiency http://www.mrc-cbu.cam.ac.uk/wp-content/uploads/2013/09/fMRI_GLM_efficiency.m
    Optseq optimisation tool for rapid event-related fMRI (advanced)Links to an external site. http://surfer.nmr.mgh.harvard.edu/optseq/
    Genetic algorithm for optimising experimental trial design (advanced)Links to an external site. http://psych.colorado.edu/~tor/Software/genetic_algorithms.html

On random field theory and cluster-level inference:

    Thresholding with random field theory http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields
    Cluster-extent based thresholding in fMRI analysesLinks to an external site. http://www.sciencedirect.com/science/article/pii/S1053811914000020

   On  SPM

        The spm.mat is the file where SPM stores all the information about your analysis, this page (. explains its organization.http://www.its.caltech.edu/~nsulliva/spmdatastructure.htm