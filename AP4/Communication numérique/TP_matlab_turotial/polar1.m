function polar(theta,rho,line_style)
%POLAR	Polar coordinate plot.
%	POLAR(THETA, RHO) makes a plot using polar coordinates of
%	the angle THETA, in radians, versus the radius RHO.
%	POLAR(THETA,RHO,S) uses the linestyle specified in string S.
%	See PLOT for a description of legal linestyles.
%
%	See also PLOT, LOGLOG, SEMILOGX, SEMILOGY.

%	Copyright (c) 1984-92 by The MathWorks, Inc.

if nargin < 1
	error('Requires 2 or 3 input arguments.')
elseif nargin == 2 
	if isstr(rho)
		line_style = rho;
		rho = theta;
		[mr,nr] = size(rho);
		if mr == 1
			theta = 1:nr;
		else
			th = (1:mr)';
			theta = th(:,ones(1,nr));
		end
	else
		line_style = 'auto';
	end
elseif nargin == 1
	line_style = 'auto';
	rho = theta;
	[mr,nr] = size(rho);
	if mr == 1
		theta = 1:nr;
	else
		th = (1:mr)';
		theta = th(:,ones(1,nr));
	end
end
if isstr(theta) | isstr(rho)
	error('Input arguments must be numeric.');
end
if any(size(theta) ~= size(rho))
	error('THETA and RHO must be the same size.');
end

% get hold state
cax = newplot;
next = lower(get(cax,'NextPlot'));
hold_state = ishold;

% get x-axis text color so grid is in same color
tc = get(cax,'xcolor');

% only do grids if hold is off
if ~hold_state

% make a radial grid
	hold on;
	hhh=plot([0 max(theta(:))],[0 max(abs(rho(:)))],':');
	v = [get(cax,'xlim') get(cax,'ylim')];
	ticks = length(get(cax,'ytick'));
	%delete(hhh);
% check radial limits and ticks
	rmin = 0; rmax = v(4); rticks = ticks-1;
	if rticks > 5	% see if we can reduce the number
		if rem(rticks,2) == 0
			rticks = rticks/2;
		elseif rem(rticks,3) == 0
			rticks = rticks/3;
		end
	end

% define a circle
	th = 0:pi/50:2*pi;
	xunit = cos(th);
	yunit = sin(th);

	rinc = (rmax-rmin)/rticks;
	for i=(rmin+rinc):rinc:rmax
		plot(xunit*i,yunit*i,':','color',tc);
		%text(0,i+rinc/20,['  ' num2str(i)],'verticalalignment','bottom');
	end

% plot spokes
	th = (1:6)*2*pi/12;
	cst = cos(th); snt = sin(th);
	cs = [-cst; cst];
	sn = [-snt; snt];
	plot(rmax*cs,rmax*sn,':','color',tc);

% annotate spokes in degrees
	rt = 1.1*rmax;
	for i = 1:max(size(th))
		%text(rt*cst(i),rt*snt(i),int2str(i*30),'horizontalalignment','center');
		if i == max(size(th))
			loc = int2str(0);
		else
			loc = int2str(180+i*30);
		end
	%	text(-rt*cst(i),-rt*snt(i),loc,'horizontalalignment','center');
	end

% set viewto 2-D
	view(0,90);
% set axis limits
	axis(rmax*[-1 1 -1.1 1.1]);
end

% transform data to Cartesian coordinates.
xx = rho.*cos(theta);
yy = rho.*sin(theta);

% plot data on top of grid
if strcmp(line_style,'auto')
	plot(xx,yy)
else
	plot(xx,yy,line_style)
end
if ~hold_state
	axis('equal');axis('off');
end

% reset hold state
if ~hold_state, set(cax,'NextPlot',next); end

