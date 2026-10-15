% Run with test_implicit_step([0,10], 1, [0.01, 0.1, 0.45]), for some
% reason, like at h_guess = 0.4 its still very accurate but at h_guess = 0.5, it
% goes bananas. Do not know why, if someone can explain, be my guest.
function test_implicit_step(step_func,tspan,X0,h_guess)
    figure();
    t = linspace(tspan(1),tspan(2),1000);
    colors = {'r','b','m'};
    func = @(t,X) rate_func01(t,X);

    if isequal(step_func,@backward_euler_step)
        method_name = 'Backward Euler';
        filename = 'backward_euler_verification.png';
    else
        method_name = 'Implicit Midpoint';
        filename = 'implicit_midpoint_verification.png';
    end

    plot(t,solution01(t),'k-','LineWidth',2, 'DisplayName','Analytical solution');
    hold on

    for i = 1:length(h_guess)
        [t_list,X_list,h,~] = ...
            fixed_step_integration(func,step_func,tspan,X0,h_guess(i));

        plot(t_list,X_list,'--','Color',colors{i}, 'LineWidth',1.5, 'DisplayName',sprintf('%s, h = %.3f',method_name,h));
    end

    xlabel('Time, t (-)','Interpreter','latex');
    ylabel('Solution, x(t) (-)','Interpreter','latex');
    title([method_name ' vs. Analytical Solution'],'Interpreter','latex');

    set(gca,'FontSize',16,'TickLabelInterpreter','latex');
    legend('Interpreter','latex','FontSize',14, 'Location','southoutside','NumColumns',2);

    xlim(tspan);
    grid on
    box on
    hold off

    exportgraphics(gcf,filename,'Resolution',600);
end

function dXdt = rate_func01(t,X)
    dXdt = -5*X + 5*cos(t) - sin(t);
end

function X = solution01(t)
    X = cos(t);
end