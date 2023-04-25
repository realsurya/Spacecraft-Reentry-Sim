clear;clc;close all force hidden;
alt = linspace(0,120000,100000);
t = [];

for i = 1:length(alt)
    t = [t, sonicspeed(temperature(i))];
end

plot(t,alt)