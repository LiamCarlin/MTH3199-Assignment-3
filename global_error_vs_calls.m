tspan = [0,10];
h_guess = logspace(-3,-1,30);

methods = {@forward_euler_step, @backward_euler_step, ...
    @explicit_midpoint_step, @implicit_midpoint_step};

p = zeros(4,2);

for test = 1:2
    if test == 1
        func = @(t,X) -5*X + 5*cos(t) - sin(t);
        solution = @(t) cos(t);
    else
        func = @(t,X) [0,-1;1,0]*X;
        solution = @(t) [cos(t);sin(t)];
    end

    for method = 1:4
        h_values = zeros(size(h_guess));
        calls = zeros(size(h_guess)); 
        errors = zeros(size(h_guess));

        for j = 1:length(h_guess)
            [~,X_list,h,num_evals] = fixed_step_integration(func,methods{method},tspan,solution(0),h_guess(j));

            h_values(j) = h;
            calls(j) = num_evals;

            errors(j) = norm(X_list(end,:)' - solution(10));
        end

    use = h_values >= 0.002 & h_values <= 0.02;
    fit = polyfit(log10(calls(use)),log10(errors(use)),1);
    p(method,test) = fit(1);
    end
end

disp(p)