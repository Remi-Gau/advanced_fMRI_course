%% Create and plot an HRF
clear all;
close all;
clc;

% Paramters of the HRF
T_0 = 0;
n = 4;
lambda = 2;

% Define time axis (from 0 to 30 secs in 0.01 increments)
t = 0:0.01:30;

% Creates the HRF
HRF = ((t - T_0).^(n - 1)) .* exp(-(t - T_0) / lambda) / ((lambda^n) * factorial(n - 1));

% Plot the HRF
plot(t, HRF);
axis([0 30 0 .12]);

%% Convolve an HRF with a boxcar function
clear all;
close all;
clc;

% Paramters of the HRF
T_0 = 0;
n = 4;
lambda = 2;

% Define time axis (from 0 to 50 secs in 0.01 increments)
t_50 = 0:0.01:50;

% Creates the boxcars
Box5 = [ones(1, 500) zeros(1, 4501)];
Box20 = [ones(1, 2000) zeros(1, 3001)];
Box50 = [ones(1, 5000) 0];

% Creates the HRF
HRF = ((t_50 - T_0).^(n - 1)) .* exp(-(t_50 - T_0) / lambda) / ((lambda^n) * factorial(n - 1));

% Compute the convolution. Divide by 100 to set time unit at 0.01 sec
BOLD5 = conv(Box5, HRF) / 100;
BOLD20 = conv(Box20, HRF) / 100;
BOLD50 = conv(Box50, HRF) / 100;

% Plot the predicted responses
t_100 = 0:0.01:100;

subplot(311);
plot(t_50, Box5, t_100, BOLD5);
axis([0 100 0 1.5]);

subplot(312);
plot(t_50, Box20, t_100, BOLD20);
axis([0 100 0 1.5]);

subplot(313);
plot(t_50, Box50, t_100, BOLD50);
axis([0 100 0 1.5]);

%% Generate BOLD predictions from the Volterra model
clear all;
close all;
clc;

% Define the 3 basis functions and the boxcar
t_50 = 0:0.01:50;

b1 = (t_50.^3) .* exp(-t_50) / factorial(3);
b2 = (t_50.^7) .* exp(-t_50) / factorial(15);
b3 = (t_50.^15) .* exp(-t_50) / factorial(15);

BOX = [ones(1, 500) zeros(1, 100) ones(1, 500) zeros(1, 100) ones(1, 500) zeros(1, 3301)];

% Computes the convolution and divide by 100 to set the time unit at 0.01
% sec
X1 = conv(BOX, b1) / 100;
X2 = conv(BOX, b2) / 100;
X3 = conv(BOX, b3) / 100;

% Computes the convolution products
% Only 2 given here but the others can be added in an analogous fashion
Y11 = X1 .* X1;
Y13 = X1 .* X3;

% Set the weight parameters
w1 = .2;
w2 = .2;
w3 = .2;
w11 = .25;
w13 = .25;

% Computes the non-linear BOLD response
H1 = w1 * X1 + w2 * X2 + w3 * X3;
H2 = w11 * Y11 + w13 * Y13;
B = H1 + H2;

% Computes the predicted linear response
S = w1 + w2 + w3;
Lin = H1 / S;

% Normalize area under the non linear response to equal area under linear
% response
B = sum(Lin) * B / sum(B);

% Plots the boxcar, the linear and non-linear responses
t_100 = 0:0.01:100;

plot(t_50, BOX, t_100, B, t_100, Lin);
axis([0 40 0 1.1]);

%% Sinc interpolation for a difference of gamma HRFs
clear all;
close all;
clc;

% Create difference of gammas HRF and plot
t_24 = 0:.01:24;

n1 = 4;
lambda1 = 2;

n2 = 7;
lambda2 = 2;

a = .3;
c1 = 1;
c2 = .5;

