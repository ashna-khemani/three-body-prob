% Main idea of Verlet's solution: approx. v_n+1 = (a_n + a_n+1)/2 * dt

%% Initial setup
% Number of bodies
N = 3;

% Grav. constant [N*m^2 / kg^2]
G = 6.67*10^-11;

% Vector of masses, 10^30 kg
m = [10^30, 10^30, 10^30];

% Initial positions
r = {[-10, 10], [0,0], [10,-10]};

% Initial velocities
v = {[0,0], [0,0], [0,0]};

% Initial accelerations
a = {[0,0], [0,0], [0,0]};

% Timesteps desired
T = 50;

%% Calculating
for dt = 0:1:50
    % Find distances [vect] and absolute lengths [scl] between each body ---- t
    dist_1to2 = r{1,2} - r{1,1};
    length_1to2 = sqrt(dist_1to2 * dist_1to2');
    dist_2to3 = r{1,3} - r{1,2};
    length_2to3 = sqrt(dist_2to3 * dist_2to3');
    dist_3to1 = r{1,1} - r{1,3};
    length_3to1 = sqrt(dist_3to1 * dist_3to1');
    
    % Find force on each body [vect] ------ t
    F_1and2 = (G*m(1)*m(2) / length_1to2^3) * dist_1to2;
    F_2and3 = (G*m(2)*m(3) / length_2to3^3) * dist_2to3;
    F_3and1 = (G*m(3)*m(1) / length_3to1^3) * dist_3to1;

    % Find acceleration of each body [vect] ----- t
    a_1 = (F_1and2 + F_3and1) / m(1);
    a_2 = (F_1and2 + F_2and3) / m(2);
    a_3 = (F_2and3 + F_3and1) / m(3);

    % Find r_t+1: use velocity of t-1, accel of t 
    

end