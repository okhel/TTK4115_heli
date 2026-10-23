function plotResultsKalman()
    clc;
    init_heli_3_10();

    disp('Loading data...');
    data = struct();

    % Q_d as Id
    data.large_Q_d = struct();
    data.large_Q_d.test2 = load('results/part4/results(kalman_Q_Id_).mat');
    data.large_Q_d.test1 = load('results/part4/results(encoder_Q_Id_).mat');
    
    % Q_d as 1e-11 Id
    data.small_Q_d = struct();
    data.small_Q_d.test2 = load('results/part4/results(kalman_Q_Id_neg11_).mat');
    data.small_Q_d.test1 = load('results/part4/results(encoder_Q_Id_neg11_).mat');
    

    % No new data
    data.no_new_data = struct();
    data.no_new_data.test2 = load('results/part4/results(kalman_Q_Id_).mat');
    data.no_new_data.test1 = load('results/part4/results(encoder_Q_Id_).mat');

    
    %% Processing
    t = data.large_Q_d.test1.ans(1,:);
    idx_first_30 = find(t == 27, 1, 'first');

    t = t(1:idx_first_30);
    
    %% Large Q_d

    disp('Plotting large Q_d...');

    % encoder measurements
    enc_p = data.large_Q_d.test1.ans(2,1:idx_first_30);
    enc_Dp = data.large_Q_d.test1.ans(3,1:idx_first_30);
    enc_e = data.large_Q_d.test1.ans(4,1:idx_first_30);

    % kalman estimates
    kalman_p = data.large_Q_d.test2.ans(2,1:idx_first_30);
    kalman_Dp = data.large_Q_d.test2.ans(3,1:idx_first_30);
    kalman_e = data.large_Q_d.test2.ans(4,1:idx_first_30);

    
    figure(1); clf; hold on; grid on;

    ax1 = subplot(3,1,1);
    title('Pitch angle');
    hold on;
    plot(t, kalman_p, 'LineWidth', 1, 'Color', colors{1});
    plot(t, enc_p, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([-0.2, 1]);
    
    ax2 = subplot(3,1,2);
    title('Pitch rate');
    hold on;
    plot(t, kalman_Dp, 'LineWidth', 1, 'Color', colors{2});
    plot(t, enc_Dp, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle rate [rad/s]');
    ylim([-0.5, 2]);
    
    ax3 = subplot(3,1,3);
    title('Elevation angle');
    hold on;
    plot(t, kalman_e, 'LineWidth', 1, 'Color', colors{3});
    plot(t, enc_e, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([0, 1.5]);

    linkaxes([ax1, ax2, ax3], 'x');
    xlabel('Time [s]');
    xlim([5, 12]);

    %% Large Q_d

    disp('Plotting large Q_d...');

    % encoder measurements
    enc_p = data.small_Q_d.test1.ans(2,1:idx_first_30);
    enc_Dp = data.small_Q_d.test1.ans(3,1:idx_first_30);
    enc_e = data.small_Q_d.test1.ans(4,1:idx_first_30);

    % kalman estimates
    kalman_p = data.small_Q_d.test2.ans(2,1:idx_first_30);
    kalman_Dp = data.small_Q_d.test2.ans(3,1:idx_first_30);
    kalman_e = data.small_Q_d.test2.ans(4,1:idx_first_30);

    
    figure(2); clf; hold on; grid on;

    ax1 = subplot(3,1,1);
    title('Pitch angle');
    hold on;
    plot(t, kalman_p, 'LineWidth', 1, 'Color', colors{1});
    plot(t, enc_p, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([-0.2, 1]);
    
    ax2 = subplot(3,1,2);
    title('Pitch rate');
    hold on;
    plot(t, kalman_Dp, 'LineWidth', 1, 'Color', colors{2});
    plot(t, enc_Dp, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle rate [rad/s]');
    ylim([-0.5, 2]);
    
    ax3 = subplot(3,1,3);
    title('Elevation angle');
    hold on;
    plot(t, kalman_e, 'LineWidth', 1, 'Color', colors{3});
    plot(t, enc_e, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([0, 1.5]);

    linkaxes([ax1, ax2, ax3], 'x');
    xlabel('Time [s]');
    xlim([5, 12]);

    %% No new data

    disp('Plotting no new data...');

    t = data.large_Q_d.test1.ans(1,:);
    % t = t(idx_first_30:end);

    % encoder measurements
    enc_p = data.no_new_data.test1.ans(2,:);
    enc_Dp = data.no_new_data.test1.ans(3,:);
    enc_e = data.no_new_data.test1.ans(4,:);

    % kalman estimates
    kalman_p = data.no_new_data.test2.ans(2,:);
    kalman_Dp = data.no_new_data.test2.ans(3,:);
    kalman_e = data.no_new_data.test2.ans(4,:);
        
    figure(3); clf; hold on; grid on;

    ax1 = subplot(3,1,1);
    title('Pitch angle');
    hold on;
    plot(t, kalman_p, 'LineWidth', 1, 'Color', colors{1});
    plot(t, enc_p, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([-0.2, 1]);
    
    ax2 = subplot(3,1,2);
    title('Pitch rate');
    hold on;
    plot(t, kalman_Dp, 'LineWidth', 1, 'Color', colors{2});
    plot(t, enc_Dp, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle rate [rad/s]');
    ylim([-0.5, 2]);
    
    ax3 = subplot(3,1,3);
    title('Elevation angle');
    hold on;
    plot(t, kalman_e, 'LineWidth', 1, 'Color', colors{3});
    plot(t, enc_e, 'k--', 'LineWidth', 2);
    legend('Kalman', 'Encoder');
    ylabel('Angle [rad]');
    ylim([0, 1.5]);

    linkaxes([ax1, ax2, ax3], 'x');
    xlabel('Time [s]');
    xlim([35, 50]);

    disp('Done!');
end

