% Thời gian mô phỏng
Tfinal = 23;
tss = 0.1;
t = 0:tss:Tfinal;

% Góc Euler (rad)
phi   = zeros(size(t));              % Roll = 0
theta = zeros(size(t));              % Pitch = 0
psi   = 0.5 * sin(2*pi*t);            % Yaw theo sin

% Đạo hàm Euler angles
phi_dot   = gradient(phi, tss);
theta_dot = gradient(theta, tss);
psi_dot   = gradient(psi, tss);

% Tính toán p, q, r
p = phi_dot - sin(theta).*psi_dot;
q = cos(phi).*theta_dot + sin(phi).*cos(theta).*psi_dot;
r = -sin(phi).*theta_dot + cos(phi).*cos(theta).*psi_dot;

% Đạo hàm p, q, r
p_dot = gradient(p, tss);
q_dot = gradient(q, tss);
r_dot = gradient(r, tss);

% Gom tất cả vào ma trận B
% Cấu trúc: [phi, theta, psi, phi_dot, theta_dot, psi_dot, p, q, r, p_dot, q_dot, r_dot]
B = zeros(length(t), 12);
for i = 1:length(t)
    B(i,:) = [phi(i), theta(i), psi(i), ...
              phi_dot(i), theta_dot(i), psi_dot(i), ...
              p(i), q(i), r(i), ...
              p_dot(i), q_dot(i), r_dot(i)];
end

% Xóa biến phụ nếu cần
clear phi theta psi phi_dot theta_dot psi_dot p q r p_dot q_dot r_dot tss;
