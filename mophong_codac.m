% Mô phỏng quá trình cô đặc với hai đơn vị
clear all;
clc;

% Tham số hệ thống (giá trị giả định)
W0 = 50;      % Tốc độ dòng khối lượng vào (kg/h)
X0 = 0.3;      % Nồng độ đầu vào (phần khối lượng, 30%)
VI = 4;       % Thể tích của đơn vị I (m³)
VII = 4;      % Thể tích của đơn vị II (m³)
W1 = 25;       % Tốc độ dòng khối lượng từ I đến II (kg/h)
Wp = 17.644;       % Tốc độ dòng khối lượng sản phẩm (kg/h)
V1 = W0 - W1;  % Tốc độ dòng thể tích nước bay hơi từ I (kg/h)
V2 = W1 - Wp;  % Tốc độ dòng thể tích nước bay hơi từ II (kg/h)

% Thời gian mô phỏng
tspan = [0 2]; % Từ 0 đến 2 giờ

% Điều kiện ban đầu
X1_0 = 0.3;    % Nồng độ ban đầu ở đơn vị I
Xp_0 = 0.6;    % Nồng độ ban đầu ở đơn vị II
X0_init = [X1_0; Xp_0];

% Hàm định nghĩa hệ ODEs
dXdt = @(t, X) [
    (W0 * X0 - W1 * X(1)) / VI;         % dX1/dt
    (W1 * X(1) - Wp * X(2)) / VII       % dXp/dt
];

% Giải hệ ODEs bằng ode45
[t, X] = ode45(dXdt, tspan, X0_init);

% Trích xuất kết quả
X1 = X(:,1); % Nồng độ ở đơn vị I
Xp = X(:,2); % Nồng độ ở đơn vị II

% Vẽ đồ thị
figure;
subplot(2,1,1);
plot(t, X1, 'b-', 'LineWidth', 2);
xlabel('Thời gian (h)');
ylabel('Nồng độ X_1');
title('Nồng độ ở đơn vị I theo thời gian');
grid on;

subplot(2,1,2);
plot(t, Xp, 'r-', 'LineWidth', 2);
xlabel('Thời gian (h)');
ylabel('Nồng độ X_p');
title('Nồng độ ở đơn vị II (Sản phẩm) theo thời gian');
grid on;

% Hiển thị giá trị cuối cùng
fprintf('Nồng độ cuối cùng ở đơn vị I (X_1): %.4f\n', X1(end));
fprintf('Nồng độ cuối cùng ở đơn vị II (X_p): %.4f\n', Xp(end));