function plotResultsLQR()
    clc;
    init_heli_3_10();

    disp('Loading data...');
    data = struct();

    % R as Id

    % Q as Id, scaling it 
    data.Q_scaled_Id = struct();
    data.Q_scaled_Id.test1 = load('results/part2/LQR/results_(lqr_Id).mat'); % Id
    data.Q_scaled_Id.test2 = load('results/part2/LQR/results_(lqr_10Id).mat'); % 10 Id
    data.Q_scaled_Id.test3 = load('results/part2/LQR/results_(lqr_100_Id).mat'); % 100 Id

    % Q as 10Id, scaling x_1 = p
    data.punish_p = struct();
    data.punish_p.test1 = load('results/part2/LQR/results_(lqr_1_10_10_Id).mat'); % punish p: 1
    data.punish_p.test2 = load('results/part2/LQR/results_(lqr_10Id).mat'); % punish p: 10
    data.punish_p.test3 = load('results/part2/LQR/results_(lqr_100_10_10_Id).mat'); % punish p: 100

    % punishing Q as 100Id, vs Q as 10Id and R as 0.1Id
    data.Q_vs_R = struct();
    data.Q_vs_R.test1 = load('results/part2/LQR/results_(lqr_10_01).mat');
    data.Q_vs_R.test2 = load('results/part2/LQR/results_(lqr_100_Id).mat');

    %% Processing
    t = data.Q_scaled_Id.test1.ans(1,:);
    idx_first_30 = find(t == 27, 1, 'first');

    t = t(1:idx_first_30);
    p_c = data.Q_scaled_Id.test1.ans(2,1:idx_first_30);

    plot(t,p_c)
    
    % Tests that the reference is identical for each test
    for i = 1:size(data.Q_scaled_Id, 1)
        if (~isequal(data.Q_scaled_Id(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for scaled Q Id test', num2str(i)]);
        end
    end
    for i = 1:size(data.punish_p, 1)
        if (~isequal(data.punish_p(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for punish p test', num2str(i)]);
        end
    end

    for i = 1:size(data.Q_vs_R, 1)
        if (~isequal(data.Q_vs_R(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for Q vs R test', num2str(i)]);
        end
    end

    %% Scaled Q Id matrix

    disp('Plotting scaled Q Id matrix...');

    figure(1); clf; hold on; grid on;
    p1 = data.Q_scaled_Id.test1.ans(3,1:idx_first_30);
    p2 = data.Q_scaled_Id.test2.ans(3,1:idx_first_30);
    p3 = data.Q_scaled_Id.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'Q = $\mathbb{I}_d$', 'Q = 10 $\mathbb{I}_d$', 'Q = 100 $\mathbb{I}_d$'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('Scaled Q Id matrix', 'Interpreter', 'latex');

    %% Punish p in 10 Id matrix

    disp('Plotting punish p in 10 Id matrix...');
    
    figure(2); clf; hold on; grid on;
    p1 = data.punish_p.test1.ans(3,1:idx_first_30);
    p2 = data.punish_p.test2.ans(3,1:idx_first_30);
    p3 = data.punish_p.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'Punish p = 1', 'Punish p = 10', 'Punish p = 100'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('Punish p in 10 Id matrix');

    %% Q vs R matrix

    disp('Plotting Q vs R matrix...');
    
    figure(3); clf; hold on; grid on;
    p1 = data.Q_vs_R.test1.ans(3,1:idx_first_30);
    p2 = data.Q_vs_R.test2.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    % plot(t4, p4, 'LineWidth', 2);
    legend({'Q = 10 $\mathbb{I}_d$, R = 0.1 $\mathbb{I}_d$', 'Q = 100 $\mathbb{I}_d$, R = $\mathbb{I}_d$'}, 'Interpreter', 'latex');
    title('Q vs R matrix');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);

    disp('Done!');
end

