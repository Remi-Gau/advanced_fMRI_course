% AN EXAMPLE OF SCRIPT FOR THE REALIGN & WRITE FUCNTION
%
% It uses the raw EPI files from the block design data set from the SPM
% website (ftp://ftp.fil.ion.ucl.ac.uk/spm/data/MoAEpilot/MoAEpilot.zip).
% Unzip the file in a folder, put this script in the same folder and it
% should run.

clc;
clear;

% spm fmri

spm_jobman('initcfg');
spm_get_defaults;
global defaults

EPI_Folder = 'fM00223';

if exist(EPI_Folder, 'dir') == 0
    error 'Could not find the folder where the raw EPI images are stored. \n This folder shoulder be called fM00223. If you have changed its name, specify a new name foe the variable EPI_Folder at the beginning of this script.';
end

StartDirectory = pwd;

cd (EPI_Folder);

% List all the images present a creates a cell with the absolute path of
% all the images
ImagesList = dir('f*.img');
for j = 1:length(ImagesList)

    % A general advice : use absolute pathname as much as possible and prefer
    % the "filesep" function to specifying the directory separator specific to
    % you operating system. Similarly you can use the "fullfile" function.
    % This is just a genral rule to increase the portability of your script.

    Images2Process{j, 1} = [pwd, filesep, ImagesList(j).name, ',1'];
    % Images2Process{j,1} = fullfile(pwd, [ImagesList(j).name, ',1'];

end

% spm_jobman is the function that runs all the things you can do on the
% graphic interface of SPM. It always take a structure called "matlabbatch"
% as an input.

% ------------------------------ %
%     DEFINES    MALATBATCH      %
% ------------------------------ %

matlabbatch = {};

% To know what you have to put in this structure one possible way to do it
% is to do everything via the graphic interface (Clicking "realign",
% filling all the required fields of the batch editor...) and save the
% batchttp://www.mathworks.com/matlabcentral/fileexchange/13831-structure-displayh. Then load the file you've just saved : it contains the matlabbatch
% structure that you are interested in.

% If you want to know quickly what are the all fields you structure
% contain, I suggest using the "fn_strucdisp.m" fucntion that you can find
% on the matlab website
% (http://www.mathworks.com/matlabcentral/fileexchange/13831-structure-display)
% that will automatically list all the fields at once. Usually the names of
% the fields are pretty transparent... but not always ! Most of the time
% you can easily what field does what by having a look at the graphic
% interface in parallel.

matlabbatch{1, 1}.spm.spatial.realign.estwrite.data{1, 1} = Images2Process; % Imput here the cells of the images we ant to change.

% Options concerning the estimation of the realignment
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.quality = 1;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1, 1}.spm.spatial.realign.estwrite.eoptions.weight = '';

% Options concerning the estimation of the realignment
matlabbatch{1, 1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1, 1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1, 1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1, 1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

% ALWAYS SAVE THE BATCH !!!!!!!!!!!!! It will make it easier for you to
% know what you did to those poor images.
save (strcat('Realign_matlabbatch'), 'matlabbatch');

fprintf('\n\n');
disp('%%%%%%%%%%%%%%%%');
disp('   REALIGNING   ');
disp('%%%%%%%%%%%%%%%%');

cd (StartDirectory);

% Once we've defined the batch we can run the spm_jobman function
spm_jobman('run', matlabbatch);

% A final note : you can define several task to be done one after the other
% the same matlabbatch but incrementing from matlabbatch{1,i} to
% matlabbatch{1,i+1}.
