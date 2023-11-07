% Main idea of Verlet's solution: approx. v_n+1 = (a_n + a_n+1)/2 * dt
% Vectors for each body are stored as matrix's columns (i.e. Body 1's position is
% 1st column of r matrix)

%% Figure 8 Periodic "Solution": 
% a special case of the 3-BP that uses
% "reduced" units for bodies' mass, gravitational constant, position,
% velocity...
% The main idea is that you can set very specific (see super precise
% decimals in intialization) initial velocities and positions for each of
% the 3 bodies so they move in a figure-8!



%% Initial setup
% Number of bodies
N = 3;

% Grav. constant in "reduced unit"
G = 1;

% Vector of masses, "reduced unit"
m = [1; 1; 1];

% Initial positions
r = [[-0.97000436; 0.24308753], [0;0], [0.97000436; -0.24308753]];

% Initial velocities
v = [[0.4662036850; 0.4323657300], [-0.93240737; -0.86473146], [0.4662036850; 0.4323657300]];

% Initial accelerations
a = [[0;0], [0;0], [0;0]];
a_next = a;  % will store a_(t+1)

% Plot initial positions
hold on 
plot(r(1,1), r(2,1), 'k-o', 'MarkerSize', 10)
plot(r(1,2), r(2,2), 'k-o', 'MarkerSize', 10)
plot(r(1,3), r(2,3), 'k-o', 'MarkerSize', 10)

% Timesteps desired
T = 5;
dt = 0.02;


%% Calculating at each timestep
for t = 0:dt:T
    % Find distances [vect] and absolute lengths [scl] between each body ---- t
    dist_1to2 = r(:,2) - r(:,1);
    length_1to2 = sqrt(dist_1to2' * dist_1to2);
    dist_2to3 = r(:,3) - r(:,2);
    length_2to3 = sqrt(dist_2to3' * dist_2to3);
    dist_3to1 = r(:,1) - r(:,3);
    length_3to1 = sqrt(dist_3to1' * dist_3to1);

    % Find new acceleration of each body [vect] ----- t
    % Example: finding accel of body 1
    % a1 = sum F's on 1 / m1. Sum F's on 1 is: (Force on 1 from 2 + -Force
    % on 3 from 1)
    a(:, 1) = (G*m(2)/length_1to2^3)*(r(:,2) - r(:,1)) + (G*m(3)/length_3to1^3)*(r(:,3) - r(:,1));
    a(:, 2) = (G*m(1)/length_1to2^3)*(r(:,1) - r(:,2)) + (G*m(3)/length_2to3^3)*(r(:,3) - r(:,2));
    a(:, 3) = (G*m(1)/length_3to1^3)*(r(:,1) - r(:,3)) + (G*m(2)/length_2to3^3)*(r(:,2) - r(:,3));

    % Find r_t+1 using r_t, v_(t), and a_t
    % Basic kinematics: x = x0 + v0*t + 1/2*a*t^2
    % r_t+1 = r_t + v_t*dt + 0.5*a_t*dt^2
    r = r + v*dt + 0.5*a*(dt^2);

    % Using similar steps above, find a_(t+1) - acceleration at new positn
    dist_1to2 = r(:,2) - r(:,1);
    length_1to2 = sqrt(dist_1to2' * dist_1to2);
    dist_2to3 = r(:,3) - r(:,2);
    length_2to3 = sqrt(dist_2to3' * dist_2to3);
    dist_3to1 = r(:,1) - r(:,3);
    length_3to1 = sqrt(dist_3to1' * dist_3to1);

    a_next(:, 1) = (G*m(2)/length_1to2^3)*(r(:,2) - r(:,1)) + (G*m(3)/length_3to1^3)*(r(:,3) - r(:,1));
    a_next(:, 2) = (G*m(1)/length_1to2^3)*(r(:,1) - r(:,2)) + (G*m(3)/length_2to3^3)*(r(:,3) - r(:,2));
    a_next(:, 3) = (G*m(1)/length_3to1^3)*(r(:,1) - r(:,3)) + (G*m(2)/length_2to3^3)*(r(:,2) - r(:,3));

    % Find v_t+1 = (a_t+1 + a_t)/2 * dt
    % Basic kinematics: v_t+1 ~= v_t + a_avg * dt
    v = v + (a + a_next)/2 * dt;

    % Plot new positions
    plot(r(1,1), r(2,1), 'r-*')
    plot(r(1,2), r(2,2), 'g-+')
    plot(r(1,3), r(2,3), 'b-o')

end