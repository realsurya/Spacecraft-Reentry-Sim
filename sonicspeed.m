function a = sonicspeed(h)
    %:sonicspeec: Returns sonic speed at altitude h through
        %          International Standard Atmosphere
        %:param h float: Height above MSL (m)
        %:return a float: Sonic speed at altitude (m/s)
        gamma = 1.4;
        R = 287;
        T = temperature(h);
        a = sqrt(gamma*R*T);

end
