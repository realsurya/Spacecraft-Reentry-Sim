function temp = temperature(h)
    %:temperature: Returns temperature at altitude h through
        %          International Standard Atmosphere
        %:param h float: Height above MSL (m)
        %:return temp float: Temperature at altitude h (kelvin)

    alt = [-1000, 0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 15000, 20000, 25000, 30000, 40000, 50000, 60000, 70000, 80000,90000,100000,105000,110000,115000,120000,125000,130000];
    TRef = [21.5, 15, 8.5, 2, -4.49, -10.98, -17.47, -23.96, -30.45, -36.94, -43.42, -49.9, -56.5, -56.5, -51.6, -46.64, -22.8, -2.5, -26.13, -53.57, -74.51,-86.28,-78.07,-64.31,-33.15,26.85,85.85,144.08,196.12];

    T = interp1(alt, TRef, h, "spline","extrap");
    temp = T+298;
end