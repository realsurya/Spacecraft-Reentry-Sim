function h = convcoeff(M)
    %:convcoeff: Returns convection heat transfer coefficient at
        %        Mach Number
        %:param M float: Mach Number
        %:return temp float: Conv. Heat Transf Coeff h (W/m^2*k)

    %     Linear model Poly3:
    %          f(x) = p1*x^3 + p2*x^2 + p3*x + p4
    %     Coefficients (with 95% confidence bounds):
    %            p1 =    0.003676  (-0.002166, 0.009518)
    %            p2 =     -0.1932  (-0.2904, -0.09588)
    %            p3 =       3.418  (2.946, 3.889)
    %            p4 =       4.937  (4.308, 5.566)
    %     
    %     Goodness of fit:
    %       SSE: 0.1029
    %       R-square: 0.9996
    %       Adjusted R-square: 0.9994
    %       RMSE: 0.131

   p1 =    0.003676;
   p2 =     -0.1932;
   p3 =       3.418;
   p4 =       4.937;
   h = p1.*M.^3 + p2.*M.^2 + p3.*M + p4;
end