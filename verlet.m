% number of bodies
N = 3;

% gravitational constant in reduced unit
G = 1;

% mass in reduced unit
m = [1; 1; 1];

% initial position in reduced unit
r = [[-0.97000436; 0.24308753], [0; 0], [0.97000436; -0.24308753]];

% initial velocity in reduced unit
v = [[0.4662036850; 0.4323657300], [-0.93240737; -0.86473146], [0.4662036850; 0.4323657300]];

% time step size and total time, in reduced unit
dt = 4;
T = 4;

% Setting up acceleration arrays that will be used later
acc = zeros(2,3)
nacc = zeros(2,3)
% Clearly mark each body's starting point
plot(r(1,1), r(2,1), 'k-*')
plot(r(1,2), r(2,2), 'k-+')
plot(r(1,3), r(2,3), 'k-o')
hold on

for t = 0:dt:T
    % Distances between bodies. Used for finding acceleration
    da12 = sqrt((r(1,1) - r(1,2))^2 + (r(2,1) - r(2,2))^2)
    da13 = sqrt((r(1,1) - r(1,3))^2 + (r(2,1) - r(2,3))^2)
    da23 = sqrt((r(1,2) - r(1,3))^2 + (r(2,2) - r(2,3))^2)
    
    
    % Calculate current acceleration
    acc(:,1) = ((1/(da12^3)) * (r(:,2) - r(:,1))) + ((1/(da13^3)) * (r(:,3) - r(:,1)));
    % acc(2,1) = ((1/(da12^3)) * (r(2,2) - r(2,1))) + ((1/(da13^3)) * (r(2,3) - r(2,1)));
    
    acc(:,2) = ((1/(da12^3)) * (r(:,1) - r(:,2))) + ((1/(da23^3)) * (r(:,3) - r(:,2)));
    % acc(2,2) = ((1/(da12^3)) * (r(2,1) - r(2,2))) + ((1/(da23^3)) * (r(2,3) - r(2,2)));

    acc(:,3) = ((1/(da13^3)) * (r(:,1) - r(:,3))) + ((1/(da23^3)) * (r(:,2) - r(:,3)));
    % acc(2,3) = ((1/(da13^3)) * (r(2,1) - r(2,3))) + ((1/(da23^3)) * (r(2,2) - r(2,3)));
    
    
    % Calculate new location
    r = r + v*dt + 0.5*acc*(dt^2) % next, find new_a with this new r

    
    % Calculate new distances using new locations (used for finding new acceleration)
    da12 = sqrt((r(1,1) - r(1,2))^2 + (r(2,1) - r(2,2))^2);
    da13 = sqrt((r(1,1) - r(1,3))^2 + (r(2,1) - r(2,3))^2);
    da23 = sqrt((r(1,2) - r(1,3))^2 + (r(2,2) - r(2,3))^2);
    
    
    % Calculate new acceleration using the new locations (using new distances)
    nacc(:,1) = ((1/(da12^3)) * (r(:,2) - r(:,1))) + ((1/(da13^3)) * (r(:,3) - r(:,1)));
    % acc(2,1) = ((1/(da12^3)) * (r(2,2) - r(2,1))) + ((1/(da13^3)) * (r(2,3) - r(2,1)));

    nacc(:,2) = ((1/(da12^3)) * (r(:,1) - r(:,2))) + ((1/(da23^3)) * (r(:,3) - r(:,2)));
    % acc(2,2) = ((1/(da12^3)) * (r(2,1) - r(2,2))) + ((1/(da23^3)) * (r(2,3) - r(2,2)));

    nacc(:,3) = ((1/(da13^3)) * (r(:,1) - r(:,3))) + ((1/(da23^3)) * (r(:,2) - r(:,3)));
    % acc(2,3) = ((1/(da13^3)) * (r(2,1) - r(2,3))) + ((1/(da23^3)) * (r(2,2) - r(2,3)));

    
    % Calculate new velocity
    v = v + (acc + nacc)/2 * dt;
    
    
    % Plotting on graph
    plot(r(1,1), r(2,1), 'y-*')
    plot(r(1,2), r(2,2), 'm-+')
    plot(r(1,3), r(2,3), 'g-o')
end