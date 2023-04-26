function a = sonicspeed(h)
    %:sonicspeed: Returns sonic speed at altitude h through
        %         International Standard Atmosphere
    % AAE 338 Final Project - Surya M. (smanikha@purdue.edu)
        %:param h float: Height above MSL (m)
        %:return a float: Sonic speed at altitude (m/s)

        gamma = 1.4;
        R = 287;
        T = temperature(h);
        a = sqrt(gamma*R*T); % simple formula to calculate sonic speed
end
