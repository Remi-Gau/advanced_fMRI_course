%% Convolution in time is point wise multiplication in frequencies
clear all; close all; clc;

% Create the onset vector of our block design
OnsetVector = repmat([zeros(6*7,1) ; ones(6*7,1)], 8, 1);

% The following lines give us the frequencies present in this onset vector
% Gets the power of the signal
gX = abs(fft(OnsetVector)).^2; 
% Normalises the values
gX = gX./sum(gX); 

% Gets the range of frenquencies present in the signal
q = numel(gX)/2; 
Hz = linspace(0,q,q);

% Plot
figure('name', 'Block design', ...
    'Position', [100, 100, 1500, 1000])

subplot(321)
plot(OnsetVector)
title('Time domain');
ylabel('Neural activation');
xlabel('Time (Seconds)')
axis([0 700 -.2 1.5])

subplot(322)
plot(Hz,gX(1:q));
axis([0 30 0 max(gX)])
title('Frequency domain');
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')


% Create a typical HRF at 1 s resolution
HRF = spm_hrf(1);

%  Just like above we get the frequencies present in this onset vector
gX_HRF = abs(fft(HRF)).^2;
gX_HRF = gX_HRF./sum(gX_HRF);
q = length(gX_HRF)/2;
Hz = linspace(0,q,q);

subplot(323)
plot(HRF)
xlabel('Time (Seconds)')
ylabel('HRF');

