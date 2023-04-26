%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     AAE 338 Final Project         %
% Group 17 - Soyuz Reentry Analysis %
%  Surya M - smanikha@purdue.edu    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;close all force hidden;

% This main script runs the reentry simulation by leveraging EOMs found in
% OrbitEoms.m and the initial conditions laid out in this file.
%   Dependencies:
%       - OrbitEoms.m : Reentry planar flight EOMS implementation
%       - temperature.m : ISA implementation for atmospheric temperature
%       - density.m : CIRA Ref. Atm. Model implementation for atm density
%       - sonicspeed.m : Calcualte sonic speed at a certain altitude

% Soyuz Entry ICs:
    entryAlt =  122*1000; % Height of initial thermal interface (m)
    fpa =  (-1.35)*(pi/180); % Initial flight path angle of Soyuz (rad)
    vi =  7870; % Initial velocity at thermal interface (m/s)

% Soyuz Properties
    cd = 1.3; % Drag coeff at trim condition
    ld = .25; % Lift to Drag Ratio of Spacecraft
    Ac = (pi/4) * (2.2^2); % Capsule cross sectional area (m^2)
    m = 2900; % descent module mass (kg)

% Simulation Parameters
    Re = 6376; % Radius of Earth (km)
    mu = 3.986e5; % Gravitational Parameter of Earth
    tf = 20*60; % Final time (sec)
    t = linspace(0,tf, 10000); % Time array (sec)
    stop_alt = 10; % stop at this altitude (km)
    options = odeset('RelTol',1e-12, 'AbsTol',1e-12);

% Run Simulation
    [t,y] = ode45(@(t,y) OrbitEOMS(t,y,cd,mu,ld,Re,m,Ac), ...
        [0,tf], [vi, fpa, 0, entryAlt+(Re*1000)],options);

% Extract values:
    R = y(:,4); % Radius result array
    boolArr = (R-(Re*1000)) > 0; % boolean array to get values where h > 0
    V = y(:,1); % Velocity result array
    Gamma = y(:,2)*(180/pi); % FPA result array
    S = y(:,3); % Downrange travel result array
    h = R-(Re*1000); % Height result array
    a = sonicspeed(h); % sonnic speed at each point in trajectory
    M = V ./ a; % Mach number at each point in trajectory

% Calculate Reentry Heating
    v_excl = V(boolArr);
    q = .02.*(.08/4).*(density( ... % Calculate instantaneous heat flux
        h(boolArr)./1000)).*(power(v_excl,3));

    Tim = 29; % Initial spacecraft temp condition bounds (C)
    Tiu = 30;
    Til = 28;
    cp = 700; % Spacecraft specific heat capacity

    x = t(boolArr);
    y = q;
    Q = [];
    for idx = 2:length(y) % integrate q to fid heat addition Q
        Q = [Q; trapz(x(1:idx), y(1:idx))*(6.8/2)];
    end

    dT = Q ./(m*cp); % find temperature curve Q = mcpdt

 % Plot Reentry Heat Information
    figure();
    subplot(3,1,1);
    plot(t(boolArr), q/1000, 'LineWidth',2);
    grid on;
    xlabel('Time (sec)');
    ylabel('Heat Flux (kW/m^2)')
    title('Heat Flux Imparted to Soyuz Vs. Time')

    subplot(3,1,2);
    plot(x(2:end), Q, 'LineWidth',2);
    grid on;
    xlabel('Time (sec)');
    ylabel('Heat Transfer (Joules)')
    title('Cumulative Heat Transfer (Energy Addition) to Soyuz Vs. Time') 

    subplot(3,1,3); hold on;
    plot(x(2:end), Tim+dT, 'LineWidth',2, 'LineStyle', '-');
    plot(x(2:end), Til+dT, 'LineWidth',1, 'LineStyle', '--', Color='Red');
    plot(x(2:end), Tiu+dT, 'LineWidth',1, 'LineStyle', '--', Color='Red');
    grid on; legend(["Soyuz Internal Temp (Mid)","Lower/Upper Bounds"]);
    xlabel('Time (sec)');
    ylabel('Spacecraft Internal temp (C)')
    title('Internal Temperature of Soyuz Vs. Time') 

% Plot Reentry Trajectory:
    figure();
    subplot(4,1,1);
    plot(S(boolArr)./1000, h(boolArr)./1000, 'LineWidth',2);
    grid on;
    xlabel('Downrange Distance Travelled (km)');
    ylabel('Height (km)');
    title("Soyuz Spacecraft Re-entry Profile")

    subplot(4,1,2);
    plot(t(boolArr), V(boolArr), 'LineWidth',2);
    grid on;
    xlabel('Time (sec)');
    ylabel('Velocity (m/s)')
    title('Velocity Magnitude of Soyuz Vs. Time')
    
    subplot(4,1,3);
    plot(t(boolArr), h(boolArr)./1000, 'LineWidth',2);
    grid on;
    xlabel('Time (sec)');
    ylabel('Height (km)');
    title("Height of Soyuz Vs. Time")
    
    subplot(4,1,4);
    plot(t(boolArr), M(boolArr), 'LineWidth',2);
    grid on;
    xlabel('Time (sec)');
    ylabel('Mach Number')
    title('Mach Number of Soyuz Vs. Time')

% Plot internal temp with safety regions:
    figure(); hold on;
    plot(x(2:end), Tim+dT, 'LineWidth',2, 'LineStyle', '-');
    plot(x(2:end), Til+dT, 'LineWidth',1, 'LineStyle', '--', Color='black');
    plot(x(2:end), Tiu+dT, 'LineWidth',1, 'LineStyle', '--', Color='black');
    yline(40, 'g-', 'LineWidth',2);
    yline(53, 'r-', 'LineWidth',2);
    grid on; 
    legend(["Soyuz Internal Temp (Mid)","Lower/Upper Internal Temp Bounds",...
            "", "Human Safety Threshold", "Extreme Danger Threshold"]);
    xlabel('Time (sec)');
    ylabel('Spacecraft Internal temp (C)');
    title('Internal Temperature of Soyuz Vs. Time (With Human Survivability Limits)');

% Old Plots, No longer needed: 
    %figure();
    %plot(t(boolArr), ccoeff(boolArr), 'LineWidth',2);
    %grid on;
    %xlabel('Time (sec)');
    %ylabel('Conv heat Transfer Coeff (W/m^2*k)')
    %title('Conv heat Transfer Coeff of Spacecraft Vs. Time')
    
    %figure();
    %plot(t(boolArr), Gamma(boolArr));
    %grid on;
    %xlabel('Time (sec)');
    %ylabel('FPA (deg)');
    %title('FPA of Spacecraft Vs. Time');
    
    %figure();
    %plot(t(boolArr), S(boolArr));
    %grid on;
    %xlabel('Time (sec)');
    %ylabel('Downrange (m)');
    %title("Downrange Motion of Spacecraft Vs. Time")
    
    
    %tmod = t(boolArr);
    %figure();
    %plot(tmod(2:end), (diff(V(boolArr))./diff(t(boolArr)))/9.8);
    %grid on;
    %xlabel('Time (sec)');
    %ylabel('G Loading (g)');
    %title("Axial Loading of Spacecraft Vs. Time");