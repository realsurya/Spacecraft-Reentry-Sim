function ydot = OrbitEOMS(t, y, Cd, mu, LD, Re, m, S)
    % This file depicts the EOMs for Planar Flight over a spherical
    % nonrotating planet to be used for reentry. See parameters list.
    % AAE 338 Final Project - Surya M. (smanikha@purdue.edu)
        % Cd: Spacecraft drag coeff
        % mu: Gravitational parameter of orbiting body
        % LD: Spacecraft Lift to Drag Ratio
        % Re: Radius of orbiting body
        % m: Mass of spacecraft
        % S: cross sectional area of object
    
    % State Variables   
    v = y(1);
    gamma = y(2);
    s = y(3);
    r = y(4);
    rho = density((r/1000)-Re);

    % Spacecraft Aerodynamic Model
    D = 0.5 * rho * (v^2) * S * Cd;
    L = LD * D;

    % Gravitational Model
    g = 9.8;

    % Diff EQs
    dvdt = (-D/m) - (g*sin(gamma));
    dgammadt = ((L/m) - ((g - ((v^2)/r))*cos(gamma)))/v;
    dsdt = (Re/r)*v*cos(gamma);
    drdt = v*sin(gamma);

    % State Matrix
    ydot = [dvdt;dgammadt;dsdt;drdt];
end