subplot(324)
plot(Hz,gX_HRF(1:q));
axis([0 30 0 max(gX_HRF)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')


%  We convolve our onset vector with the HRF and get frequency spectrum of the result
Regressor = conv(OnsetVector, HRF);

gX_Reg = abs(fft(Regressor)).^2; %
gX_Reg = gX_Reg./sum(gX_Reg);
q = length(gX_Reg)/2;
Hz = linspace(0,q,q);

subplot(325)
plot(Regressor)
xlabel('Time (Seconds)')
ylabel('Regressor');
axis([0 700 -.2 1.5])

subplot(326)
plot(Hz,gX_Reg(1:q));
axis([0 30 0 max(gX_Reg)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')



% Same with a slow event related experiment
OnsetVector = repmat([ones(1,1); zeros(16,1)], 8, 1);

gX = abs(fft(OnsetVector)).^2;
gX = gX./sum(gX);
q = length(gX)/2;
Hz = linspace(0,q,q);

figure('name', 'slow event related', ...
    'Position', [100, 100, 1500, 1000])

subplot(321)
plot(OnsetVector)
title('Time domain');
ylabel('Neural activation');
xlabel('Time (Seconds)')
axis([0 140 0 1])

subplot(322)
plot(Hz,gX(1:q));
axis([0 60 0 max(gX)])
title('Frequency domain');
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')


% HRF
HRF = spm_hrf(1);

gX_HRF = abs(fft(HRF)).^2;
gX_HRF = gX_HRF./sum(gX_HRF);
q = length(gX_HRF)/2;
Hz = linspace(0,q,q);

subplot(323)
plot(HRF)
xlabel('Time (Seconds)')
ylabel('HRF');

subplot(324)
plot(Hz,gX_HRF(1:q));
axis([0 60 0 max(gX_HRF)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')


% Regressor
Regressor = conv(HRF,OnsetVector);

gX_Reg = abs(fft(Regressor)).^2;
gX_Reg = gX_Reg./sum(gX_Reg);
q = length(gX_Reg)/2;
Hz_Reg = linspace(0,q,q);

subplot(325)
plot(Regressor)
xlabel('Time (Seconds)')
ylabel('Regressor');
axis([0 140 min(Regressor) max(Regressor)])

subplot(326)
plot(Hz_Reg,gX_Reg(1:q));
axis([0 60 0 max(gX_Reg)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')



%% Efficiency
clear all; close all; clc;

HRF = spm_hrf(1);

% Block design
Block = [zeros(8,1); ones(16,1); zeros(8,1)];
ConvBlock = conv(Block,HRF);
gX_Block = abs(fft(ConvBlock)).^2;
gX_Block = gX_Block./sum(gX_Block); 
q_Block = length(gX_Block)/2;
Hz_Block = linspace(0,q_Block,q_Block);

% Slow event related design
SlowEventVector = repmat([ones(1,1) ; zeros(20,1)], 16, 1);
ConvSlowEventVector = conv(SlowEventVector,HRF);
gX_Slow = abs(fft(ConvSlowEventVector)).^2;
gX_Slow = gX_Slow./sum(gX_Slow); 
q_Slow = length(gX_Slow)/2;
Hz_Slow = linspace(0,q_Slow,q_Slow);

% Fast event related design
FastEventVector = repmat([ones(1,1) ; zeros(7,1)], 16, 1);
ConvFastEventVector = conv(FastEventVector,HRF);
gX_Fast = abs(fft(ConvFastEventVector)).^2;
gX_Fast = gX_Fast./sum(gX_Fast); 
q_Fast = length(gX_Fast)/2;
Hz_Fast = linspace(0,q_Fast,q_Fast);

% Jittered fast event related design
RandOnsetVector = FastEventVector(randperm(length(FastEventVector)));
ConvRandOnsetVector = conv(RandOnsetVector,HRF);
gX_Rand = abs(fft(ConvRandOnsetVector)).^2;
gX_Rand = gX_Rand./sum(gX_Rand); 
q_Rand = length(gX_Rand)/2;
Hz_Rand = linspace(0,q_Rand,q_Rand);


% Let us look at the efficiency of the different types of regressor
Constrast = [1;0];

X = [ConvBlock ones(length(ConvBlock),1)];
EfficiencyBlock = (Constrast'*inv(X'*X)*Constrast )^-1;

X = [ConvSlowEventVector ones(length(ConvSlowEventVector),1)];
EfficiencySlow = (Constrast'*inv(X'*X)*Constrast )^-1;

X = [ConvFastEventVector ones(length(ConvFastEventVector),1)];
EfficiencyFast = (Constrast'*inv(X'*X)*Constrast )^-1;

X = [ConvRandOnsetVector ones(length(ConvRandOnsetVector),1)];
EfficiencyRandom = (Constrast'*inv(X'*X)*Constrast )^-1;

% Plot the different results with their efficiency
figure('name', 'Different design', 'Position', [100, 100, 1500, 1000])

subplot(421)
plot(ConvBlock)
title('Time domain');
xlabel('Time (Seconds)')
ylabel('Block')

subplot(422)
plot(Hz_Block,gX_Block(1:q_Block));
axis([0 q_Block 0 max(gX_Block)])
title('Frequency domain');
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')
text(q_Block/2,max(gX_Block)/2, sprintf('Efficiency= %2.2f', EfficiencyBlock))

subplot(423)
plot(ConvSlowEventVector)
xlabel('Time (Seconds)')
ylabel('Slow')

subplot(424)
plot(Hz_Slow,gX_Slow(1:q_Slow));
axis([0 q_Slow 0 max(gX_Slow)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')
text(q_Slow/2,max(gX_Slow)/2, sprintf('Efficiency= %2.2f', EfficiencySlow))

subplot(425)
plot(ConvFastEventVector)
xlabel('Time (Seconds)')
ylabel('Fast')

subplot(426)
plot(Hz_Fast,gX_Fast(1:q_Fast));
axis([0 q_Fast 0 max(gX_Fast)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')
text(q_Fast/2,max(gX_Fast)/2, sprintf('Efficiency= %2.2f', EfficiencyFast))

subplot(427)
plot(ConvRandOnsetVector)
xlabel('Time (Seconds)')
ylabel('Fast Jittered')

subplot(428)
plot(Hz_Rand,gX_Rand(1:q_Rand));
axis([0 q_Rand 0 max(gX_Rand)])
xlabel('Frequency (Hz)')
ylabel('Relative spectral density')
text(q_Rand/2,max(gX_Rand)/2, sprintf('Efficiency= %2.2f', EfficiencyRandom))



%% Permutation test
clear all; close all; clc;

Mean1_Grp1 = 30;
Std1_Grp1 = 25;
Mean2_Grp1 = 80;
Std2_Grp1 = 20;

Mean1_Grp2 = 20;
Std1_Grp2 = 40;
Mean2_Grp2 = 80;
Std2_Grp2 = 80;

NbPerm = 10000;

% Creates a set of data for group 1 made of a mixture of 2 gaussians
Grp1_A = randn(1000,1)*Std1_Grp1 + Mean1_Grp1;
Grp1_B = randn(1000,1)*Std2_Grp1 + Mean2_Grp1;
Grp1 = [Grp1_A ; Grp1_B];

% Creates a set of data for group 2 made of a mixture of 2 gaussians
Grp2_A = randn(1000,1)*Std1_Grp2 + Mean1_Grp2;
Grp2_B = randn(1000,1)*Std2_Grp2 + Mean2_Grp2;
Grp2 = [Grp2_A ; Grp2_B];

% Plot the 2 original groups
figure('name', 'Permutation tests', 'Position', [100, 100, 1500, 1000])
subplot(221)
hist(Grp1,100)
subplot(223)
hist(Grp2,100)

% Compute the t-value associated to the difference between those 2 groups
T_Data = (mean(Grp1) - mean(Grp2)) / sqrt( var(Grp1)/(numel(Grp1)-1) + var(Grp2)/(numel(Grp2)-1) )

% for te set number of permutation
for i=1:NbPerm
    
    % Pool the data of the 2 groups
    Temp = [Grp1 ; Grp2];
    
    % Shuffle the data
    Temp = Temp(randperm(length(Temp)));
    
    % Assign half of the data to 2 temporary groups
    Temp_Grp_1 = Temp(1:length(Grp1));
    Temp_Grp_2 = Temp(length(Grp1)+1:end);

    % Compute and store the t-value associated to the difference between those 2 temporary groups
    T_Data_Dist(i) = (mean(Temp_Grp_1) - mean(Temp_Grp_2)) / sqrt( var(Temp_Grp_1)/(numel(Temp_Grp_1)-1) + var(Temp_Grp_2)/(numel(Temp_Grp_2)-1) );

end

% Compute the empirical p value associated
PValue_Data = sum(T_Data_Dist>T_Data)/NbPerm


% Plot the distribution of t values obtained over the permutation
subplot(2,2,[2 4])
hold on
hist(T_Data_Dist, NbPerm/20)
% Plot the actual t-value we had with the inital groups
plot( [T_Data T_Data], [0 max(hist(T_Data_Dist, NbPerm/20))], 'r' )
