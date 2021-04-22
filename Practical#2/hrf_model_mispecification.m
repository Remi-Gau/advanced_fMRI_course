% example of model mis specification because of "wrong" derivative

clear;
clc;
close all;

% We keep neural response amplitude the same for both groups
response_amplitude = 10;
constant = 1;
temporal_resolution = 0.5; % in seconds

% HRF models
% weight given to the canonical / temporal derivatives / dispersion derivatives
hrf_beta_blind = [-0.5 -1 -1];
hrf_beta_ctrl = [1 1 1];

% simulation parameter
nb_subjects = 20;

between_subject_std = 0;

noise_level = 0.01;

%% hrf model
[hrf_blind] = create_and_return_hrf(hrf_beta_blind, temporal_resolution);
[hrf_ctrl] = create_and_return_hrf(hrf_beta_ctrl, temporal_resolution);

figure('name', 'HRFs');
hold on;
plot(hrf_blind, 'b');
plot(hrf_ctrl, 'r');
LEGEND = {'HRF blind'; 'HRF ctrl'};
legend(char(LEGEND));

%% Neural response and "ground truth" response
% Create an onset vector and concolve it with the HRF

% Onset vector: one event every 16 seconds repeated 8 times
onset_vector = repmat([zeros(16 / temporal_resolution, 1); ones(1, 1) * response_amplitude], 8, 1);

% Convolve onset vector with HRF
BOLD_blind = conv(hrf_blind, onset_vector);
BOLD_ctrl = conv(hrf_ctrl, onset_vector);

figure('name', 'BOLD response: ground truth');
hold on;
plot(BOLD_blind, 'b');
plot(BOLD_ctrl, 'r');
LEGEND = {'blind'; 'ctrl'};
legend(char(LEGEND));

%% simulate data: forwad model
for iSub = 1:nb_subjects

    % create a specific hrf for each subject
    hrf_beta_this_blind = hrf_beta_blind + randn(size(hrf_beta_blind)) * between_subject_std;
    hrf_this_blind = create_and_return_hrf(hrf_beta_this_blind, temporal_resolution);

    hrf_beta_this_ctrl = hrf_beta_ctrl + randn(size(hrf_beta_ctrl)) * between_subject_std;
    hrf_this_ctrl = create_and_return_hrf(hrf_beta_this_ctrl, temporal_resolution);

    % generate data
    y_blind(:, iSub) = conv(hrf_this_blind, onset_vector);
    y_ctrl(:, iSub) = conv(hrf_this_ctrl, onset_vector);

end

% add constant and noise (to make things simple we add iid noise)
y_blind = y_blind + constant + randn(size(y_blind)) * noise_level;
y_ctrl = y_ctrl + constant + randn(size(y_ctrl)) * noise_level;

%% run GLM with a "standard" canonical
[hrf] = create_and_return_hrf([1 0 0], temporal_resolution);

% one regressor and one constant
design_matrix = conv(hrf, onset_vector);
design_matrix = [design_matrix, ones(size(design_matrix, 1), 1)];

figure('name', 'design matrix');
imagesc(design_matrix);
colormap('gray');

beta_hat_blind = y_blind \ design_matrix;
beta_hat_ctrl = y_ctrl \ design_matrix;

contrast = beta_hat_blind - beta_hat_ctrl;

figure('name', 'differences in group beta hat');
hold on;
errorbar([0.8 1.2], mean(contrast), std(contrast), '.b');
set(gca, 'xlim', [0.5 1.5]);
