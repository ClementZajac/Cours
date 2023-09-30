function  fx_menu


% Modification : CS MARONI,  - 07/05/1998
%		 Mise en conformite avec Matlab 5 et WinnDD
% Il y a un probleme d'affichage sous windd avec la fonction chhoices.m 
% des auyteurs
% d'ou remplacement par la fonction choices.m de matlab


% Labels
%
labels = str2mat(                    ... 
	'x                            ', ...
 	'x.^2                         ', ...
	'1 - (x.^2)                   ', ...
	'(x.^2) - 2*(x.^3) + (5*x) - 3', ...
	'sin(x)                       ', ...
	'cos(x)                       ', ...
	'sinc(x)                      ', ...
	'sinc(x).^2                   ', ...
	'(1/sqrt(2*pi))*exp(-x.^2/2)  ', ...
	'(1/2)*exp(-abs(x))           ' );

% Callbacks
%
callbacks = [ ...
	'mc_int(''x'')                             '
	'mc_int(''x.^2'')                          '
	'mc_int(''1 - (x.^2)'')                    '
	'mc_int(''(x.^2) - 2*(x.^3) + (5*x) - 3'') '
	'mc_int(''sin(x)'')                        '
	'mc_int(''cos(x)'')                        '
	'mc_int(''sinc(x)'')                       '
	'mc_int(''sinc(x).^2'')                    '
	'mc_int(''(1/sqrt(2*pi))*exp(-x.^2/2)'')   '
	'mc_int(''(1/2)*exp(-abs(x))'')            '];

%chhoices('MONTE-CARLO', 'Available Functions', labels, callbacks );
choices('MONTE-CARLO', 'Available Functions', labels, callbacks );

