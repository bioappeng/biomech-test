 function xout = remove_noise(xin, samp_freq, cut_freq, n, low_high, plotme2)

% where
% xin = original signal
% samp_freq = sampling frequency (2000 for Mick's machine)
% cut_freq = cutoff frequency
% n = order of the filter
% xout = new signal with noise removed

% --------------------IN PROGRESS-------------------------------------


plotme = 0;
%plotme2 = 0; %This is now part of the function call

y = xin;

fs = samp_freq;


t = [0 : 1/fs : length(y)/fs - 1/fs];

if (plotme)
    figure(1)
    plot (t, y)
    xlabel('time (sec)'); ylabel('Amplitude'); title('Time-domain');
end

yfft = fft(y);

f = linspace (-samp_freq/2, samp_freq/2, length(y));


if (plotme)
    figure(2)
    plot (f, abs(yfft),'o')
    xlabel ('f (Hz)'); ylabel('|Y|'); title('Magnitude of Force');
end
% ----------------------------------------------------------------------
% Remove the offset from zero
[a,i] = max(abs(yfft));
yfft(i,1) = 0;


% ----------------------------------------------------------------------


if (plotme2)
    figure(3)
    hold off
    plot (f, fftshift(abs(yfft)),'o')
    xlabel ('f (Hz)'); ylabel('|Y|'); title('Magnitude of Force');
end


r = ifft(yfft);
r = real(r); %drop imaginary component b/c so small, negligible


if n ==0
    r_new = r;
else
    r_new = filter_data(r, samp_freq, cut_freq, n, low_high);
end

if (plotme2)
    n_yfft = fft(r_new);
    figure(3)
    hold on
    plot (f, fftshift(abs(n_yfft)),'k')
    xlabel ('f (Hz)'); ylabel('|Y|'); title('Magnitude of Force');
end

% ----------------------------------------------------------------------
% Compare the original signal with the filtered signal
if (plotme2)
    figure(4);
    plot(t,y,'g',t, r,'r',t,r_new,'k')
    xlabel('time (sec)'); ylabel('Amplitude'); title('New Time-domain')
end

xout = r_new;

if (plotme2)
pause
end
% ----------------------------------------------------------------------