h_1 = ((t_24 - 1).^(n1 - 1)) .* exp(-(t_24 - 1) / lambda1) / ((lambda1^n1) * factorial(n1 - 1));
h_2 = ((t_24 - 1).^(n2 - 1)) .* exp(-(t_24 - 1) / lambda2) / ((lambda2^n2) * factorial(n2 - 1));

HRF = a * (c1 * h_1 - c2 * h_2);

plot(t_24, HRF, 'k');
axis([0 25 -0.01 .04]);
hold on;

% Sample HRF every TR = 3 secs. Plot these points as circles
for i = 1:9
    xx(i) = HRF(300 * i - 299);
    n(i) = 300 * i - 299;
end

tt_24 = 0:3:24;

plot(tt_24, xx, 'o');

% Sinc interpolate (with Hanning window)
L = 10;
for i = 1:2401
    B_interp(i) = sum(xx .* sinc((i - n) / 300) .* (1 + cos(pi * .01 * (i - n) / L)) / 2);
end

plot(t_24, B_interp);

%% Coregistration using histogram bins
clear all;
close all;
clc;

% First image
X(1:20, 1:20) = 5;
X(6:15, 6:15) = 12;
X(6:9, 6:9) = 20;
X(10:12, 10:12) = 40;
X(13:15, 13:15) = 12;

N = normrnd(0, 1.5, [20 20]);

X = X + N;

subplot(311);
image(X);
colormap(gray);
brighten(.5);
axis square;

% Second image
N = normrnd(0, 1.5, [20 20]);

Y = -X + N + 50;

subplot(312);
image(Y);
axis square;

% Load the images into vectors
for i = 1:20
    X_v(1 + 20 * (i - 1):20 * i) = X(i, 1:20);
    Y_v(1 + 20 * (i - 1):20 * i) = Y(i, 1:20);
end

% Bin the entries in each vector (bin width=1)
X_bin = round(X_v);
Y_bin = round(Y_v);

% Scatter plot
subplot(313);
scatter(X_bin, Y_bin, 'k', '.');
axis square;

%% Matched filter theorem
clear all;
close all;
clc;

% Define time and the signal
t_40 = 0:.01:40;
y_stand = 20 * exp(-(t_40 - 15).^2 / 5);

subplot(311);
plot(t_40, y_stand);
axis([0 40 -10 30]);

% Creates the data
y_data = y_stand + normrnd(0, 35, 1, length(t_40));
subplot(312);
plot(t_40, y_data);
axis([0 40 -200 200]);

% apply the filter
for j = 1:4001
    r = exp(-(t_40 - j * .01).^2 / 5);
    Correct = r .* y_data;
    y_pred(j) = sum(Correct) / sum(r);
end

subplot(313);
plot(t_40, y_pred);
axis([0 40 -5 20]);

%% High pass filtering
clear all;
close all;
clc;

% create and plot the data
t = 0:.01:600;
y = 50 + 50 * sin(.01 * t) + 50 * square(.25 * t);

subplot(211);
plot(t, y);
axis([0 600 -100 200]);
hold on;

% LPF by smoothing with a gaussian kernel
W = 250; % Gaussian kernel width
for j = 1:60001
    r = exp(-(t - j * .01).^2 / W);
    Correct = r .* y;
    y_low(j) = sum(Correct) / sum(r);
end

plot(t, y_low, 'k');

% Substract low passed filtered data from the raw data
y_pred = y - y_low;

subplot(212);
plot(t, y_pred);
axis([0 600 -100 100]);

%% Generate a predicted BOLD for a GLM analysis
clear all;
close all;
clc;

% Paramters of the HRF
T_0 = 0;
n = 4;
lambda = 2;

% Define time axis (from 0 to 30 secs in 0.01 increments)
t_25 = 0:0.01:25;

% Creates the HRF
HRF = ((t_25 - T_0).^(n - 1)) .* exp(-(t_25 - T_0) / lambda) / ((lambda^n) * factorial(n - 1));

% Boxcar
BOX = [ones(1, 300) zeros(1, 300) ones(1, 600) zeros(1, 900) ones(1, 300) zeros(1, 101)];

