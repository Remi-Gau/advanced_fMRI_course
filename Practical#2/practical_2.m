%% T test
clear all;
close all;
clc;

NbSubject = 100;

% -------------------------------------------------------------------------%
%                               Create data                               %
% -------------------------------------------------------------------------%
MeanConditionA = 5;
MeanConditionB = 6;
StdError = 1;

Y_A = MeanConditionA + randn(NbSubject, 1) * StdError;
Y_B = MeanConditionB + randn(NbSubject, 1) * StdError;
% -------------------------------------------------------------------------%
load T-Test.mat;

%%

% Plot dsitribution
figure('Name', '2 samples');
subplot(211);
hist(Y_A, 10);
title('Y_A');
axis([0 10 0 30]);
subplot(212);
hist(Y_B, 10);
title('Y_B');
axis([0 10 0 30]);

% Design matrix
X = [ones(size(Y_A)) zeros(size(Y_B)); zeros(size(Y_A)) ones(size(Y_B))];
figure('Name', 'Design matrix');
title('Design matrix for a t-test');
colormap('Gray');
imagesc(X);
colorbar;
set(gca, 'xtick', [1 2], 'xticklabel', ['Group 1'; 'Group 2']);

% Data
Y = [Y_A; Y_B];

% Beta
Beta = inv(X' * X) * X' * Y;

% Y_hat: model predictions
Y_hat = X * Beta;

% Residual (error)
Residuals  = Y - Y_hat;
% Std of the error
Std_Error  = sqrt(sum((Residuals - mean(Residuals)).^2) / (length(Residuals) - 1));

figure('Name', 'Residuals');
subplot(211);
hist(Residuals, 20);
subplot(212);
normplot(Residuals);

% t statistics
c = [-1; 1]; % This is to check if the second group is bigger than the first one.
t = c' * Beta / sqrt(Std_Error^2 * c' * inv(X' * X) * c);

% degrees of freedom: depends only on the rank of the design matrix (X)
df = rank(X) - 1;

% degrees of freedom of the error ;
% Y is a vector containing all the data
% 'numel' tells us how many values Y contains
dferror = numel(Y) - df - 1;

% the p value is found via the cummulative distribution
% function (cdf) of a student dsitribution
p = tcdf(-t, dferror);

% How you would do a 2 samples t-test without a GLM:
% The final result might be slightly different depending on how you compute
% the standart deivations.
% t = (mean(Y_B)-mean(Y_A)) / sqrt(var(Y_A)/length(Y_A)+var(Y_B)/length(Y_B))
% p = tcdf(-t, length(Y_A)+length(Y_B-2))

%% Create the HRF
clear all;
close all;
clc;

% The spm version
HRF_spm = spm_hrf(.01);

% Create difference of gammas HRF and plot
t = 0:.01:32;

n1 = 4;
lambda1 = 1;

n2 = 8;
lambda2 = 1;

n3 = 15;
lambda3 = 1;

a = 1 / 100;
c1 = 1.2;
c2 = -0.2;
c3 = 0;

h_1 = t.^(n1 - 1) .* exp(-t / lambda1) / (lambda1^n1 * factorial(n1 - 1));
h_2 = t.^(n2 - 1) .* exp(-t / lambda2) / (lambda2^n2 * factorial(n2 - 1));
h_3 = t.^(n3 - 1) .* exp(-t / lambda3) / (lambda3^n3 * factorial(n3 - 1));

HRF = a * (c1 * h_1 + c2 * h_2 + c3 * h_3);

figure('Name', 'HRF');
subplot(121);
plot(t, HRF, 'k');
title('Our HRF');
set(gca, 'xtick', 0:5:32, 'xticklabel', 0:5:32);

subplot(122);
plot(HRF_spm, 'k');
title('spm HRF');
set(gca, 'xtick', 0:500:3200, 'xticklabel', 0:5:32);

%% A bit more on the HRF
HRF = spm_hrf(.1); % Gives the shape of the HRF with a sampling frequency of 1 Hz

xBF.dt = .1; % Temporal resolution in seconds of the informed basis set you are going to create
xBF.name = 'hrf (with time and dispersion derivatives)';

% Length of the HRF in seconds
xBF.length = 33;
xBF.order = 1;

% Creates the informed basis set
xBF = spm_get_bf(xBF);

figure('name', 'HRF and its derivative');
hold on;
plot(xBF.bf(:, 1), 'b'); % Canonical HRF
plot(xBF.bf(:, 2), 'r'); % Temporal derivative of the HRF
plot(xBF.bf(:, 3), 'g'); % Dispersion derivative of the HRF
LEGEND = {'HRF'; 'Temporal derivative'; 'Dispersion derivative'};
legend(char(LEGEND));
set(gca, 'xtick', 0:50:320, 'xticklabel', 0:5:32);

figure('name', 'HRF +/- the temporal derivative');
hold on;
plot(xBF.bf(:, 1), 'b'); % Canonical HRF
plot(xBF.bf(:, 1) + xBF.bf(:, 2), 'r'); % HRF + Temporal derivative of the HRF
plot(xBF.bf(:, 1) - xBF.bf(:, 2), 'g'); % HRF - Temporal derivative of the HRF
LEGEND = {'HRF'; 'HRF + Temporal derivative'; 'HRF - Temporal derivative'};
legend(char(LEGEND));
set(gca, 'xtick', 0:50:320, 'xticklabel', 0:5:32);

figure('name', 'HRF +/- the dispersion derivative');
hold on;
plot(xBF.bf(:, 1), 'b'); % Canonical HRF
plot(xBF.bf(:, 1) + xBF.bf(:, 3), 'r'); % HRF + Dispersion derivative of the HRF
plot(xBF.bf(:, 1) - xBF.bf(:, 3), 'g'); % HRF - Dispersion derivative of the HRF
LEGEND = {'HRF'; 'HRF + Dispersion derivative'; 'HRF - Dispersion derivative'};
legend(char(LEGEND));
set(gca, 'xtick', 0:50:320, 'xticklabel', 0:5:32);

%% Create an onset vector and concolve it with the HRF
clear all;
close all;
clc;

% Basis function
xBF.dt = 1;
xBF.name = 'hrf (with time and dispersion derivatives)';
xBF.length = 32;
xBF.order = 1;
xBF = spm_get_bf(xBF);

% Onset vector
OnsetVector = repmat([zeros(16, 1); ones(1, 1)], 8, 1);

% Convolve
Regressor = conv(xBF.bf(:, 1), OnsetVector);
RegressorTimeDer = conv(xBF.bf(:, 2), OnsetVector);

figure('name', 'Input and convolved regressors');
subplot(211);
stem(OnsetVector);
axis([0 length(RegressorTimeDer) 0 1]);
subplot(212);
hold on;
plot(Regressor, 'b');
plot(RegressorTimeDer, 'r');
axis([0 length(RegressorTimeDer) min(RegressorTimeDer) max(Regressor)]);

%% GLM
clear all;
close all;
clc;

load (fullfile(pwd, 'Data_Practical_2', 'TimeCourseA1.mat'));

% Grand mean scaling
TimeCourseLeft = TimeCourseLeft' / spm_global(TimeCourseLeft) * 100;
TimeCourseRight = TimeCourseRight' / spm_global(TimeCourseRight) * 100;

% HRF
HRF = spm_hrf(7);
figure('name', 'HRF');
plot(HRF);

% Basis function
xBF.dt = 7; % Temporal resolution in seconds of the informed basis set you are going to create
xBF.name = 'hrf (with time and dispersion derivatives)';
xBF.length = 32;
xBF.order = 1;
xBF = spm_get_bf(xBF);

Onsets = 6:12:84;
OnsetVector = zeros(length(TimeCourseLeft), 1);
for i = 1:length(Onsets)
    OnsetVector([Onsets(i):Onsets(i) + 5]) = 1;
end

Regressor = conv(xBF.bf(:, 1), OnsetVector);
RegressorTimeDer = conv(xBF.bf(:, 2), OnsetVector);

% DESIGN  MATRIX
% X(:,1) = Regressor;
% % Constant
% X(:,end+1) = ones(length(X(:,1)),1);
% % We only keep the 84 first lines of the matrix: the convolution extended
% % the regressor a bit
% X = X(1:length(TimeCourseRight),:);

% Alternatives design matrices

% With no constant
% X(:,1) = Regressor;
% X = X(1:length(TimeCourseRight),:);

% With an unconvolved regressor
% X(:,1) = OnsetVector;
% X(:,end+1) = ones(length(X(:,1)),1);
% X = X(1:length(TimeCourseRight),:);

% With a time derivative to compensate for the misspecification of the
% block onset
% X(:,1) = Regressor;
% X(:,end+1) = RegressorTimeDer;
% X(:,end+1) = ones(length(X(:,1)),1);
% X = X(1:length(TimeCourseRight),:);

% With a very rudimentary high pass filter to account for the linear drift
% of the scanner
X(:, 1) = Regressor;
X(:, end + 1) = RegressorTimeDer;
% X(:,end+1) = ones(length(X(:,1)),1);
X = X(1:length(TimeCourseRight), :);
X(:, end + 1) = (1:length(TimeCourseRight)) / length(TimeCourseRight);

figure('name', 'Design matrix');
colormap('Gray');
imagesc(X);
colorbar;
set(gca, 'xtick', [1 2], 'xticklabel', ['Eff Cst']);

% Statistics
c = [1; zeros(size(X, 2) - 1, 1)];
df       = rank(X) - 1;
dferror  = size(X, 1) - df - 1;

% Estimate beta and error variance

% ---- For the left A1 ---- %
Beta_A1L = inv(X' * X) * X' * TimeCourseLeft;
Y_hat_A1L = X * Beta_A1L;
Residuals_A1L = TimeCourseLeft - Y_hat_A1L;
Std_Error_A1L  = sqrt(sum((Residuals_A1L - mean(Residuals_A1L)).^2) / (length(Residuals_A1L) - 1));
t_A1L = c' * Beta_A1L / sqrt(Std_Error_A1L^2 * c' * inv(X' * X) * c);
p_A1L = tcdf(-t_A1L, dferror);

% ---- For the Right A1 ---- %
Beta_A1R = inv(X' * X) * X' * TimeCourseRight;
Y_hat_A1R = X * Beta_A1R;
Residuals_A1R = TimeCourseLeft - Y_hat_A1R;
Std_Error_A1R  = sqrt(sum((Residuals_A1R - mean(Residuals_A1R)).^2) / (length(Residuals_A1R) - 1));
t_A1R = c' * Beta_A1R / sqrt(Std_Error_A1R^2 * c' * inv(X' * X) * c);
p_A1R = tcdf(-t_A1R, dferror);

figure('Name', 'Residuals');

subplot(321);
hist(Residuals_A1L, 20);
title('Left A1');

subplot(322);
hist(Residuals_A1R, 20);
title('Right A1');

subplot(323);
normplot(Residuals_A1L);

subplot(324);
normplot(Residuals_A1R);

subplot(325);
% If access to the econometric toolbox
% autocorr(Residuals_A1L)
[AutoCorrFuncA1L, lags] = xcorr(Residuals_A1L, 'coeff');
plot(lags, AutoCorrFuncA1L);
ylabel('Autocorrelation');

subplot(326);
% If access to the econometric toolbox
% autocorr(Residuals_A1R)
[AutoCorrFuncA1R, lags] = xcorr(Residuals_A1L, 'coeff');
plot(lags, AutoCorrFuncA1R);
ylabel('Autocorrelation');

figure('name', 'Vector onset, Model and data');

subplot(411);
plot(OnsetVector, 'b');
title('Onset vector');

subplot(412);
plot(Regressor, '--r');
title('Regressor');

subplot(413);
hold on;
plot(TimeCourseLeft, 'k');
plot(Y_hat_A1L, '--r');
title('Time course A1 left');

subplot(414);
hold on;
plot(TimeCourseRight, 'k');
plot(Y_hat_A1R, '--r');
title('Time course A1 right');
