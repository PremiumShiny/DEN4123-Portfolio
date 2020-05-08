%{
    FILE:   Taylor.m
    AUTHOR: Richard Cheung
    DATE:   17 April 2020
    DESC:   Program asks the user to input a function and the order it
			should be approximated to. The Taylor approximation will then get
			returned.
%}

clear % Clears the workspace
clc   % Clears the command window

syms x y h k % Defines x, y, h, and k as symbolic variables

%% User Inputs

disp("This program calculates the Nth order Taylor approximation of a function near (x0,y0)")

f = input('Enter a function of x and y to be approximated:\n');

N = inputNum('What order should the function be approximated to? ');

%% P Matrix
% Binomial matrix

syms Pf(n,m) % Defines n and m as local variables to Pf

P = sym(zeros()); % Initialises P matrix

Pf(n,m) = 1/(factorial(n-m)*factorial(m)); % Value for current element

% Goes through row, then each column up to diagonal then moves to next row
for ( n = 0 : N )
    for ( m = 0 : n )
        P(n+1,m+1) = Pf(n,m); % Stores values in each element
    end
end

%% C Matrix
% Matrix with polynomial terms h^(n-m)*k^m

syms Cf(n,m) % Defines n and m as local variables to Cf

C = sym(zeros()); % Initialises C matrix

Cf(n,m) = h^(n-m)*k^m; % Value for the current element

% Goes through row, then each column up to diagonal then moves to next row
for ( n = 0 : N )
    for ( m = 0 : n )
        C(n+1,m+1) = Cf(n,m); % Stores values in each element
    end
end

%% D Matrix
%Partial derivative of input function

D = sym(zeros()); % Initialises D matrix

% Goes through row, then each column up to diagonal then moves to next row
for ( n = 0 : N )
    for ( m = 0 : n )
        D(n+1,m+1) = diff(f,x,n-m); % Vertical elements differentiate wrt x
        D(n+1,m+1) = diff(D(n+1,m+1),y,m); % Diagonal differentiate wrt y
    end
end

%% Taylor Approximation
    
T0 = P.*C.*D;              % Multiplying the three matrices
T1 = sum(sum(T0));         % Summing them together
T2 = subs(T1,{x,y},{0,0}); % Substituting {x,y} with {0,0}

disp('Taylor Approximation:')
disp(T2)
pretty(T2)
%% Functions

function ans = inputNum(n)
% ans must be numeric; Min value = 1; No max value 
    str = '';
    NaN;
    while ( isnan(ans) || ans < 1 )
        str2double(input([str, '', n], 's'));
        str = '\nPLEASE ENTER A VALUE GREATER THAN 1\n';
    end
end

%{
function inputFunc(n)
    pattern = ["x","y"];
    existXY = contains(f,pattern)
    
    while ( ~existXY )
        fprintf('\nPLEASE ENTER A FUNCTION CONTAINING x AND y ONLY\n');
        f = input('Enter a function of x and y to be approximated:\n','s');
        existXY = contains(f,pattern)
    end

    f = str2sym(f);
end
%}