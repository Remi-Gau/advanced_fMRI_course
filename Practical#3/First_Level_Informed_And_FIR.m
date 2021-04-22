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
spm_jobman('initcfg');
spm_get_defaults;
global defaults

%%
clc;
clear;

cd EventRelated;

TargetDirectory = 'EPI';

if exist(strcat(TargetDirectory), 'dir') == 0
    error('There should be a folder EPI with the prepocessed images in it. Did you rename it or move it ? Alternatively you could change the name of the variable "Target directory"');
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

AnalysisFolder = strcat(pwd, filesep, 'Analysis_Informed_And_FIR', filesep);

if exist(strcat('Analysis_Informed_And_FIR'), 'dir') == 0
    mkdir Analysis_Informed_And_FIR;
end

% List the images
cd (ImagesFolder);
IMAGES_ls = dir('swars*.img');
if length(IMAGES_ls) == 0
    error('There are no images');
end

% Lists the realignement parameters file
Mov_Parameter_ls = dir('rp_*.txt');
if length(IMAGES_ls) == 0
    error('Could not find the realignment parameter file.');
end

cd ..;

% Creates one vector with all the onsets concatenated
load all-conditions.mat;

Onset = [];
for i = 1:size(onsets, 2)
    Onset = [Onset; onsets{1, i}];
end
Onset = sort(Onset);

% Creates regressors for the FIR part of the model
Onset(:, 2) = round(Onset(:, 1));
FIR_Regressors = zeros(length(IMAGES_ls) + 12, 12);

for i = 1:length(Onset(:, 2))
    FIR_Regressors(Onset(i, 2) + 1:Onset(i, 2) + 12, :) = FIR_Regressors(Onset(i, 2) + 1:Onset(i, 2) + 12, :) + eye(12);
end

FIR_Regressors = FIR_Regressors(1:length(IMAGES_ls), :);

fprintf('\n\n');
disp('%%%%%%%%%%%%%%%%%%%%%%');
disp('   Define the batch   ');
disp('%%%%%%%%%%%%%%%%%%%%%%');

% First : the model specification
matlabbatch = {};

matlabbatch{1, 1}.spm.stats.fmri_spec.dir{1, 1} = AnalysisFolder;

matlabbatch{1, 1}.spm.stats.fmri_spec.timing.units = 'scans';
matlabbatch{1, 1}.spm.stats.fmri_spec.timing.RT = TR;
matlabbatch{1, 1}.spm.stats.fmri_spec.timing.fmri_t = NbSlices;
matlabbatch{1, 1}.spm.stats.fmri_spec.timing.fmri_t0 = ReferenceSlice;

% -- Session specific infornation --
% Names the images with their absolute pathnames
for j = 1:length(IMAGES_ls)
    matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).scans{j, 1} = [ImagesFolder, filesep, IMAGES_ls(j).name];
end

% Specify just one condition
matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).cond(1, 1).name = 'Face';
matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).cond(1, 1).duration = 0;
matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).cond(1, 1).tmod = 0;
matlabbatch{1, 1}.spm.stat.fmri_spec.sess(1, 1).cond(1, 1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).cond(1, 1).onset = Onset(:, 1);

% Specify the FIR regrssors
for j = 1:12
    matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).regress(1, j).name = strcat('FIR_', num2str(j));
    matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).regress(1, j).val = FIR_Regressors(:, j);
end

matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).multi{1} = '';

% Realignment parameters
matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).multi_reg{1} = strcat(ImagesFolder, filesep, Mov_Parameter_ls.name);

matlabbatch{1, 1}.spm.stats.fmri_spec.sess(1, 1).hpf = HPF;

% -- Basis function used --
matlabbatch{1, 1}.spm.stats.fmri_spec.bases.hrf.derivs = [1, 1]; % First is time derivative, Second is dispersion

matlabbatch{1, 1}.spm.stats.fmri_spec.volt = 1;

matlabbatch{1, 1}.spm.stats.fmri_spec.global = 'None';

matlabbatch{1, 1}.spm.stats.fmri_spec.mask = {''};

matlabbatch{1, 1}.spm.stats.fmri_spec.cvi = 'AR(1)';

% Second : the model estimation
matlabbatch{1, end + 1} = {};

matlabbatch{1, end}.spm.stats.fmri_est.spmmat{1, 1} = [AnalysisFolder, 'SPM.mat'];     % set the spm file to be estimated

matlabbatch{1, end}.spm.stats.fmri_est.method.Classical = 1;

cd(AnalysisFolder);

% ALWAYS SAVE THE BATCH !!!!!!!!!!!!!
save (strcat('First_Level_Informed_And_FIR_jobs'));

cd (StartDirectory);

%%
fprintf('\n\n');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('   Run model specification and estimation   ');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

% Once we've defined the batch we can run the spm_jobman function
spm_jobman('run', matlabbatch);
