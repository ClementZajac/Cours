function [out] = xor(x,y)

% XOR .........	Exclusive OR function.
%
%	[C] = XOR(A,B) returns C based on the "exclusive-or" operation:
%
%			A	B    |    C
%		     ----------------+--------
%			0	0    |    0
%			0	1    |    1
%			1	0    |    1
%			1	1    |    0

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
global BELL;
global WARNING;

check;

if (nargin ~= 2)
   error(eval('eval(BELL),eval(WARNING),help xor'));
   return;
end

out = ~(x==y);
