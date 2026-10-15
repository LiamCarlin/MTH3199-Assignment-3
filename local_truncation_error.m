% Step sizes and reference time from the assignment
h_list = logspace(-5,1,100);
t_ref = 0.492;

step_funcs = {@forward_euler_step, @backward_euler_step, ...
    @explicit_midpoint_step, @implicit_midpoint_step};

% rows are analytical change, forward Euler, backward Euler, explicit midpoint, implicit midpoint
p_values = zeros(5,2);

for test = 1:2
    if test == 1
        rate_func = @(t,X) -5*X + 5*cos(t) - sin(t);
        solution = @(t) cos(t);
    else
        rate_func = @(t,X) [0,-1;1,0]*X;
        solution = @(t) [cos(t);sin(t)];
    end

    errors = zeros(5,length(h_list));

    for j = 1:length(h_list)
        h = h_list(j);
        XA = solution(t_ref);
        X_exact = solution(t_ref+h);

        errors(1,j) = norm(X_exact-XA);

        for method = 1:4
            step_func = step_funcs{method};

            [XB,~] = step_func(rate_func,t_ref,XA,h);
            errors(method+1,j) = norm(XB-X_exact);
        end
    end

    fit_range = h_list >= 0.002 & h_list <= 0.02;

    for row = 1:5
        fit_values = polyfit(log10(h_list(fit_range)), ...
            log10(errors(row,fit_range)),1);

        p_values(row,test) = fit_values(1);
    end
end

Method = {'Analytical change'; 'Forward Euler'; 'Backward Euler'; 'Explicit Midpoint'; 'Implicit Midpoint'};

results = table(Method,p_values(:,1),p_values(:,2), 'VariableNames',{'Method','Test1_p','Test2_p'});

disp(results)