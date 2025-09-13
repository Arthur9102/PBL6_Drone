% ====== Khai báo biến symbolic ======
syms L mu H J Omega tr T0 kappa real

% ====== Góc 4 arms ======
thetas = [0, pi/2, pi, 3*pi/2];

% ====== Submatrix chuẩn  ======
B_std = [ -L*mu,   -J*Omega/tr,   H*T0;
           0,       H*T0,         J*Omega/tr;
           kappa,   L*T0,         0;
           mu,      0,            0];

% ====== Ma trận B (4x12) ======
B = sym(zeros(4,12));

for i = 1:4
    theta = thetas(i);

    % Copy submatrix
    B_i = B_std;

    % --- Xoay 2 hàng đầu bằng R(theta) ---
    R = [cos(theta), -sin(theta);
         sin(theta),  cos(theta)];
    B_i(1:2,:) = R * B_std(1:2,:);

    % --- Đổi dấu kappa cho rotor CW ---
    % Arm 1,3: CCW (+kappa), Arm 2,4: CW (-kappa)
    if mod(i,2) == 0
        B_i(3,1) = -B_i(3,1);
    end

    % --- Ghép vào B ---
    B(:, (3*i-2):(3*i)) = B_i;
end

% ====== Hiển thị kết quả ======
B = simplify(B)
