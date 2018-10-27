%% adding the spm8 folder and its subfolders to the path so all the spm functions can be called for and used
addpath(genpath('S:/Advanced-Brain-Imaging/spm8/spm8'))

% entering the directory where you've got the images
cd('S:/Advanced-Brain-Imaging/Practical#1/EventRelated/')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - what is an image?
% - what type of images are there?
% - what type of images does spm use?
% - dicom import
% - spm images are in neurological space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% entering the spm interface
% just write "spm" in the command window and select fmri
% you can also just write directly "spm fmri" and it will lead you directly
% to the interface for fmri anaylsis

% Exploring with SPM
% - display button
% - check reg button


%% using some of the spm functions
% it can be useful to look and use directly some of the spm functions, 
% which you can find in the spm folder. you can get more information about 
% each function by typing " open 'function_name' ".
% this site gives you an overview on some of the most useful functions: 
% http://en.wikibooks.org/wiki/SPM/Programming_intro
% we'll try some of them out here.

% going to the EPIs directory
cd('S:/Advanced-Brain-Imaging/Practical#1/EventRelated/rawepi/RawEpi')

% - look at the images you've got
% - missing images: accounting for T1 equilibration effects
%   you always acquire dummie volumes at the beginning of your scanning
%   that you will discard in the end


% 1) spm_vol: read hdr information from the images. 
%    you can do this for just one image or for many images simultaneously 

% one image at a time
imgInfo = spm_vol('sM03953_0005_0006.img');

% to look at more than one one image at a time you need to create a matrix
% with the images you are interested in
imgsMat = ['sM03953_0005_0006.img';
           'sM03953_0005_0007.img';
           'sM03953_0005_0008.img';];
       
imgsInfo = spm_vol(imgsMat);

% 2) spm_get_space: gets the voxel to world (mm) transformation matrix
% directly
transf_matrix = spm_get_space('sM03953_0005_0006.img');

% so if you want to transform voxel coordinates in world coordinates you
% just have to do:
voxel_coord = [7 9 8 1];                    %just as an example
mm_coord = transf_matrix*voxel_coord';

% similarly if you want to transform from world coordinates to voxel
% coordinates you do:
mm_coord2 = [-28 -16 21 1];
voxel_coord2 = inv(transf_matrix)*mm_coord2';

% now lets see this in the spm interface.
% type in the command window spm fmri
% click diplay and select 'sM03953_0005_0006.img'
% in the crosshair position in the graphics window and change the
% coordinates accordingly



% 3) spm_read_vols: using the header information given by spm_vol reads in
%    entire image volumes
volume = spm_read_vols(imgInfo);
volume_withHole = volume;
volume_withHole(25:32,25:32,8:14) = 0;

% 4) spm_write_vol: writes an image volume to disk
newImgInfo = imgInfo;

% Change the name in the header
newImgInfo.fname = 'volume_created.nii';
newImgInfo.private.dat.fname = newImgInfo.fname;

spm_write_vol(newImgInfo,volume_withHole);

% 5) spm_matrix:  returns an affine transformation matrix given a certain
% vector of parameters 
% P(1)  - x translation
% P(2)  - y translation
% P(3)  - z translation
% P(4)  - x rotation about - {pitch} (radians)
% P(5)  - y rotation about - {roll}  (radians)
% P(6)  - z rotation about - {yaw}   (radians)
% P(7)  - x scaling
% P(8)  - y scaling
% P(9)  - z scaling
% P(10) - x affine
% P(11) - y affine
% P(12) - z affine


% translating an image in the x direction
P_xtranslation = zeros(12,1);
P_xtranslation(1) = 14;

xtranslation = spm_matrix(P_xtranslation,'T');
volume_xtranslation = xtranslation * transf_matrix;

% getting the header information of the original image
imgInfo_xtranslated = imgInfo;

% and change the name and the transformation matrix in the header
imgInfo_xtranslated.fname = 'volume_xtranslated.nii';
imgInfo_xtranslated.private.dat.fname = imgInfo_xtranslated.fname;
imgInfo_xtranslated.mat = volume_xtranslation;

spm_write_vol(imgInfo_xtranslated,volume);

% rotating an image about the x direction (pitch)
P_xrotation = zeros(12,1);
% spm works with radians, so if you want to rotate the image by 14 degrees
% you have to transform it to radians first
P_xrotation(4) = 14*pi/180; 

