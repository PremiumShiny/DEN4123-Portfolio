%{
    FILE:   Refraction.m
    AUTHOR: Richard Cheung
    DATE:   30 March 2020
    DESC:   Program asks for user-defined values of n1, n2, and theta1
            checking whether a real solution exists for Snell's Law and
            thus, whether the ray experiences reflection or refraction.
            theta2 is then calculated and a plot is created showing both
            the incident and refracted (or reflected) ray.
            Handles catching of incorrect input types.
%}

%% User Inputs

% These statements ask for user-defined values.
% inputNum and inputDeg are custom functions for catching incorrect inputs.
n1 = inputNum('Enter the refractive index of medium 1: ');
n2 = inputNum('Enter the refractive index of medium 2: ');
th1 = inputDeg('Enter the angle of incidence of medium 1 in degrees: ');

%% Calculation

% Checks the value of sin(theta2). The value will determine whether the ray
% experiences reflection or refraction.
sinth2 = n1 / n2 * sind(th1);

if ( sinth2 > 1 ) % Total internal reflection
    th2 = th1;

    plotFigure(n1, n2, th1, sinth2, th2);
    plot([0 tand(th2)], [0 1], "b", "LineWidth", 2);
    text(0.02, 0.3, "\theta_2", "FontSize", 10);
    text(-0.25, 1, "Reflection", "FontSize", 16);
else % Refraction
    th2 = asind(sinth2);
    
    plotFigure(n1, n2, th1, sinth2, th2);
    plot([0 tand(th2)], [0 -1], "b", "LineWidth", 2);
    text(0.02, -0.3, "\theta_2", "FontSize", 10);
    text(-0.25, 1, "Refraction", "FontSize", 16);
end

%% Functions

% inputNum acts like the regular input with a condition to catch inputs
% that aren't numbers, displaying an error and asking the user again.
function ans = inputNum(z)
    str = '';
    NaN;
    while ( isnan(ans) )
        str2double(input([str, '', z], 's'));
        str = '\nPlease enter a number.\n';
    end
end

% inputDeg has the same function as inputNum but with the extra condition
% that the input must be less than 90, as refraction does not work with 
% angles greater than 90.
function ans = inputDeg(z)
    str = '';
    NaN;
    while ( isnan(ans) || ans >= 90 )
        str2double(input([str, '', z], 's'));
        str = '\nPlease enter a value less than 90.\n';
    end
end

% The plotFigure function has the intention of reducing lines from both
% reflection and refraction blocks of the if-else statement by adding all
% lines that are shared between both blocks into one function.
function plotFigure(n1, n2, th1, sinth2, th2)
    axis([-1 1 -1 1]);
    hold;
    plot([0 0], [-1 0.9], "k--");
    plot([-1 1], [0 0], "k", "LineWidth", 2);
    plot([-tand(th1) 0], [1 0], "b", "LineWidth", 2);
    axis off;
    text(-0.1, 0.3, "\theta_1", "FontSize", 10);
    text(-1, -0.7, ["n_1 = " + num2str(n1), "n_2 = " + num2str(n2), "\theta_1 = " + num2str(th1) + "^{\circ}", "sin(\theta_2) = " + num2str(sinth2) + "^{\circ}", "\theta_2 = " + num2str(th2) + "^{\circ}"], "FontSize", 10);
    % The final line displays all the input and calculated values in the
    % corner of the figure, acting as information to the user and useful
    % for debugging.
end
