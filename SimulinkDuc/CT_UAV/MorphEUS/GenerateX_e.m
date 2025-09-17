% Thời gian mô phỏng
Tfinal = 23;
tss = 0.1;
t = 0:tss:Tfinal;

% Quỹ đạo (x, y, z)
x = 2*sin(0.3*t);
y = 2 - 2*cos(0.3*t);
z = 3 + 1*sin(0.6*t);

% Vận tốc (vx, vy, vz) - đạo hàm bậc 1
vx = 0.6*cos(0.3*t);        % dx/dt
vy = 0.6*sin(0.3*t);        % dy/dt
vz = 0.6*cos(0.6*t);        % dz/dt

% Gia tốc (ax, ay, az) - đạo hàm bậc 2
ax = -0.18*sin(0.3*t);      % d2x/dt2
ay =  0.18*cos(0.3*t);      % d2y/dt2
az = -0.36*sin(0.6*t);      % d2z/dt2

% Gom tất cả vào ma trận A
% Cấu trúc: [x, y, z, vx, vy, vz, ax, ay, az]
A = zeros(length(t),9);
for i = 1:length(t)
    A(i,:) = [x(i), y(i), z(i), vx(i), vy(i), vz(i), ax(i), ay(i), az(i)];
end

% Xóa biến phụ không cần thiết
clear x y z vx vy vz ax ay az tss;