xrotation = spm_matrix(P_xrotation,'R');
volume_xrotated = xrotation * transf_matrix;

imgInfo_xrotated = imgInfo;
imgInfo_xrotated.fname = 'volume_xrotated.nii';
imgInfo_xrotated.private.dat.fname = imgInfo_xrotated.fname;
imgInfo_xrotated.mat = volume_xrotated;

spm_write_vol(imgInfo_xrotated,volume);

% use "check reg" button and select all three images to see what happened
% you can also use the spm interface to reorient images


%% THE SPM PIPELINE

cd('S:/Advanced-Brain-Imaging/Practical#1/EventRelated/')

% always save each step you do. might be useful to look at it: in case
% something goes wrong you can check what went wrong at each step

%% Realignment - removing movement artifacts in the data

% - first image that you specify in the list is taken as to reference to
%   which all the other images will be aligned to
% - if you ask for it a mean image will be created
% - a txt file including the 6 movement parameters will be created. you can
%   include these movement parameters as regressors in your GLM design
% - general (not strict) rule: movement should be less than voxel size

RealignParametersFile = dir('S:/Advanced-Brain-Imaging/Practical#1/EventRelated/rawepi/RawEPI/*.txt');
name = ['S:/Advanced-Brain-Imaging/Practical#1/EventRelated/rawepi/RawEPI/', RealignParametersFile(1).name];
RealignParameters = load(name);
    

figure(2)
subplot(211)
plot(1:length(RealignParameters(:,2)), RealignParameters(:,1), 'b',1:length(RealignParameters(:,2)), RealignParameters(:,2), 'g',1:length(RealignParameters(:,2)), RealignParameters(:,3), 'r')
    
subplot(212)
plot(1:length(RealignParameters(:,2)), RealignParameters(:,4), 'b',1:length(RealignParameters(:,2)), RealignParameters(:,5), 'g',1:length(RealignParameters(:,2)), RealignParameters(:,6), 'r')


%% Spatial Normalization - bringing brains to a common anatomical space
% Normalization can be performed in to ways: 
%   - unified segmentation - more accurate
%     (necessary to co-register and segment images first)
%   - normalizing to a template

%% Coregistration - registers images from different modalities using mutual information theory

% generally is a good idea that your images are more or less aligned
% already before you do the coregistration. you could do this by manually
% reorienting the images with the reorient button. for instance try to but
% the AC at the (0,0,0) in both types of images

% Look at joint histograms
%       1.	same structural
%       2.	structural vs structural shifted
%       3.	structural vs structural blurred  
%       4.	EPI1 vs EPI2 of the same series
%       5.	structural vs EPI

%% Segmentation

% look at the probability maps
% perform segmentation

%% Normalization revisited

% create a folder called in the folder of the structural scan called "NormalizeWithTemplate"
% copy the structural scan to this folder
% perform normalization using unified segmentation and the template
% look at both results simultaneously

%% Smoothing 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show video http://www.ucl.ac.uk/stream/media/swatch?v=1d42446d1c34
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% fMRI Design specification

% load the stimulus onset times
% generally you would like to save your onset times in a .mat file in an 
% ordered fashion that is easy to read afterward
load('sots.mat')

% create directory in which you want to save your analysis
mkdir('FFX_categorical')

% - specify 1st level - categorical
% - review button
% - estimate design matrix
% - look at the SPM.mat structure (to have details about the structure look
%                                  at spm_spm.m)
% - results
%       - overlays: sections, rend
%       - statistcs table
%       - plot parameters estimates

% plotting parameter estimates yourself
% after plotting them with spm a variable named "contrast" is created
figure;
bar(contrast.contrast); 
hold on;
errorbar(1:length(contrast.contrast), contrast.contrast, contrast.standarderror,'.');
axis([0 length(contrast.contrast)+1 -30 60]);

% parametric model
% make a new directory
mkdir('FFX_parametric')



%% Note:
% we used the spm interface to do all this steps buy clicking on the
% respective button of what we wanted to do. SPM also has a batch option 
% that allows you to perform all steps sequentially. Alternatively you can
% also use the structure that comes out of this batch (if you save it) to
% write your own scripts

