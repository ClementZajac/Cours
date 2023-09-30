function temperature(in)

% TEMPERATURE ..... Sample function representing average day-time temperature.
%
%    TEMPERATURE(N) generates a sample function representing the average 
%		day-time temperature of each day from June 1 to Aug. 31.
%    	The autocorrelation function of the sample (temperature) 
%		function is also plotted if the input argument N = 0.
%
%    TEMPERATURE  When the function is used without the input argument, 
%		it will plot a sample only when you hit the RETURN key.
%
%    See also	NEW_BORN

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
%	o	Tested (and modified) under MATLAB 4.0/4.1 08.16.1993 MZ
%===========================================================================

y = corr_seq(0.9,1092,3,0) + 26;
x = y(1001:1092);
x = x(:);
index1 = find(x>33);
index2 = find(x<19);
x(index1) = 33*ones(1,size(index1)) + randn(1,size(index1));
x(index2) = 19*ones(1,size(index2)) + randn(1,size(index2));
plot(1,1); ...
axis([1 92 15 40]), ...
grid on; ...
xlabel('Time period: June 1 to August 31'), ...
ylabel('degree [Celsius]'), ...
title('TEMPERATURE');
hold on
if(nargin == 0)
  for n=11:82
	for k=1:10
	   plot([1:k],x(1:k)); plot(k,x(k),'*');
	end
	yy = menu('OPTIONS','Plot ALL data & CLOSE this menu', ...
						'Plot the NEXT data point', ... 
						'CLOSE this menu');
	if (yy == 3)
	  break;
	elseif (yy == 2)
	  plot([1:n],x(1:n)); plot(n,x(n),'*');
	  if(n <31) fprintf('Temperature on June %3.0f is %6.2f.\n',n,x(n));
	  elseif(n < 62) 
		 fprintf('Temperature on July %3.0f is %6.2f\n.',n-30,x(n));
      else
		 fprintf('Temperature on Aug. %3.0f is %6.2f\n.',n-61,x(n));
	  end
	elseif (yy == 1)
      for k=1:82
         plot([1:k],x(1:k)); plot(k,x(k),'*');
      end
	  break;
	end
  end
elseif(nargin == 1)
  plot([1:92],x(1:92)); plot([1:92],x(1:92),'*');
  hold off
  ry = acf(y-mean(y),20,'norm');
  subplot(212)
  plot([-10:10],ry(11:31)), grid on; ...
  xlabel('Number of days'), ...
  ylabel('ACF'), ...
  title('TEMPERATURE');
  hold off
end
hold off
