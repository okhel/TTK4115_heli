function plotResultsOBS()
    clc;
    init_heli_3_10();

    disp('Loading data...');
    data = struct();

    % L poles spread along a 30 degree arc
    data.L_arc = struct();
    data.L_arc.test1 = load('results/part3/results_(r5,30deg_euler).mat');              % 5 radius
    data.L_arc.test2 = load('results/part3/results_(r50,30deg_euler).mat');             % 50 radius
    data.L_arc.test3 = load('results/part3/results_(r500,30deg_euler).mat');            % 500 radius
    

    % L as tight radius, normal radius, and spaced reals, 
    data.L_types = struct();
    data.L_type.test1 = load('results/part3/results_(r500,30deg_euler).mat');           % tight radius
    % data.L_type.test2 = load('results/part3/results_(r500,3deg_euler).mat');            % normal radius
    data.L_type.test2 = load('results/part3/results_(r500_spaced_euler).mat');          % spaced reals
    

    % Observer with IMU vs encoders measurements
    data.imu_vs_enc = struct();
    data.imu_vs_enc.test1 = load('results/part3/results_(r500,30deg_euler).mat');       % IMU
    data.imu_vs_enc.test2 = load('results/part3/results_(r500,30deg_encoder).mat');     % Encoders
    data.imu_vs_enc.test3 = load('results/part2/Integral_lqr/results_(lqr_int_10_Id).mat'); % w/o observer

    
    %% Processing
    t = data.L_arc.test1.ans(1,:);
    idx_first_30 = find(t == 27, 1, 'first');

    t = t(1:idx_first_30);
    p_c = data.L_arc.test1.ans(2,1:idx_first_30);
    
    % Tests that the reference is identical for each test
    for i = 1:size(data.L_arc, 1)
        if (~isequal(data.imu_vs_enc(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for L arc test', num2str(i)]);
        end
    end
    for i = 1:size(data.L_type, 1)
        if (~isequal(data.L_type(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for L type test', num2str(i)]);
        end
    end

    %% L poles spread along a 30 degree arc

    disp('Plotting scaled Q Id matrix...');

    figure(1); clf; hold on; grid on;
    p1 = data.L_arc.test1.ans(3,1:idx_first_30);
    p2 = data.L_arc.test2.ans(3,1:idx_first_30);
    p3 = data.L_arc.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'R = 5', 'R = 50', 'R = 500'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('L poles spread along a 30 degree arc');

    %% L type

        disp('Plotting L type...');
        
        figure(2); clf; hold on; grid on;
        p1 = data.L_type.test1.ans(3,1:idx_first_30);
        p2 = data.L_type.test2.ans(3,1:idx_first_30);
        % p3 = data.L_type.test3.ans(3,1:idx_first_30);
        plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
        plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
        % plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
        legend({'30 deg arc', 'Spaced reals (overdamped)'}, 'Interpreter', 'latex');
        xlabel('Time [s]');
        ylabel('Position [rad]');
        xlim([0, 27]);
        ylim([-0.2, 0.6]);
        title('Types of L poles');

        disp('Done!');

    %% Observer with IMU vs encoders measurements

    disp('Plotting observer with IMU vs encoders measurements...');
        
    figure(3); clf; hold on; grid on;
    p1 = data.imu_vs_enc.test1.ans(3,1:idx_first_30);
    p2 = data.imu_vs_enc.test2.ans(3,1:idx_first_30);
    p3 = data.imu_vs_enc.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'IMU', 'Encoders', 'w/o observer'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('Observer with IMU vs encoders measurements');

    disp('Done!');
end

