function [cdf_out, x_out] = cdf(in,bin)

% CDF .........	Plots the sample cumulative distribution function (cdf).
%
%	CDF(X) plots the sample cdf of the input vector X with 100
%		equally spaced bins between the minimum and the maximum 
%		values of the input vector X.
%	CDF(X,N), where N is a scalar, uses N bins.
%	CDF(X,N), where N is a vector, draws a cdf using the bins
%		specified in N.
%	[F,x] = CDF(...) does not draw a graph, but returns vectors
%		F and x such that PLOT(x,F) is the sample cdf.
%
%	See also PDF,GAUSS_CDF,UNIFORM_CDF.

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
%	o	Changed the line for "discrete" cdf plotting that begins 
%		with ca = [ cdf_low, ... ] to [ cdf_upp ... ] and changed
%		"stairs" to "stair".......................... 91.08.20 MZ
%	o	Tested (and modified) under MATLAB 4.0/4.1 08.16.1993 MZ
%
% Modification : CS MARONI,  - 07/05/1998
%		 Mise en conformite avec Matlab 5 :
%		 Remplacement de :
%			if( strcmp(axis('state'),'auto') ), ...
%		 par :
%		  	if (strcmp(get(gca,'XlimMode'),'auto')) &
%		     (strcmp(get(gca,'YlimMode'),'auto')),
%
%    		Remplacement de : 
%			cdf_upp(ii) = sum( y(sel) )/max_y;
%    		par: 
%			cdf_upp(ii) = sum( y(find(sel)) )/max_y;
% 		idem avec cdf_low
%===========================================================================

%------------------------------------------------------------------------
%	Define parameters
%------------------------------------------------------------------------
nx_default = 100;
axis_default = 1;
flag = 'continuous';
%------------------------------------------------------------------------
%	Prepare absicca vector and other parameters
%------------------------------------------------------------------------
if (nargin == 1)
    nx    = nx_default;
    max_x = nx_default;
else
    nx    = bin;
    if (length(bin) > 1), max_x = length(bin); else, max_x = bin; end
end
max_y = length(in);

[y,x]  = hist(in,nx);
if ( length(y(y~=0)) <= 10 ), flag = 'discrete'; end

sel    = zeros(1,max_x);
for ii = 1:max_x
   % cdf_upp(ii) = sum( y(sel) )/max_y;
    cdf_upp(ii) = sum( y(find(sel)) )/max_y;
        sel(ii) = 1;
    %cdf_low(ii) = sum( y(sel) )/max_y;
    cdf_low(ii) = sum( y(find(sel)) )/max_y;
end
out = 0.5*(cdf_upp+cdf_low);
%------------------------------------------------------------------------
%	Output routines
%------------------------------------------------------------------------
if nargout == 0
    xmin = min(x)-axis_default; xmax = max(x) + axis_default;
    if  strcmp(flag, 'discrete')
	   delta = max(diff(x));
	   extra = round(axis_default/delta);
	   xa = [x,([1:extra]*delta + max(x))];
	   ca = [ cdf_upp, ones(size([1:extra])) ];
	   stair(xa,ca), ...
	   grid on,      ...
      % if( strcmp(axis('state'),'auto') ), 
	if (strcmp(get(gca,'XlimMode'),'auto')) &	     		(strcmp(get(gca,'YlimMode'),'auto')),
	axis([xmin xmax 0 1]); end; ...
       title('Sample CDF')
    elseif  strcmp(flag, 'continuous')
	   plot(x,out), ...
	   grid on,      ...
      % if( strcmp(axis('state'),'auto') ), 
	if (strcmp(get(gca,'XlimMode'),'auto')) &	     (strcmp(get(gca,'YlimMode'),'auto')),
		axis([xmin xmax 0 1]); end; ...
	   title('Sample CDF')
    end
elseif nargout == 1
    cdf_out = out;
else
    cdf_out = out;
    x_out   = x;
end
