% orthogonality: examples

% short thing on fourrier transform:
% box car: one frequency, then two frequency...

%% Plot frequency spectrum of our experiment
clear all;
close all;
clc;

OnsetVector = repmat([zeros(6 * 7, 1); ones(6 * 7, 1)], 8, 1);

gX = abs(fft(OnsetVector)).^2; % Gets the power
gX = gX ./ sum(gX); % Normalises the values
q = length(gX) / 2;
Hz = linspace(0, q, q);

figure('name', 'Onset vector and its frequency spectrum');

subplot(211);
plot(OnsetVector);
title('Time domain');
xlabel('Seconds');

subplot(212);
plot(Hz, gX(1:q));
axis([0 100 0 max(gX)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');

HRF = spm_hrf(1);

gX_HRF = abs(fft(HRF)).^2;
gX_HRF = gX_HRF ./ sum(gX_HRF);
q = length(gX_HRF) / 2;
Hz = linspace(0, q, q);

figure('name', 'HRF and its frequency spectrum');

subplot(211);
plot(HRF);
title('Time domain');
xlabel('Seconds');

subplot(212);
plot(Hz, gX_HRF(1:q));
axis([0 100 0 max(gX_HRF)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');

Regressor = conv(OnsetVector, HRF);

gX_conv = abs(fft(Regressor)).^2; %
gX_conv = gX_conv ./ sum(gX_conv);
q = length(gX_conv) / 2;
Hz = linspace(0, q, q);

figure('name', 'Convolved onset vector and its frequency spectrum');

subplot(211);
plot(Regressor);
title('Time domain');
xlabel('Seconds');

subplot(212);
plot(Hz, gX_conv(1:q));
axis([0 100 0 max(gX)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');

%% Plot frequency spectrum of a slow event related experiment
clear all;
close all;
clc;

OnsetVector = repmat([zeros(16, 1); ones(1, 1)], 8, 1);

gX = abs(fft(OnsetVector)).^2;
gX = gX ./ sum(gX);
q = length(gX) / 2;
Hz = linspace(0, q, q);

% Convolve the onset vector with the HRF and have a look in time and
% frequency domain
HRF = spm_hrf(1);
ConvOnsetVector = conv(HRF, OnsetVector);

gX_Conv = abs(fft(ConvOnsetVector)).^2;
gX_Conv = gX_Conv ./ sum(gX_Conv);
q_Conv = length(gX_Conv) / 2;
Hz_Conv = linspace(0, q_Conv, q_Conv);

figure('name', 'Onset vector and its frequency spectrum');

subplot(211);
plot(OnsetVector);
title('Time domain');
xlabel('Seconds');

subplot(212);
plot(Hz, gX(1:q));
axis([0 max([q q_Conv]) 0 max([gX; gX_Conv])]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');

figure('name', 'Convolved onset vector and its frequency spectrum');

subplot(211);
plot(ConvOnsetVector);
title('Time domain');
xlabel('Seconds');

subplot(212);
plot(Hz_Conv, gX_Conv(1:q_Conv));
axis([0 max([q q_Conv]) 0 max([gX; gX_Conv])]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');

%% Efficiency
clear all;
close all;
clc;

Block = [zeros(8, 1); ones(16, 1); zeros(8, 1)];
SlowEventVector = repmat([ones(1, 1); zeros(20, 1)], 16, 1);
FastEventVector = repmat([ones(1, 1); zeros(7, 1)], 16, 1);
RandOnsetVector = FastEventVector(randperm(length(FastEventVector)));

HRF = spm_hrf(1);
ConvBlock = conv(Block, HRF);
ConvSlowEventVector = conv(SlowEventVector, HRF);
ConvFastEventVector = conv(FastEventVector, HRF);
ConvRandOnsetVector = conv(RandOnsetVector, HRF);

gX_Block = abs(fft(ConvBlock)).^2;
gX_Block = gX_Block ./ sum(gX_Block);
q_Block = length(gX_Block) / 2;
Hz_Block = linspace(0, q_Block, q_Block);

gX_Slow = abs(fft(ConvSlowEventVector)).^2;
gX_Slow = gX_Slow ./ sum(gX_Slow);
q_Slow = length(gX_Slow) / 2;
Hz_Slow = linspace(0, q_Slow, q_Slow);

gX_Fast = abs(fft(ConvFastEventVector)).^2;
gX_Fast = gX_Fast ./ sum(gX_Fast);
q_Fast = length(gX_Fast) / 2;
Hz_Fast = linspace(0, q_Fast, q_Fast);

gX_Rand = abs(fft(ConvRandOnsetVector)).^2;
gX_Rand = gX_Rand ./ sum(gX_Rand);
q_Rand = length(gX_Rand) / 2;
Hz_Rand = linspace(0, q_Rand, q_Rand);

% Link between the T test formula and the Efficiency
% NOTE
% t = c'*beta / sqrt( sigma^2 * c' * (X'*X)^-1 * c')
% c is the contrast of interest
% X is the design matrix
% sigma^2 is the error variance and therefore the only term that is data
% dependent
% Efficiency of c'*beta is therefore proportional 1 / (c' * (X'*X)^-1 * c')

% Let us look at the efficiency of the different types of regressor
Constrast = 1;

EfficiencyBlock = (Constrast * inv(ConvBlock' * ConvBlock) * Constrast')^-1;
EfficiencySlow = (Constrast * inv(ConvSlowEventVector' * ConvSlowEventVector) * Constrast')^-1;
EfficiencyFast = (Constrast * inv(ConvFastEventVector' * ConvFastEventVector) * Constrast')^-1;
EfficiencyRandom = (Constrast * inv(ConvRandOnsetVector' * ConvRandOnsetVector) * Constrast')^-1;

figure('name', 'Different design');

subplot(421);
plot(ConvBlock);
title('Time domain');
xlabel('Seconds');
ylabel('Block');

subplot(422);
plot(Hz_Block, gX_Block(1:q_Block));
axis([0 q_Block 0 max(gX_Block)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');
text(q_Block / 2, max(gX_Block) / 2, sprintf('Efficiency= %2.2f', EfficiencyBlock));

subplot(423);
plot(ConvSlowEventVector);
title('Time domain');
xlabel('Seconds');
ylabel('Slow');

subplot(424);
plot(Hz_Slow, gX_Slow(1:q_Slow));
axis([0 q_Slow 0 max(gX_Slow)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');
text(q_Slow / 2, max(gX_Slow) / 2, sprintf('Efficiency= %2.2f', EfficiencySlow));

subplot(425);
plot(ConvFastEventVector);
title('Time domain');
xlabel('Seconds');
ylabel('Fast');

subplot(426);
plot(Hz_Fast, gX_Fast(1:q_Fast));
axis([0 q_Fast 0 max(gX_Fast)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');
text(q_Fast / 2, max(gX_Fast) / 2, sprintf('Efficiency= %2.2f', EfficiencyFast));

subplot(427);
plot(ConvRandOnsetVector);
title('Time domain');
xlabel('Seconds');
ylabel('Random');

subplot(428);
plot(Hz_Rand, gX_Rand(1:q_Rand));
axis([0 q_Rand 0 max(gX_Rand)]);
title('Frequency domain');
xlabel('Frequency (Hz)');
ylabel('Relative spectral density');
text(q_Rand / 2, max(gX_Rand) / 2, sprintf('Efficiency= %2.2f', EfficiencyRandom));

%% Permutation test
clear all;
close all;
clc;

NbSubj_Grp1 = 110;

Mean1_Grp1 = 55;
Std1_Grp1 = 20;
Grp1_A = randn(NbSubj_Grp1 - 50, 1) * Std1_Grp1 + Mean1_Grp1;

Mean2_Grp1 = 70;
Std2_Grp1 = 40;
Grp1_B = randn(40, 1) * Std2_Grp1 + Mean2_Grp1;

Grp1 = [Grp1_A; Grp1_B];

NbSubj_Grp2 = 90;

Mean1_Grp2 = 65;
Std1_Grp2 = 10;
Grp2_A = randn(NbSubj_Grp2 - 30, 1) * Std1_Grp2 + Mean1_Grp2;

Mean2_Grp2 = 90;
Std2_Grp2 = 50;
Grp2_B = randn(30, 1) * Std2_Grp2 + Mean2_Grp2;

Grp2 = [Grp2_A; Grp2_B];

subplot(211);
hist(Grp1);
subplot(212);
hist(Grp2);

NbPerm = 10000;
T_Data_Dist = nan(NbPerm, 1);

T_Data = abs(mean(Grp1) - mean(Grp2)) / sqrt(var(Grp1) / (numel(Grp1) - 1) + var(Grp2) / (numel(Grp2) - 1));
% T_Data = abs((mean(Grp1) - mean(Grp2))) / sqrt( var(Grp1)/numel(Grp1) + var(Grp2)/numel(Grp2) )
% [H,P,CI,STATS] = ttest2(Grp2, Grp1)

for i = 1:NbPerm

    Temp = [Grp1; Grp2];
    Temp = Temp(randperm(length(Temp)));
    Temp_Grp_1 = Temp(1:length(Grp1));
    Temp_Grp_2 = Temp(length(Grp1) + 1:end);

    T_Data_Dist(i) = abs(mean(Temp_Grp_1) - mean(Temp_Grp_2)) / sqrt(var(Temp_Grp_1) / (numel(Temp_Grp_1) - 1) + var(Temp_Grp_2) / (numel(Temp_Grp_2) - 1));

end

hist(T_Data_Dist, NbPerm / 20);
hold on;
plot([T_Data T_Data], [0 max(hist(T_Data_Dist, NbPerm / 20))], 'r');

PValue_Data = sum(T_Data_Dist > T_Data) / NbPerm;

%% Permutation test : images
clear all;
close all;
clc;

SizeImage = 256;

NbSubj_Grp1 = 12;
Mean_Grp1 = 55 * ones(SizeImage);
Mean_Grp1(120:180, 120:180) = 65;
Mean_Grp1 = repmat(Mean_Grp1, [1, 1, NbSubj_Grp1]);
Std_Grp1 = 30;

Grp1 = randn(SizeImage, SizeImage, NbSubj_Grp1) * Std_Grp1 + Mean_Grp1;

NbSubj_Grp2 = 15;
Mean_Grp2 = 80 * ones(SizeImage);
Mean_Grp2(120:180, 120:180) = 65;
Mean_Grp2 = repmat(Mean_Grp2, [1, 1, NbSubj_Grp2]);
Std_Grp2 = 35;

Grp2 = randn(SizeImage, SizeImage, NbSubj_Grp2) * Std_Grp2 + Mean_Grp2;

figure(1);
subplot(411);
image(mean(Grp1, 3));
set(gca, 'xticklabel', [], 'yticklabel', []);
axis square;
colorbar;

subplot(412);
image(mean(Grp2, 3));
set(gca, 'xticklabel', [], 'yticklabel', []);
axis square;
colorbar;

T_Data = abs(mean(Grp1, 3) - mean(Grp2, 3)) ./ ...
    sqrt(var(Grp1, [], 3) / (size(Grp1, 3) - 1) + var(Grp2, [], 3) / (size(Grp2, 3) - 1));

subplot(413);
imagesc(T_Data);
set(gca, 'xticklabel', [], 'yticklabel', []);
axis square;
colorbar;

NbPerm = 100;
Threshold = 0.0001;

T_Data_Dist = nan(SizeImage, SizeImage, NbPerm);

for i = 1:NbPerm

    Temp = Grp1;
    Temp(:, :, end + 1:end + size(Grp2, 3)) =  Grp2;
    Temp = Temp(:, :, randperm(size(Temp, 3)));
    Temp_Grp_1 = Temp(:, :, 1:size(Grp1, 3));
    Temp_Grp_2 = Temp(:, :, size(Grp1, 3) + 1:end);

    T_Data_Dist(:, :, i) = abs(mean(Temp_Grp_1, 3) - mean(Temp_Grp_2, 3)) ./ ...
        sqrt(var(Temp_Grp_1, [], 3) / (size(Temp_Grp_1, 3) - 1) + var(Temp_Grp_2, [], 3) / (size(Temp_Grp_2, 3) - 1));

end

PValue_Data = sum(T_Data_Dist > repmat(T_Data, [1, 1, size(T_Data_Dist, 3)]), 3) / NbPerm;

subplot(414);
imagesc(PValue_Data < Threshold);
set(gca, 'xticklabel', [], 'yticklabel', []);
axis square;
colorbar;

%% FFX VS RFX
clear all;
close all;
clc;

NbSubj = 8;
NbTrials = 10;

% Set individual means
Group = 2 + 4 * randn(1, NbSubj);

% Sample trials for each subject
for i = 1:NbSubj
    x(:, i) = Group(i) * ones(NbTrials, 1) + .5 * randn(NbTrials, 1);
end

% Compute mean and std for each subject
M = mean(x);
S = std(x);

% Compute fixed effect statistic
Variance = S.^2;
PooledVariance = mean(Variance);
STD_FFX = sqrt(PooledVariance);
t_FFX = mean(M) / sqrt(PooledVariance / NbSubj);

% Compute random effect statistic
STD_RFX = std(M);
t_RFX = mean(M) / (STD_RFX / sqrt(NbSubj));

% Plot
tx = [-10:0.01:15];
k = 1 / sqrt(2 * pi);

for i = 1:NbSubj

    pdf = .5 * (k / 5) * exp(-(tx - Group(i)).^2 / (2 * .25));
    plot(tx, pdf);
    hold on;
    scatter(x(:, i), zeros(1, NbTrials), 84, 'x', 'k');

end

pdfg = (k / 4) * exp(-(tx - 2).^2 / (2 * 16));
plot(tx, pdfg);

axis([-10 15 0 .5]);