subplot(311);
plot(t_25, BOX);
axis([0 40 0 2]);

% Convolve HRF and boxcar
B = conv (BOX, HRF) / 100;

t_50 = 0:0.01:50;

subplot(312);
plot(t_50, B);
axis([0 40 0 1]);

% Discretize the predicted BOLD
N_Plot = zeros(1, 5001);
for i = 1:13
    N(i) = B(i * 300);
    N_Plot(i * 300) = N(i);
end

subplot(313);
stem(t_50, N_Plot, 'x', 'linewidth', 1);
axis([0 40 0 1]);

%% Create and present a design matrix
clear all;
close all;
clc;

% Number of TR
nTR = 16;

% Scaling factor
ScaleFact = 4;

% Boxcar
BOX = [ones(1, 4) zeros(1, 4) ones(1, 4) zeros(1, 4)];

% Design matrix
X(:, 1) = BOX';
X(:, 2) = ones(nTR, 1);
X(:, 3) = linspace(1, nTR, nTR);

% Scale columns so that they all have the same maximum
X(:, 1:2) = max(max(X)) * X(:, 1:2);

colormap(gray);
imagesc(X);

%% GLM
clear all;
close all;
clc;

t = 0:.1:1200;

% Number of TR
nTR = 480;

% Theoretical Beta
Theta = 25;
% BOLD base level
B_0 = 40;
% Amplitude of the linear drift
Delta = 0.01;

Beta = [Theta; B_0; Delta];

% HRF
T_0 = 0;
n = 4;
Lambda = 2;

HRF = ((t - T_0).^(n - 1)) .* exp(-(t - T_0) / Lambda) / ((Lambda^n) * factorial(n - 1));

% Boxcar
BOX = [ones(1, 3000) zeros(1, 3000) ones(1, 3000) zeros(1, 3001)];
subplot(311);
plot(t, BOX);
axis([0 1200 0 1.5]);

% Convolve and discretize
B = conv(HRF, BOX) / 100;

tp = 0:0.1:2400;

for i = 1:nTR
    N(i) = B(i * 25);
end

% Design matrix
X(:, 1) = N';
X(:, 2) = ones(nTR, 1);
X(:, 3) = linspace(1, nTR, nTR)';

% Create & plot data
B_data = X * Beta + normrnd(0, 4, [nTR 1]);
B_data_plot = zeros(1, 12001);
for i = 1:nTR
    B_data_plot(i * 25) = B_data(i);
end

subplot(312);
plot(t, B_data_plot);
axis([0 1200 30 60]);

