% Run with test_implicit_step([0,10], 1, [0.01, 0.1, 0.45]), for some
% reason, like at h_guess = 0.4 its still very accurate but at h_guess = 0.5, it
% goes bananas. Do not know why, if someone can explain, be my guest.
function test_implicit_step(step_func, tspan,X0,h_guess)
    figure;
    t = linspace(tspan(1), tspan(2), 100);
    colors = {'r', 'b', 'g'};
    info = {'--', 'o', "-"};
    func = @(t, X) rate_func01(t, X);

    plot(t, solution01(t), "k*", "DisplayName", "Analytical Solution"); hold on
    
    for i=1:max(size(h_guess))

        [t_list,X_list,~, ~] = fixed_step_integration(func,step_func,tspan,X0,h_guess(i));

        plot(t_list, X_list, info{i}, "Color", colors{i}, "DisplayName", sprintf("Step Ref. - %f", h_guess(i)));
    end

    xlabel("Integration Time Span $(t)$", 'Interpreter','Latex');
    ylabel("Solutions $(X)$", 'Interpreter','Latex');
    ylim([-3 1.25])
    legend("Location","northeast");
    if step_func == backward_euler_step
        title("Backward Euler Step Integration vs Analytical Solution", 'Interpreter','Latex');
    else
        title("Implicit Midpoint Step Integration vs Analytical Solution", 'Interpreter','Latex');
    end
    hold off;

end

function dXdt = rate_func01(t,X)
    dXdt = -5*X + 5*cos(t) - sin(t);
end

function X = solution01(t)
    X = cos(t);
end