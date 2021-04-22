function [hrf] = create_and_return_hrf(hrf_beta, temporal_resolution)

    % Temporal resolution in seconds of the informed basis set you are going to create
    xBF.dt = temporal_resolution;
    xBF.name = 'hrf (with time and dispersion derivatives)';

    % Length of the HRF in seconds
    xBF.length = 32;
    xBF.order = 1;

    % Creates the informed basis set
    xBF = spm_get_bf(xBF);

    % HRF + Temporal derivative of the HRF + Dispersion derivative of the HRF
    hrf = hrf_beta(1) * xBF.bf(:, 1) + ...
           hrf_beta(2) * xBF.bf(:, 2) + ...
           hrf_beta(3) * xBF.bf(:, 3);

end
