# How to script with SPM

## Why use scripts?

Scripting your preprocessing and your analyis is a good way to [save time](https://external-preview.redd.it/xGS3CBRs2u3ujufXLZS6oCbB-9cCAFy_xuWxOFSjD4c.png?auto=webp&s=9a14526bbd5503dee65554baca74faa0b5681a64), improve reproducibility and avoid human errors.

![](.statics/geek_VS_non-geek.jpg)

But remember that it can also be a pretty efficient way to get some systematic errors that are [hard to track down](http://xkcd.com/1319/).

![](.statics/automation.png)


## How to actually write SPM scripts?

It is usually easier to start creating batches via the graphic interface. Many ressources are available on-line to help you getting started writing your own batch with SPM, see for example [here](http://en.wikibooks.org/w/index.php?title=SPM/Batch&stable=0). SPM also has a `batches` folder that contains examples that can be interesting. Once you have created a batch, save it using `File --> Save batch and script`. This will create a matlab .m file that you can start using to build your own scripts.

[Stephan Heunis](https://twitter.com/fmrwhy) has a great series of [posts](https://www.fmrwhy.com/2018/06/28/spm12-matlab-scripting-tutorial-1/) on how to script using matlab and SPM with the code available [here](https://github.com/jsheunis/matlab-spm-scripts-jsh/blob/master/spm_batchScriptingExample_jsh.m).

In the `How2SCript` folder are 2 matlab .m files that show you what typical SPM scripts look like. I have commented those files to give more explanations and advices, but if something is unclear or does not work, let me know.

1. `Realign_batch.m`

This script runs the preprocessing "realign and write" function from SPM. It uses the raw EPI files from the block design data set from the SPM [website](ftp://ftp.fil.ion.ucl.ac.uk/spm/data/MoAEpilot/MoAEpilot.zip). Unzip the file in a folder, put this script in the same folder and it should run.

2. `First_Level_Design_and_Estimate_batch.m`

This scripts shows how to specify a design for a first-level (subject level) analysis. It uses the raw EPI files from the [event related design data set](ftp://ftp.fil.ion.ucl.ac.uk/spm/data/SPM00AdvEFMRI) from the SPM website with [the "all-conditions.mat" file](http://www.fil.ion.ucl.ac.uk/spm/data/face_rep/) of the same data set. Preprocess the images (see the chapter 29 of the SPM manual) and then put the preprocessed images and the realignment parameters "rp.txt" in a folder called "EPI". Put this script, the "all-conditions.mat" in the parent directory of this "EPI" folder and it should run.
