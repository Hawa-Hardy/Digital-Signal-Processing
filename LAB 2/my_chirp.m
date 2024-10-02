function [xx,tt] = mychirp( f1, f2, dur, fsamp )
%MYCHIRP generate a linear-FM chirp signal
%
% usage: xx = mychirp( f1, f2, dur, fsamp )
%
% f1 = starting frequency
% f2 = ending frequency
% dur = total time duration
% fsamp = sampling frequency (OPTIONAL: default is 11025)
%
% xx = (vector of) samples of the chirp signal
% tt = vector of time instants for t=0 to t=dur
%
    if( nargin < 4 ) %-- Allow optional input argument
    fsamp = 11025;
    end

dt= 1/fsamp;
dur = 1.8;
tt = 0 : dt : dur ;
f_step = (f2 -f1)/dur;
psi = pi*f_step*(tt.^2);
xx= cos(2*pi*f1*tt + psi);
soundsc(xx,fsamp)
end
