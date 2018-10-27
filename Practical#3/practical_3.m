%% adding the spm8 folder and its subfolders to the path so all the spm functions can be called for and used
addpath(genpath('S:/Advanced-Brain-Imaging/spm8/spm8'))


%% -- SPECIFY & ESTIMATE THE DIFFERENT MODELS --

% There are 3 scripts in the practical folder that will create and estimate
% 3 different models of the same data set (the event related protocol of
% the SPM website).
% - model 1) the classical design described in the SPM manual with the HRF, the
% time derivative and the dispersion derivative
% - model 2) the same design but with finite impulse response as basis function
% with one bin per scan. Have a look at the design matrix : before we had 3
% regressors per condition we know have 12 !
% - model 3) a combination of the previous two: one difference though : I did not
% specify different conditions (Repetition and Fame factors) as in the
% other two. I just concatenated the onset vectors of all the different
% conditions. 

% Run the 3 scripts.

% During the model estimation, note Hyperparametes estimation (matrix
% whitnening), and smoothness estimation (the one that is going to be used
% to apply RFT for FWE correction when you are making inferences on your
% data.)

% If you want to see what to has to be changed in the design specification
% betzeen those models, you can do so via the SPM batch interface and
% loading the "First_Level_###.mat" files in the different "Analysis_###" folder
% created by the scripts in the "EventRelated" folder.

% For example compare the model 1 and 2 changing the basis function set is
% fairly easy and you can just do it via the graphic interface under the
% "basis function" section. 

% In model 3, SPM does not allow you to use several sets of basis functions
% so the FIR part of the model has to be added as several user specified
% regressors. Check the "regressor" section via the batch interface.
% Obviously enterint those regressors in your model specification is not
% the kind of thing you want to do by hand ! 


%% -- EXPLORE THE DESIGN MATRIX --
% Click "review" on SPM and select the SPM.mat file created by your design
% specification



%% -- Informed basis set --

% Positive effect of condition 1
% Load the "FIR_model.mat" in the Analysis_FIR folder via the batch interface of SPM
% Modify Target directory 
% In the Subject/Design section specify :
    % - select the "sw*.img" of the EPI folder for the "scans"
    % - select the "all-conditions.mat" for the "multiple condition"
    % - select the "movepars.txt" of the realignment parameters for the
    % "multiple regressors". The File should be in the EPI folder.

% Have a look at the basis function selected

% Save

% Run



% Estimate the model
% MIP
% Results Table
% Brain section
% Go to Maximum
% Render : old style and inflated
% Plot contrast estimate

% Show activated regions with differences with an effect of the repetition
% factor

% Plot event related of the two conditions
% Let's have a look at how SPM does that


%% -- FIR --

% Let us see which where activation follow the canonical HRF

xBF.dt = 1;
xBF.name = 'hrf (with time and dispersion derivatives)';
xBF.length = 32;
xBF.order = 1;
xBF = spm_get_bf(xBF)

all = xBF.bf(2:2:24,:)';

can = all(1,:);
tem = all(2,:);
dis = all(3,:);

% Do a T contrast with the following weight vectors
Can_Vector = repmat(can,1,4);
Can_And_Temp_Vector = repmat(can+tem,1,4);
Can_Minus_Disp_Vector = repmat(can-dis,1,4);

% Look for the maximal activation and plot the contrast estimate with the F
% contrast : repmat(eye(12),1,4)


% We can model any shape of BOLD response :
% Do a t comntrast with weight of ones(1,12*4)
% Look for activation with a 0.05 theshold and look at the shape of the
% BOLD response in the eyes !!!
% The trade off : the variance of each beta estimate is much higher so it
% is much more difficult to get something significant.
