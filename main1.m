disp('Simulation Started')

%Get Planet parameters %
earth 

altitude = 10*254*1.6*1000; %[m]
x0 = R + altitude;
y0 = 0;
z0 = 0;
xdot0 = 0;
inclination = 51.6*pi/180;
semi_major = norm([x0; y0; z0]);

vcircular = sqrt(mu/semi_major);
ydot0 = vcircular*cos(inclination);
zdot0 = -vcircular*sin(inclination);
stateinitial = [x0, y0, z0, xdot0, ydot0, zdot0];

%Time window %

period = 2*pi/sqrt(mu)*semi_major^(3/2);
number_of_orbits = 1;
tspan = [0 period*number_of_orbits];


[tout, stateout] = ode45(@satellite, tspan, stateinitial);

% convert state to kil%
stateout = stateout/1000;

%extract state vector %
xout = stateout(:,1);
yout = stateout(:,2);
zout = stateout(:,3);

% make earth % 

[X,Y,Z] = sphere;
X = X*R/1000;
Y = Y*R/1000;
Z = Z*R/1000;

%plot 3D orbit
fig = figure();
set(fig,'color', 'white');
plot3(xout, yout, zout, 'm-','LineWidth', 1);
grid on
hold on
surf(X,Y,Z)
axis equal
