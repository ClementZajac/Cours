function [carrier] = osc(fc,ph)

% OSC .........	Sinusoid generating oscillator.
%
%	OSC(fc,Phase) generates the sinusoidal waveform:
%           
%	             sin(2*pi*fc*t + Phase);
%
%	OSC(fc) assumes Phase = 0.

%	AUTHORS : M. Zeytinoglu & N. W. Ma
%             Department of Electrical & Computer Engineering
%             Ryerson Polytechnic University
%             Toronto, Ontario, CANADA
%
%	DATE    : August 1991.
%	VERSION : 1.0

%===========================================================================
% Modifications history:
% ----------------------
%	o   Added "checking"  11.30.1992 MZ
%	o	Tested (and modified) under MATLAB 4.0/4.1 08.16.1993 MZ
%===========================================================================

global START_OK;
global SAMPLING_CONSTANT;
global SAMPLING_FREQ;
global BINARY_DATA_RATE;
global BELL;
global WARNING;

check;

if ((nargin < 1) | (nargin > 2))
   error(eval('eval(BELL),eval(WARNING),help osc'));
   return;
end

phase = 0;
if(nargin == 2) phase = (ph/360)*2*pi; end

t = [1:50000]/SAMPLING_FREQ;
tphase = 2*pi*t*fc + phase;
carrier = sin(tphase);