% Estimate beta and error variance
Beta_hat = inv(X' * X) * X' * B_data;
Var_Error = (B_data - X * Beta_hat)' * (B_data - X * Beta_hat) / (nTR - 1 - length(Beta));

% t-statistics
c = [1; 0; 0];
t_stat = c' * Beta_hat / sqrt(Var_Error * c' * inv(X' * X) * c);

% Plot predicted BOLD
B_Predicted = X * Beta_hat;
B_Predicted_plot = zeros(1, 12001);
for i = 1:nTR
    B_Predicted_plot((i - 1) * 25 + 1:i * 25) = B_Predicted(i);
end

subplot(3, 1, 3);
plot(t, B_data_plot);
axis([0 1200 30 60]);
hold on;

plot(t, B_Predicted_plot);

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

%% autocorrelation and cross-correlation
clear all;
close all;
clc;

% HRF
t_200 = 0:.1:200;

n1 = 4;
lambda1 = 2;

n2 = 7;
lambda2 = 2;

a = .3;

h_1 = ((t_200 - 1).^(n1 - 1)) .* exp(-(t_200 - 1) / lambda1) / ((lambda1^n1) * factorial(n1 - 1));
h_2 = ((t_200 - 1).^(n2 - 1)) .* exp(-(t_200 - 1) / lambda2) / ((lambda2^n2) * factorial(n2 - 1));

HRF1 = h_1;
HRF2 = (h_1 - a * h_2) / sum((h_1 - a * h_2) * .1);

% Boxcar
n = zeros(1, 2001);
n(26:50) = 1;
n(151:175) = 1;
n(501:525) = 1;
n(776:800) = 1;
n(1001:1025) = 1;
n(1401:1425) = 1;
n(1601:1625) = 1;

n2 = [zeros(1, 100), n(1:1901)];

% Convolve and add noise
B1 = conv(HRF1, n) / 10;
B2 = conv(HRF2, n2) / 10;

B1 = B1(1:2001) + .03 * randn(1, 2001);
B2 = B2(1:2001) + .03 * randn(1, 2001);

subplot(4, 1, 1);
plot(t_200, B1);
axis([0 200 0 1]);

subplot(4, 1, 3);
hold on;
plot(t_200, B1);
plot(t_200, B2, 'r');
axis([0 200 0 1]);

% Autocorrelation function
[R_B1, lags] = xcorr(B1, 'coeff');

subplot(4, 1, 2);
plot(lags / 10, R_B1);
axis([-200 200 0 1]);

% Cross-correlation function
[R_12, lags] = xcorr(B1, B2, 'coeff');

subplot(4, 1, 4);
plot(lags / 10, R_12);
axis([-200 200 0 1]);

%% Power spectrum of a BOLD response
clear all;
close all;
clc;

n_time = 2000;
T = 200;
t = T * [0:n_time - 1] / n_time;

% HRF
n1 = 4;
lambda1 = 2;
HRF = ((t - 1).^(n1 - 1)) .* exp(-(t - 1) / lambda1) / ((lambda1^n1) * factorial(n1 - 1));

% Boxcar
n = zeros(1, 2001);
n(26:50) = 1;
n(151:175) = 1;
n(501:525) = 1;
n(776:800) = 1;
n(1001:1025) = 1;
n(1401:1425) = 1;
n(1601:1625) = 1;

% Convolve and add noise
B = conv(HRF, n) / 10;
B = B(1:n_time) + .03 * randn(1, n_time);

subplot(2, 1, 1);
plot(t, B);
axis([0 200 -.1 .4]);

% Auto-correlation function
[R_B, lags] = xcorr(B, 'coeff');
P_B = abs(fft(R_B)) / (n_time / 2);
P_B = P_B(1:n_time / 2);
freq = [0:n_time / 2 - 1] / T;

subplot(2, 1, 2);
semilogy(freq, P_B);
axis([0 1 0 1]);

%% Coherence between BOLD responses
clear all;
close all;
clc;

n_time = 2000;
T = 200;
t = T * [0:n_time - 1] / n_time;

% HRF
n1 = 4;
lambda1 = 2;

n2 = 7;
lambda2 = 2;

a = .3;

h_1 = ((t - 1).^(n1 - 1)) .* exp(-(t - 1) / lambda1) / ((lambda1^n1) * factorial(n1 - 1));
h_2 = ((t - 1).^(n2 - 1)) .* exp(-(t - 1) / lambda2) / ((lambda2^n2) * factorial(n2 - 1));

HRF1 = h_1;
HRF2 = (h_1 - a * h_2) / sum((h_1 - a * h_2) * .1);

subplot(3, 1, 1);
plot(t, HRF1, t, HRF2);
axis([0 25 -.02 .2]);

% Boxcar
n = zeros(1, n_time);
n(26:50) = 1;
n(151:175) = 1;
n(501:525) = 1;
n(776:800) = 1;
n(1001:1025) = 1;
n(1401:1425) = 1;
n(1601:1625) = 1;

n2 = [zeros(1, 3), n(1:1997)];

% Convolve and add noise
B1 = conv(HRF1, n) / 10;
B2 = conv(HRF2, n2) / 10;

B1 = B1(1:n_time) + .03 * randn(1, n_time);
B2 = B2(1:n_time) + .03 * randn(1, n_time);

subplot(3, 1, 2);
plot(t, B1, t, B2);
axis([0 200 -.1 .5]);

% Coherence
[C12, freq] = cohere(B1, B2, [], []);

freq = freq * n_time / (T * 2);

subplot(3, 1, 3);
plot(freq, C12);
axis([0 0.5 0 1]);

%%
clear all;
close all;
clc;

NbSubject = 1000;

Error = randn(NbSubject, 1);
Y_A = ones(NbSubject, 1) * 5 + Error;
Y_B = ones(NbSubject, 1) * 6 + 2 * Error;
Y = [Y_A; Y_B];

X = [ones(size(Y_A)) zeros(size(Y_B)); zeros(size(Y_A)) ones(size(Y_B))];

figure('Name', 'Design matrix');
colormap('Gray');
imagesc(X);

% X is not squared so inv(X) is not possible
% a simple solution is to multiply by the transpose
% making the matrix X'X square
% Y = X*Beta
% --> X'*Y = X'*X*Beta
% --> inv(X'*X)*X'*Y = inv(X'*X)*X'*X*Beta
% --> but inv(X'*X)*X'*X = I thus
Beta = inv(X' * X) * X' * Y;

% check what it looks like
Y_hat = X * Beta; % Yhat is the model
Residuals  = Y - Y_hat; % Residual (error)

figure('Name', 'Errors');
hist(Residuals, 20);

figure('Name', 'Normplot');
normplot(Residuals);

%%
clear all;
close all;
clc;

NbSubject = 100;

Errors = [];

for i = 1:100

    Error = randn(NbSubject, 1);
    Y_A = ones(NbSubject, 1) * 5 + Error;
    Y_B = ones(NbSubject, 1) * 6 + 4 * Error;
    Y = [Y_A; Y_B];

    clear Error;

    X = [ones(size(Y_A)) zeros(size(Y_B)); zeros(size(Y_A)) ones(size(Y_B))];

    Beta = inv(X' * X) * X' * Y;

    Y_hat = X * Beta;
    Residuals  = Y - Y_hat;

    Errors(end + 1, :) = Residuals;

end

% imagesc(cov(Errors))
imagesc(cov(Errors));

%%
clear all;
clc;
close all;

t = 0:.1:1200;

% Number of TR
nTR = 100;

% Theoretical Beta
Theta = 25;
% BOLD base level
B_0 = 40;
% Amplitude of the linear drift
Delta = 0.01;

Beta = [Theta; B_0; Delta];

% HRF
T_0 = 0;
n = 4;
Lambda = 2;

HRF = ((t - T_0).^(n - 1)) .* exp(-(t - T_0) / Lambda) / ((Lambda^n) * factorial(n - 1));

% Boxcar
BOX = [ones(1, 3000) zeros(1, 3000) ones(1, 3000) zeros(1, 3001)];

% Convolve and discretize
B = conv(HRF, BOX) / 100;

tp = 0:0.1:2400;

for i = 1:nTR
    N(i) = B(i * 25);
end

% Design matrix
X(:, 1) = N';
X(:, 2) = ones(nTR, 1);
X(:, 3) = linspace(1, nTR, nTR)';

Errors = [];

for i = 1:100
    % Create & plot data
    Error = normrnd(0, 4, [nTR 1]);
    AutoCorr = 0.5 * [0; Error(1:end - 1)];
    Error = Error + AutoCorr;
    B_data = X * Beta + Error;

    % Estimate beta and error variance
    Beta_hat = inv(X' * X) * X' * B_data;
    % Beta_hat = inv(X(:,1:2)'*X(:,1:2))*X(:,1:2)'*B_data;
    % Residuas
    Residuals = B_data - X * Beta_hat;
    % Residuals = B_data - X(:,1:2)*Beta_hat;
    % Compile
    Errors(end + 1, :) = Residuals;
end

figure(1);
subplot(211);
imagesc(cov(Errors));
colorbar;
subplot(212);
autocorr(mean(Errors));
