 % --- Giả sử bạn đã có A từ GenerateA.m ---
% Cấu trúc A: [x, y, z, vx, vy, vz, ax, ay, az]

PathPts = A;

% Thông số
TakeOffTime = 1;
XYflyTime = 2;
tss = 0.1;
Tfinal = XYflyTime + tss*(length(PathPts)-1);
t = 0:tss:Tfinal;

%% Vị trí (cũ giữ nguyên)
sigZ = [t;0*t];
for i = 1:length(sigZ)
    takeoffindex = (TakeOffTime/tss)+1;
    startindex = (XYflyTime/tss)+1;
    if i < takeoffindex
        sigZ(2,i) = 0;
    elseif i < startindex
        sigZ(2,i) = PathPts(1,3);
    else
        sigZ(2,i) = PathPts(i-startindex+1,3);
    end
end
          
sigX = [t;0*t];
sigY = [t;0*t];
for i = 1:length(sigX)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigX(2,i) = 0;
        sigY(2,i) = 0;
    else
        sigX(2,i) = PathPts(i-startindex+1,1);
        sigY(2,i) = PathPts(i-startindex+1,2);
    end
end

Xcmd = timeseries(sigX(2:end,:),sigX(1,:));
Ycmd = timeseries(sigY(2:end,:),sigY(1,:));
Zcmd = timeseries(sigZ(2:end,:),sigZ(1,:));

%% Vận tốc
sigVx = [t;0*t];
sigVy = [t;0*t];
sigVz = [t;0*t];
for i = 1:length(sigVx)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigVx(2,i) = 0;
        sigVy(2,i) = 0;
        sigVz(2,i) = 0;
    else
        sigVx(2,i) = PathPts(i-startindex+1,4); % vx
        sigVy(2,i) = PathPts(i-startindex+1,5); % vy
        sigVz(2,i) = PathPts(i-startindex+1,6); % vz
    end
end

Vxcmd = timeseries(sigVx(2:end,:),sigVx(1,:));
Vycmd = timeseries(sigVy(2:end,:),sigVy(1,:));
Vzcmd = timeseries(sigVz(2:end,:),sigVz(1,:));

%% Gia tốc
sigAx = [t;0*t];
sigAy = [t;0*t];
sigAz = [t;0*t];
for i = 1:length(sigAx)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigAx(2,i) = 0;
        sigAy(2,i) = 0;
        sigAz(2,i) = 0;
    else
        sigAx(2,i) = PathPts(i-startindex+1,7); % ax
        sigAy(2,i) = PathPts(i-startindex+1,8); % ay
        sigAz(2,i) = PathPts(i-startindex+1,9); % az
    end
end

Axcmd = timeseries(sigAx(2:end,:),sigAx(1,:));
Aycmd = timeseries(sigAy(2:end,:),sigAy(1,:));
Azcmd = timeseries(sigAz(2:end,:),sigAz(1,:));


%% Vẽ kết quả so sánh X - Vx - Ax
figure;
subplot(3,1,1);
plot(Xcmd.Time, squeeze(Xcmd.Data), 'b', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('X [m]');
title('Quỹ đạo theo trục X');
grid on;

subplot(3,1,2);
plot(Vxcmd.Time, squeeze(Vxcmd.Data), 'r', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Vx [m/s]');
title('Vận tốc theo trục X');
grid on;

subplot(3,1,3);
plot(Axcmd.Time, squeeze(Axcmd.Data), 'k', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Ax [m/s^2]');
title('Gia tốc theo trục X');
grid on;

%% Y
figure;
subplot(3,1,1);
plot(Ycmd.Time, squeeze(Ycmd.Data), 'b', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Y [m]');
title('Quỹ đạo theo trục Y');
grid on;

subplot(3,1,2);
plot(Vycmd.Time, squeeze(Vycmd.Data), 'r', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Vy [m/s]');
title('Vận tốc theo trục Y');
grid on;

subplot(3,1,3);
plot(Aycmd.Time, squeeze(Aycmd.Data), 'k', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Ay [m/s^2]');
title('Gia tốc theo trục Y');
grid on;

%% Z
figure;
subplot(3,1,1);
plot(Zcmd.Time, squeeze(Zcmd.Data), 'b', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Z [m]');
title('Quỹ đạo theo trục Z');
grid on;

subplot(3,1,2);
plot(Vzcmd.Time, squeeze(Vzcmd.Data), 'r', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Vz [m/s]');
title('Vận tốc theo trục Z');
grid on;

subplot(3,1,3);
plot(Azcmd.Time, squeeze(Azcmd.Data), 'k', 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('Az [m/s^2]');
title('Gia tốc theo trục Z');
grid on;
