%% adding the spm8 folder and its subfolders to the path so all the spm functions can be called for and used
addpath(genpath('S:/Advanced-Brain-Imaging/spm8/spm8'))


%% -- SPECIFY THE DESIGN MATRIX --

% Load the "First_Level.mat" via the batch interface of SPM
% Modify Target directory 
% In the Subject/Design section specify :
    % - select the "sw*.img" of the EPI folder for the "scans"
    % - select the "all-conditions.mat" for the "multiple condition"
    % - select the "movepars.txt" of the realignment parameters for the
    % "multiple regressors". The File should be in the EPI folder.
    
% Save

% Run



%% -- EXPLORE THE DESIGN MATRIX --
% Click "review" on SPM and select the SPM.mat file created by your design
% specification
% Notice : each condition with canonical, temporal and dispersion
% derivatives ; realignement parameters ; session specific constant ;
% parameters estimability

% Manually load SPM.mat
% To explore the structure of SPM.mat this webpage can help : 

% http://www.its.caltech.edu/~nsulliva/spmdatastructure.htm


% View the design matrix
% The design matrix is stored as SPM.xX.X
figure(2) % The figure 1 is  by default the SPM figure window. We open another one not to overwrite its content
colormap(repmat(linspace(0,1,10)',1,3)) % Just for decoration
imagesc(SPM.xX.X)


% View the high pass filter matrix
% The high pass filter matrix is stored as SPM.xX.K.X0
figure(3)
colormap(repmat(linspace(0,1,10)',1,3))
imagesc(SPM.xX.K.X0)
% Change value of the high pass filter to 200 seconds in the batch interface, redesign the model and have a look at
% the same high pass filter matrix


% Explore one of the condition (Design --> Eplore --> Session 1 --> ...)
figure(4)
subplot(311)
plot(SPM.xX.X(:,1),'b') % Canonical of first condition
subplot(312)
plot(SPM.xX.X(:,2),'r') % Temp derivative of the first condition
subplot(313)
plot(SPM.xX.X(:,3),'g') % Dispersion derivative of the first condition



%% -- A bit more on the HRF --
HRF = spm_hrf(1); % Gives the shape of the HRF with a sampling frequency of 1 Hz

xBF.dt = 0.01; % Temporal resolution in seconds of the informed basis set you are going to create
xBF.name = 'hrf (with time and dispersion derivatives)';
xBF.length = 32; % Length of the HRF in seconds
xBF.order = 1;
xBF = spm_get_bf(xBF) % Creates the informed basis set

figure(5)
hold on ;
plot(xBF.bf(:,1),'b') % Canonical HRF
plot(xBF.bf(:,2),'r') % Temporal derivative of the HRF
plot(xBF.bf(:,3),'g') % Dispersion derivative of the HRF

figure(6)
hold on ;
plot(xBF.bf(:,1),'b') % Canonical HRF
plot(xBF.bf(:,1)+xBF.bf(:,2),'r') % HRF + Temporal derivative of the HRF
plot(xBF.bf(:,1)-xBF.bf(:,2),'g') % HRF - Temporal derivative of the HRF

figure(7)
hold on ;
plot(xBF.bf(:,1),'b') % Canonical HRF
plot(xBF.bf(:,1)+xBF.bf(:,3),'r') % HRF + Dispersion derivative of the HRF
plot(xBF.bf(:,1)-xBF.bf(:,3),'g') % HRF - Dispersion derivative of the HRF



%% -- Plot frequency spectrum --
% We go from the time domain to the frequency domain by using the fast 
% Fourrier transform function
figure(8)
gX = abs( fft(SPM.xX.X(:,1)) )
% abs : Absolute value because FFT returns complex numbers where the real 
% part of these represent the magnitude and the imaginary
% part is the phase of each frequency
plot(1:fix(length(gX)/2), gX(1:fix(length(gX)/2)))

% NOTE
% You can see more detail in this SPM function spm_fMRI_design_show.m
% Line 87 and onwards : "Trial-specific regressors - frequency domain"
% Similarly you can have a look % SOME EXAMPLE ON PURE SINE MAYBEat : 

% http://spm.martinpyka.de/?p=24

% NOTE
% If you want to go back from frequency domain to time domain use inverse 
% fast Fourrier transform function : ifft


% Create an onset vector of random event and its representation in the
% frequency domain
RndOns = [ones(1,10) zeros(1,2*50)]; 
RndOns = RndOns(randperm(length(RndOns)));

figure(9)
% SOME EXAMPLE ON PURE SINE MAYBE
subplot(211)
stem(RndOns)
title('Time domain');
xlabel('Seconds')

subplot(212)

gX = abs(fft(RndOns)).^2; % Gets the power
gX = gX./sum(gX); % Normalises the values

q = length(gX)/2;
Hz = linspace(0,q,q);

plot(Hz,gX(1:q));

title('Frequency domain');
xlabel('Frequency (Hz)')
ylabel('relative spectral density')


% Have a look at the HRF and how it is reprented in the frequency domain
HRF = spm_hrf(1);

figure(10)

subplot(211)
plot(HRF)
title('Time domain');
xlabel('Seconds')

subplot(212)

gX = abs(fft(HRF)).^2;
gX = gX./sum(gX);

q = fix(length(gX)/2);
Hz = linspace(0,q,q)

plot(Hz,gX(1:q));

xlabel('Frequency (Hz)')
ylabel('relative spectral density')
title('Frequency domain');

% Convolve the onset vector with the HRF and have a look in time and
% frequency domain
ConvOns = conv(HRF,RndOns);

figure(11)

subplot(211)
hold on
plot(ConvOns, 'r')
stem(RndOns, 'b')
title('Time domain');

subplot(212)

gX = abs(fft(ConvOns)).^2;
gX = gX./sum(gX);

q = fix(length(gX)/2);
Hz = linspace(0,q,q)

plot(Hz,gX(1:q));

xlabel('Frequency (Hz)')
ylabel('relative spectral density')
title('Frequency domain');

% ADDIOTNAL EXAMPLES : START WITH SOME EXAMPLES ON PURE SINE MAYBE,
% CONVOLUATION IS DONE AT A HIGHER RESOLUTION AND THEN DOWN-SAMPLED,
% LIMITATIONS OF THIS EXAMPLE (TR OF 1 SEC)...



%% -- Orthogonality & Efficiency --

% Orthogonality

HRF = spm_hrf(1);

Block=repmat([zeros(15,1) ; ones(5,1)],10,1); % Creates a vector of a 10 blocks
DesignMatrix = conv(HRF,Block); % Convolve it witht the HRF

EventDeter=repmat([zeros(3,1) ; ones(1,1)],50,1); % Creates a vector of a 50 events equally spaced
DesignMatrix(:,end+1) = conv(HRF,EventDeterministic); % Convolve it witht the HRF

% Add 20 vectors of convolved random onsets to our design matrix
for i=1:20
    RndOns = Block(randperm(length(Block)));
    DesignMatrix(:,end+1) = conv(HRF,RndOns);
end

% Display the design matrix
figure(12)
colormap(repmat(linspace(0,1,10)',1,3))
imagesc(DesignMatrix)

% Compute the orthogonality between the different regressors
% Found in the SPM help : for 2 regressors a and b the orthogonality(a,b) = [a' * b / ( sum(a.^2) * sum(b.^2) )^.5];
[a b] = size(DesignMatrix);
Orthogonality=[];
for i=1:b
    for j=1:b
        Orthogonality(i,j) = [DesignMatrix(:,i)' * DesignMatrix(:,j) / ( sum(DesignMatrix(:,i).^2) * sum(DesignMatrix(:,j).^2) )^.5];
    end
end

% Display the orthogonality matrix
figure(13)
colormap(repmat(linspace(1,0,10)',1,3))
imagesc(Orthogonality)

% NOTE
% Look at the design matrix of your experiment.
% Notice the correlation between the different realignment parameters
% Look for potential correlation between regressors (between conditions or
% between realignment and conditions)

% NOTE
% Why add realignment parameters as additional regressors ?
% http://onlinelibrary.wiley.com/doi/10.1002/mrm.1910350312/abstract


% Efficiency

% Link between the T test formula and the Efficiency

% NOTE
% t = c'*beta / sqrt( sigma^2 * c' * (X'*X)^-1 * c')
% c is the contrast of interest
% X is the design matrix
% sigma^2 is the error variance and therefore the only term that is data
% dependent

% Efficiency of c'*beta is therefore proportional 1 / (c' * (X'*X)^-1 * c')

% Let us look at the efficiency of the block regressor
Constrast = [1 zeros(1, b-1)];
Efficiency = (Constrast*inv(DesignMatrix'*DesignMatrix)*Constrast' )^-1

% NOTE
% Remember that the efficiency has no unit and is a relative unit

% Let's see the efficiency of each of our regressors
C = eye(b); 
Efficiency = [];
for k=1:b
    Efficiency(k) = (C(k,:)*inv(DesignMatrix'*DesignMatrix)*C(k,:)' )^-1;
end

% NOTE
% One can also look at the efficiency of certain differential contrast :
% for example Constrast = [1 -1 zeros(1, b-2)];
% If one wants to look at the overall efficiency for several contrasts, they
% should all be expressed in one matrix :
% C = [1 zeros(1, b-1) ; 1 -1 zeros(1, b-2)]
% and use the following formula :
% Efficiency(k) = trace( C*inv(DesignMatrix'*DesignMatrix)*C' )^-1;

% Let's check which contrast have the highest and the lowest efficiency 
% and plot them
[Values,Indexes] = sort(Efficiency); % sorts the regressors according to their efficiency

figure(14)
hold on
plot(DesignMatrix(:,Indexes(1)),'b') % Least efficient (deterministic event)
plot(DesignMatrix(:,Indexes(end)),'r') % Most efficient (most likely block design)
plot(DesignMatrix(:,Indexes(fix(b/2))),'g') % Middle efficiency

% ADDITIONAL IDEAS : AVERAGE EFFICIENCY OF MANY RANDOM VECTORS, OF
% STOCHASTIC ONES...



%% -- Estimate design --

% Estimate button, select SPM.mat and run

% Note Hyperparametes estimation : matrix whitnening

% Positive effect of condition 1

% Multiple comparison corrections : next lecture but see
% http://imaging.mrc-cbu.cam.ac.uk/imaging/PrinciplesRandomFields

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


%% -- Estimating the Shape of the BOLD response : FIR --

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

% Have a look at the design matrix : before we had 3 regressors per
% condition we know have 12 !

% Estimate the model

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
