% AN EXAMPLE OF SCRIPT FOR DESIGNING AND ESTIMATING A MODEL
%
% It uses the EPI files from the event related design data set from the SPM
% website (ftp://ftp.fil.ion.ucl.ac.uk/spm/data/SPM00AdvEFMRI/rawepi.zip)
% with the "all-conditions.mat" file of the same data set.
% (http://www.fil.ion.ucl.ac.uk/spm/data/face_rep/all-conditions.mat)

% Put the preprocessed images and the realignment parameters "rp*.txt" in a
% folder called "EPI", put this script, the "all-conditions.mat" in the 
% parent directory of this "EPI" folder and it should run.

%%
spm_jobman('initcfg')
spm_get_defaults;
global defaults

%%
clc
clear

cd EventRelated

TargetDirectory = 'EPI';

if exist(strcat(TargetDirectory),'dir')==0
    error('There should be a folder EPI with the prepocessed images in it. Did you rename it or move it ? Alternatively you could change the name of the variable "Target directory"')
end

% Acquisition and slice timing parameters
TR = 2;
NbSlices = 24;
ReferenceSlice = 12;

% High Pass Filter
HPF = 128;

% Defines and create some directory
StartDirectory = pwd;

ImagesFolder = strcat(pwd, filesep, TargetDirectory, filesep);

AnalysisFolder = strcat(pwd, filesep, 'Analysis_FIR', filesep);

if exist(strcat('Analysis_FIR'),'dir')==0
	mkdir Analysis_FIR;
end;

% List the images
cd (ImagesFolder)
IMAGES_ls = dir('swars*.img');
if length(IMAGES_ls)==0
    error('There are no images')
end

% Lists the realignement parameters file
Mov_Parameter_ls = dir('rp_*.txt');
if length(IMAGES_ls)==0
    error('Could not find the realignment parameter file.')
end

cd (StartDirectory)

fprintf('\n\n')
disp('%%%%%%%%%%%%%%%%%%%%%%')
disp('   Define the batch   ')
disp('%%%%%%%%%%%%%%%%%%%%%%')

% First : the model specification
matlabbatch ={};


matlabbatch{1,1}.spm.stats.fmri_spec.dir{1,1} = AnalysisFolder;


matlabbatch{1,1}.spm.stats.fmri_spec.timing.units = 'scans';
matlabbatch{1,1}.spm.stats.fmri_spec.timing.RT = TR; 
matlabbatch{1,1}.spm.stats.fmri_spec.timing.fmri_t = NbSlices;
matlabbatch{1,1}.spm.stats.fmri_spec.timing.fmri_t0 = ReferenceSlice;


% -- Session specific infornation --
% Names the images with their absolute pathnames
for j = 1:length(IMAGES_ls)
    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).scans{j,1} = [ImagesFolder, filesep, IMAGES_ls(j).name];
end

matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond = struct('name',{},'val',{});

matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).regress = struct('name',{},'val',{});

matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).multi{1} = strcat(pwd, filesep, 'all-conditions.mat');

matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).multi_reg{1} = strcat(ImagesFolder, filesep, Mov_Parameter_ls.name);
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).hpf = HPF;


% -- Factorial design --
matlabbatch{1,1}.spm.stats.fmri_spec.fact(1).name = 'Fam';
matlabbatch{1,1}.spm.stats.fmri_spec.fact(1).levels = 2;

matlabbatch{1,1}.spm.stats.fmri_spec.fact(2).name = 'Rep';
matlabbatch{1,1}.spm.stats.fmri_spec.fact(2).levels = 2;


% -- Basis function used --
matlabbatch{1,1}.spm.stats.fmri_spec.bases.fir.length = 24; 
matlabbatch{1,1}.spm.stats.fmri_spec.bases.fir.order = 12; 

matlabbatch{1,1}.spm.stats.fmri_spec.volt = 1;


matlabbatch{1,1}.spm.stats.fmri_spec.global = 'None';


matlabbatch{1,1}.spm.stats.fmri_spec.mask = {''};


matlabbatch{1,1}.spm.stats.fmri_spec.cvi = 'AR(1)';



%Second : the model estimation
matlabbatch{1,end+1}={};


matlabbatch{1,end}.spm.stats.fmri_est.spmmat{1,1} = [AnalysisFolder, 'SPM.mat'];     %set the spm file to be estimated


matlabbatch{1,end}.spm.stats.fmri_est.method.Classical = 1;


cd(AnalysisFolder)

% ALWAYS SAVE THE BATCH !!!!!!!!!!!!!
save (strcat('First_Level_FIR_jobs'));

cd (StartDirectory)

%%
fprintf('\n\n')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('   Run model specification and estimation   ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

% Once we've defined the batch we can run the spm_jobman function
spm_jobman('run', matlabbatch)

cd ..


