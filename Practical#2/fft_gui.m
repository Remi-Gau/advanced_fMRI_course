function fft_gui(signal, rt, HPF)
    % USAGE fft_gui(signal, rt, HPF)
    % signal
    % rt = repetition time in seconds
    % HPF = high pass filter in seconds

    gX = abs(fft(signal)).^2;

    gX = gX * diag(1 ./ sum(gX));

    q = size(gX, 1);

    Hz = [0:(q - 1)] / (q * rt);

    q = 2:fix(q / 2);

    plot(Hz(q), gX(q, :));

    % patch([0 1 1 0]/HPF,[0 0 1 1]*max(max(gX)),[1 1 1]*.9);

    xlabel('Frequency (Hz)');
    ylabel('relative spectral density');
    title(['Frequency domain', sprintf('\n'), ' {\bf', num2str(HPF), '}', ' second High-pass filter'], 'Interpreter', 'Tex');
    grid on;
    axis tight;
