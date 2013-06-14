function filt_cal = filter_data(data, samp_freq, cut_freq, n, low_high)


%%%%%%%%%  Draft - in need of fixing.  %%%%%%%%%%%%%%


%   Filter data using digital low pass filter with zero phase shift. Data
%   is the data to be filtered. samp_freq is the sampling frequency.
%   cut_freq is the cutoff frequency. n is order of the filter. See Matlab
%   documentation on fir filters and filtfilt for more information.

nyq_freq = (samp_freq);%/2;             %Nyquist frequency

cut_freq_norm = cut_freq./nyq_freq;  %cutoff frequency scaled for use with 
                                    %fir type filter
b = fir1(n,cut_freq_norm,low_high);
filt_cal = filtfilt(b,1,data);      %apply coefficients to data
%figure
%freqz(b,1,256,samp_freq);               %plots filter response if desired
end
