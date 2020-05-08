function [estPi,N] = myPi(tol)
%myPi  Estimates Pi.
%   [ESTPI,N] = myPi(TOL) takes in a tolerance as an input argument and
%   returns an estimate for pi and the amount of points as output arguments
%
%   Note: Output argument names do not need to match.
%
%   Syntax:  [estPi,N] = myPi(tol)
%
%   Inputs:
%      tol - A defined tolerance value; how close two consecutive values
%      should be before the function terminates
%
%   Outputs:
%      estPi - An estimated value of Pi
%      N - The amount of points tested
%
%   Example:
%      [pi,points] = myPi(1e-5)
 
% Author: Richard Cheung
% 13 April 2020
 
    %% Initial Points
    
    format long         % Displays output with more significant figures
    N  = 10000;         % Initialise first 10000 points
    xN = rand(N,1);     % xN and yN are matrices with size Nx1 (10000x1)
    yN = rand(N,1);
    p  = xN.^2 + yN.^2; % Generates first 10000 points inside square
    hN = p < 1;         % If p < 1, it is a hit on the quarter circle
    HITS  = sum(hN);    % HITS tallies total hit count
    oldPi = 0;          % Initialise oldPi variable
    newPi = 4*(HITS/N); % pi can be calculated as 4*hits/points
 
    %% Check Tolerance
    
    % Checks if the difference between two consecutive values of pi are
    % greater than 2*tol and if so, repeats until it is less than 2*tol.
    while ( abs(newPi - oldPi) > 2*tol )
        xi = rand();
        xN = [xN;xi]; % Append xi value to xN matrix
        yi = rand();
        yN = [yN;yi]; % Append yi value to yN matrix
        p  = xi.^2 + yi.^2;
        hi = p < 1;
        hN = [hN;hi]; % Append hi value to hN matrix
        HITS = HITS + hi;
        N = N + 1;          % Increases counter
        oldPi = newPi;      % The previous value of pi becomes oldPi
        newPi = 4*(HITS/N); % newPi gets overwritten by a new value
    end
    
    estPi = newPi; % Set estPi as the final newPi value
    
    %% Plots
    
    % Plot quarter circle
    th = linspace(0,90); % Set 90 degree segment
    r  = 1;              % Radius of 1
    xc = r*cosd(th);     % Draws from centre
    yc = r*sind(th);
    plot(xc,yc)          % Plot quarter circle
    hold on
    
    % Plot square enclosing quarter circle
    plot([0 1 1 0 0],[0 0 1 1 0])
    axis equal off 
 
    % Plot hits in blue and misses in red
    plot(xN(hN) , yN(hN) , ".b", "MarkerSize", 1)
    plot(xN(~hN), yN(~hN), ".r", "MarkerSize", 1)
    
    % Additional text on figure
    text(0, 1.03, "tol = " + num2str(tol) + "    N = " + num2str(N), "FontSize", 14)
    text(0.8, 1.04, "A_S = 1;   A_{QC} = ^\pi/_4")
    text(0.5, -0.03, "1u", "FontSize", 14)
    text(-0.07, 0.5, "1u", "FontSize", 14)
end
