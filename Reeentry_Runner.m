clear;clc;close all force hidden;

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
    [t,y] = ode45(@(t,y) OrbitEOMS(t,y,cd,mu,ld,Re,m,Ac), [0,tf], [vi, fpa, 0, entryAlt+(Re*1000)],options);

% Extract values:
    R = y(:,4);
    boolArr = (R-(Re*1000)) > 0;
    V = y(:,1);
    Gamma = y(:,2)*(180/pi);
    S = y(:,3);
    h = R-(Re*1000);

% Plot stuff:
figure();
plot(t(boolArr), V(boolArr));
grid on;
xlabel('Time (sec)');
ylabel('Velocity (m/s)')
title('Velocity of Spacecraft Vs. Time')

figure();
plot(t(boolArr), Gamma(boolArr));
grid on;
xlabel('Time (sec)');
ylabel('FPA (deg)');
title('FPA of Spacecraft Vs. Time');

figure();
plot(t(boolArr), S(boolArr));
grid on;
xlabel('Time (sec)');
ylabel('Downrange (m)');
title("Downrange Motion of Spacecraft Vs. Time")

figure();
plot(t(boolArr), h(boolArr));
grid on;
xlabel('Time (sec)');
ylabel('Height (m)');
title("Height of Spacecraft Vs. Time")

tmod = t(boolArr);
figure();
plot(tmod(2:end), (diff(V(boolArr))./diff(t(boolArr)))/9.8);
grid on;
xlabel('Time (sec)');
ylabel('G Loading (g)');
title("Axial Loading of Spacecraft Vs. Time");

figure();
plot(S(boolArr), h(boolArr));
grid on;
xlabel('Downrange (m)');
ylabel('Height (m)');
title("Reentry Profile of Spacecraft")
