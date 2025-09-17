% --- Giả sử bạn đã có ma trận B từ GenerateB.m ---
% Cấu trúc B: [phi, theta, psi, phi_dot, theta_dot, psi_dot, p, q, r, p_dot, q_dot, r_dot]

AttPts = B;

% Thông số
TakeOffTime = 1;
XYflyTime = 2;
tss = 0.1;
Tfinal = XYflyTime + tss*(length(AttPts)-1);
t = 0:tss:Tfinal;

%% Roll (phi)
sigRoll = [t;0*t];
for i = 1:length(sigRoll)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigRoll(2,i) = 0;
    else
        sigRoll(2,i) = AttPts(i-startindex+1,1); % phi
    end
end
rollcmd = timeseries(sigRoll(2:end,:),sigRoll(1,:));

%% Pitch (theta)
sigPitch = [t;0*t];
for i = 1:length(sigPitch)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigPitch(2,i) = 0;
    else
        sigPitch(2,i) = AttPts(i-startindex+1,2); % theta
    end
end
pitchcmd = timeseries(sigPitch(2:end,:),sigPitch(1,:));

%% Yaw (psi)
sigYaw = [t;0*t];
for i = 1:length(sigYaw)
    startindex = (XYflyTime/tss)+1;
    if i < startindex
        sigYaw(2,i) = 0;
    else
        sigYaw(2,i) = AttPts(i-startindex+1,3); % psi
    end
end
yawcmd = timeseries(sigYaw(2:end,:),sigYaw(1,:));

%% Roll_dot, Pitch_dot, Yaw_dot
rolldotcmd  = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,4)']', t');
pitchdotcmd = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,5)']', t');
yawdotcmd   = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,6)']', t');

%% p, q, r
pcmd = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,7)']', t');
qcmd = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,8)']', t');
rcmd = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,9)']', t');

%% p_dot, q_dot, r_dot
pcmd_d = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,10)']', t');
qcmd_d = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,11)']', t');
rcmd_d = timeseries([zeros(1,(XYflyTime/tss)) AttPts(:,12)']', t');

%% Vẽ thử yaw, yawdot, r
figure;
subplot(3,1,1);
plot(yawcmd.Time, squeeze(yawcmd.Data), 'b', 'LineWidth',1.5);
xlabel('Time [s]'); ylabel('Yaw [rad]'); grid on; title('Yaw command');

subplot(3,1,2);
plot(yawdotcmd.Time, squeeze(yawdotcmd.Data), 'r', 'LineWidth',1.5);
xlabel('Time [s]'); ylabel('Yaw dot [rad/s]'); grid on; title('Yaw rate command');

subplot(3,1,3);
plot(rcmd.Time, squeeze(rcmd.Data), 'k', 'LineWidth',1.5);
xlabel('Time [s]'); ylabel('r [rad/s]'); grid on; title('Body yaw rate r command');
