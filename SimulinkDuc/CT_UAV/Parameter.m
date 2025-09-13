clear
clc
g = 10; %m/s^2
AUM = 3.057; %kg
Ixx = 0.049827; %kg mm^2
Iyy = 0.048993; %kg mm^2
Izz = 0.082777; %kg mm^2
Ixy = 0.12; %kg mm^2
Ixz = 0.35; %kg mm^2
Iyz = 0.295; %kg mm^2
Ct = 0.013;
Cq = 0.013;
L = 0.3;           % Chiều dài arm (m)
H = 0.05;           % Chiều cao hub (m)
rho = 1.18195;
R = 0.1525; %mm
W = diag([0.994, 0.003, 0.003, 0.994, 0.003, 0.003, ...
          0.994, 0.003, 0.003, 0.994, 0.003, 0.003]);
R_rad = 0.1905;

% uavthamso.geom.g = 10;
% uavthamso.aero.Ct = 0.013;