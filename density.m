function rho = density(h)
    %:density: Returns density at altitude h through
    %          CIRA Reference Atmosphere Model.
    %          Valid up to 180 km
    % AAE 338 Final Project - Surya M. (smanikha@purdue.edu)
    %:param h float: Height above MSL (km)
    %:return rho float: Density at altitude h (kg/m^3)
    % See : https://www.spaceacademy.net.au/watch/debris/atmosmod.htm
    
    a0 = 7.001985e-2; % Define polynomial fit coefficients
    a1 = -4.336216e-3;
    a2 = -5.009831e-3;
    a3 = 1.621827e-4;
    a4 = -2.471283e-6;
    a5 = 1.904383e-8;
    a6 = -7.189421e-11;
    a7 = 1.060067e-13;
    
    polyfn = ((((((a7.*h + a6).*h + a5).*h + a4).*h + a3).*h + a2)...
            .*h + a1).*h + a0;
    rho = 10.^polyfn; % Calculate density at h using 7th order polynomial.
end